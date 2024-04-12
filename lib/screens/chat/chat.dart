import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../API/models/message.models.dart';
import '../../API/provider/chat_provider.dart';
import 'package:echirp/utils/global_variabes.dart';
import '../../API/models/group.models.dart';
import '../../API/provider/user_provider.dart';
import '../../screens/group/components/group_detail.dart';

class ChatScreen extends StatelessWidget {
  final String id;
  final String title;
  final String image;
  final List<Participant>? participants;

  const ChatScreen({
    Key? key,
    required this.title,
    required this.image,
    required this.id,
    required this.participants,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatProvider(),
      child: _ChatScreenContent(
          id: id, title: title, image: image, participants: participants),
    );
  }
}

class _ChatScreenContent extends StatefulWidget {
  final String id;
  final String title;
  final String image;
  final List<Participant>? participants;

  const _ChatScreenContent({
    Key? key,
    required this.id,
    required this.title,
    required this.image,
    required this.participants,
  }) : super(key: key);

  @override
  __ChatScreenContentState createState() => __ChatScreenContentState();
}

class __ChatScreenContentState extends State<_ChatScreenContent> {
  late TextEditingController _controller;
  late ChatProvider _chatProvider;
  late bool checkSender;
  late String userId = "";

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _chatProvider = Provider.of<ChatProvider>(context, listen: false);
    // _chatProvider.listenToSocketEvents();
    _chatProvider.fetchMessages(widget.id);
    setState(() {
      userId = getuserId();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
        ),
        title: GestureDetector(
          onTap: () =>
              Navigator.of(context).pushNamed(GroupDetailsPage.routeName),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/dummyDP.png'),
              ),
              const SizedBox(width: 8),
              Text(
                widget.title,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        backgroundColor: const Color(0xffFEA865),
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
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, _) {
        return Container(
          color: Colors.grey[200],
          height: MediaQuery.of(context).size.height * 0.12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/dummyDP.png'),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      controller: _controller,
                      onFieldSubmitted: (value) {
                        if (_controller.text.isNotEmpty) {
                          chatProvider.sendMessage(
                              _controller.text, widget.id, widget.participants);
                          _controller.clear();
                        }
                      },
                      style: const TextStyle(color: Colors.black),
                      cursorColor: GlobalVariables.kPrimaryColor,
                      decoration: InputDecoration(
                        suffixIcon:
                            Icon(CupertinoIcons.photo, color: Colors.grey[700]),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: const BorderSide(
                              color: GlobalVariables.kPrimaryColor, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: const BorderSide(
                              color: GlobalVariables.kPrimaryColor, width: 0),
                        ),
                        hintText: '    Type something...',
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
      },
    );
  }

  Widget _buildMessage(MessageElement message) {
    var userProvider = Provider.of<UserProvider>(context, listen: false).userData;
    checkSender =  message.user!.username == userProvider?.user?.username;
    debugPrint("Message From Provider: ${userProvider?.message}\n$checkSender <-- ${message.user!.userId} : ${userProvider?.user?.id}");
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment:
          checkSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width * 0.6),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: checkSender
                    ? GlobalVariables.chatBubbleColor
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
        const SizedBox(width: 8.0),
        checkSender
            ? CircleAvatar(
                radius: size.height * 0.015,
                backgroundImage: AssetImage(checkSender
                    ? 'assets/images/dummyDP.png'
                    : 'assets/other_user_photo.jpg'),
              )
            : Container(),
      ],
    );
  }

  String getuserId() {
    return _chatProvider.getUserId().toString();
  }
}
