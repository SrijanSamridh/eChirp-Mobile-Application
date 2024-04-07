// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:echirp/API/models/message.models.dart';
import 'package:echirp/API/services/base_client.dart';
import 'package:echirp/screens/group/components/group_detail.dart';
import 'package:echirp/utils/global_variabes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../API/models/group.models.dart';
import '../../API/services/socket_connection.dart';

class ChatScreen extends StatefulWidget {
  final String id;
  final String title;
  final String image;
  final List<Participant>? participants;

  const ChatScreen(
      {Key? key,
      required this.title,
      required this.image,
      required this.id,
      required this.participants})
      : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late List<MessageElement> _messages = [];
  String userId = "";

  final TextEditingController _controller = TextEditingController();

  Future<void> _sendMessage(String message) async {
    var body = {"groupId": widget.id, "message": message};

    var response = await BaseClient().post('/message', body);
    var result = response['message'];
    print("result : $result");
    result["participants"] = widget.participants;
    SocketConnection.socket.emit(
      "new-message", result
    );
    setState(() {
      _messages.add(MessageElement.fromJson(result));
    });
    _controller.clear();
  }

  Future<dynamic> fetchMessages(String groupId) async {
    try {
      var response = await BaseClient().get('/message/$groupId');
      final decodedResponse = json.decode(response);

      if (decodedResponse is! Map<String, dynamic>) {
        debugPrint('Unexpected response format: $decodedResponse');
        return null;
      }
      final messagesData = decodedResponse['messages'];
      print("List of Messages : $messagesData");

      if (messagesData != null && messagesData is List) {
        final messages = messagesData
            .map<MessageElement>(
                (messageData) => MessageElement.fromJson(messageData))
            .toList();
        return messages;
      } else {
        debugPrint('Events data not found in response');
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getuserId();
    print(userId);
    getMessages();
  }

  Future<void> getMessages() async {
    var data = await fetchMessages(widget.id);
    setState(() {
      _messages = data;
    });
  }

  Future<void> getuserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('_id')!;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30)),
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
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(_messages[index]);
              },
            ),
          ),
          Container(
            color: Colors.grey[200],
            height: size.height * 0.12,
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
                        onFieldSubmitted: (value) => {
                          if (_controller.text.isNotEmpty)
                            {_sendMessage(_controller.text)}
                        },
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        cursorColor: GlobalVariables.kPrimaryColor,
                        decoration: InputDecoration(
                          suffixIcon: Icon(CupertinoIcons.photo,
                              color: Colors.grey[700]),
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
                              color: GlobalVariables.kPrimaryColor,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(
                              color: GlobalVariables.kPrimaryColor,
                              width: 0,
                            ),
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
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(MessageElement message) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: true ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width * 0.6),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color:
                    true ? GlobalVariables.chatBubbleColor : Colors.grey[300],
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
        true
            ? CircleAvatar(
                backgroundImage: AssetImage(true
                    ? 'assets/images/dummyDP.png'
                    : 'assets/other_user_photo.jpg'),
              )
            : Container(),
      ],
    );
  }
}

class Message {
  final String groupId;
  final String message;
  final bool sendByMe;

  Message(
      {required this.groupId, required this.message, required this.sendByMe});
}
