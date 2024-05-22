import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../API/models/message.models.dart';
import '../../API/provider/chat_provider.dart';
import 'package:echirp/utils/global_variables.dart';
import '../../API/models/group.models.dart';
import '../../API/provider/user_provider.dart';
import '../../screens/group/components/group_detail.dart';

class ChatScreen extends StatelessWidget {
  final String id;
  final String title;
  final String image;
  final List<Participant>? participants;
  final int index;
  final bool myGroups;

  const ChatScreen({
    Key? key,
    required this.title,
    required this.image,
    required this.id,
    required this.participants,
    required this.index,
    required this.myGroups,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatProvider(),
      child: _ChatScreenContent(
        id: id,
        title: title,
        image: image,
        participants: participants,
        index: index,
        myGroups: myGroups,
      ),
    );
  }
}

class _ChatScreenContent extends StatefulWidget {
  final String id;
  final String title;
  final String image;
  final List<Participant>? participants;
  final int index;
  final bool myGroups;

  const _ChatScreenContent({
    Key? key,
    required this.id,
    required this.title,
    required this.image,
    required this.participants,
    required this.index,
    required this.myGroups,
  }) : super(key: key);

  @override
  __ChatScreenContentState createState() => __ChatScreenContentState();
}

class __ChatScreenContentState extends State<_ChatScreenContent> {
  late TextEditingController _controller;
  late ChatProvider _chatProvider;
  late String userId = "";

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    userId = getUserId();
  }

  String getUserId() {
    return Provider.of<UserProvider>(context, listen: false)
            .userData
            ?.user
            ?.id ??
        "";
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _chatProvider = Provider.of<ChatProvider>(context);
    _chatProvider.fetchMessages(widget.id);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
        ),
        title: GestureDetector(
          onTap: () => Navigator.of(context)
              .pushNamed(GroupDetailsPage.routeName, arguments: {
            'index': widget.index,
            'myGroups': widget.myGroups,
          }),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/dummyDP.png'),
              ),
              const SizedBox(width: 8),
              Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: GlobalVariables.colors.primary,
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ChatProvider>(
              builder: (context, chatProvider, _) {
                final messages = chatProvider.messages;
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return _buildMessage(messages[index]);
                  },
                );
              },
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return Container(
      color: Colors.grey[200],
      height: MediaQuery.of(context).size.height * 0.12,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            const ProfilePicture(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  controller: _controller,
                  onFieldSubmitted: (value) {
                    if (_controller.text.isNotEmpty) {
                      _chatProvider.sendMessage(
                        _controller.text,
                        widget.id,
                        widget.participants,
                      );
                      _controller.clear();
                    }
                  },
                  style: const TextStyle(color: Colors.black),
                  cursorColor: GlobalVariables.colors.primary,
                  decoration: InputDecoration(
                    suffixIcon:
                        Icon(CupertinoIcons.photo, color: Colors.grey[700]),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.only(top: 10, left: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: GlobalVariables.colors.primary,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: GlobalVariables.colors.primary,
                        width: 0,
                      ),
                    ),
                    hintText: 'Type something...',
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 158, 158, 158),
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessage(MessageElement message) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return FutureBuilder(
      future: userProvider.profileData,
      builder: (context, snapshot) {
        final user = snapshot.data;
        final isSender = message.user!.userId == user?.id;
        final size = MediaQuery.of(context).size;

        return Row(
          mainAxisAlignment:
              isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!isSender)
              CircleAvatar(
                radius: size.height * 0.015,
                backgroundImage: const AssetImage('assets/images/dummyDP.png'),
              ),
            Flexible(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: size.width * 0.6),
                child: Container(
                  margin: const EdgeInsets.all(4.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: isSender
                        ? GlobalVariables.colors.chatBubble
                        : Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    message.message.toString(),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            if (isSender)
              CircleAvatar(
                radius: size.height * 0.015,
                backgroundImage: user?.profilePicture != null
                    ? NetworkImage("${user?.profilePicture}")
                    : const AssetImage('assets/images/dummyDP.png')
                        as ImageProvider,
              ),
          ],
        );
      },
    );
  }
}

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return FutureBuilder(
      future: userProvider.profileData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data?.profilePicture != '') {
          final userData = snapshot.data;
          return CircleAvatar(
            backgroundImage: NetworkImage("${userData?.profilePicture}"),
          );
        } else {
          return CircleAvatar(
            child: Center(
              child: Text(
                (snapshot.data?.username ?? '').substring(0, 1).toUpperCase(),
                style: const TextStyle(fontSize: 24),
              ),
            ),
          );
        }
      },
    );
  }
}
