// ignore_for_file: library_private_types_in_public_api

import 'package:echirp/screens/group/components/group_detail.dart';
import 'package:echirp/utils/global_variabes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String title;
  final String image;

  const ChatScreen({Key? key, required this.title, required this.image})
      : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}
 
class _ChatScreenState extends State<ChatScreen> {
  final List<Message> _messages = [];

  final TextEditingController _controller = TextEditingController();

  void _sendMessage(String message) {
    setState(() {
      _messages.add(Message(text: message, isMe: true));
    });
    _controller.clear();
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

  Widget _buildMessage(Message message) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment:
          message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width * 0.6),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: message.isMe
                    ? GlobalVariables.chatBubbleColor
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                message.text,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        CircleAvatar(
          backgroundImage: AssetImage(message.isMe
              ? 'assets/images/dummyDP.png'
              : 'assets/other_user_photo.jpg'),
        ),
      ],
    );
  }
}

class Message {
  final String text;
  final bool isMe;

  Message({required this.text, required this.isMe});
}
