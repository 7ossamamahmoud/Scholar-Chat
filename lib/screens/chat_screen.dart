import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/components/constants/constants.dart';
import 'package:scholar_chat/models/messages_model.dart';

import '../components/widgets/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);
  static String chatScreenID = "Chat Screen";
  final TextEditingController _controller = TextEditingController();
  final _scrollController = ScrollController();
  var emailController = '';

  @override
  Widget build(BuildContext context) {
    emailController = ModalRoute.of(context)?.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
      stream: messages
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(), // get all messages=docs "query snapshot"= all docs.
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MessageModel> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(
              MessageModel.fromJson(
                snapshot.data!.docs[i],
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              elevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    kLogoPath,
                    height: 60,
                  ),
                  const Text(
                    "Chat",
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: "Pacifico",
                    ),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _scrollController,
                    itemCount: messagesList.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return messagesList[index].id == emailController
                          ? ChatBubble(
                              messageModel: messagesList[index],
                            )
                          : ChatBubbleForFriend(
                              messageModel: messagesList[index],
                            );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    onSubmitted: (message) {
                      sendMessage(message);
                      scrollToEnd();
                    },
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Send a Message",
                      suffixIcon: IconButton(
                          onPressed: () {
                            sendMessage(_controller.text);
                            scrollToEnd();
                          },
                          icon: const Icon(
                            Icons.send_rounded,
                            color: kPrimaryColor,
                          )),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: kPrimaryColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: kPrimaryColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              elevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    kLogoPath,
                    height: 60,
                  ),
                  const Text(
                    "Chat",
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: "Pacifico",
                    ),
                  )
                ],
              ),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  void scrollToEnd() {
    _scrollController.animateTo(
      0,
      duration: const Duration(
        microseconds: 800,
      ),
      curve: Curves.fastOutSlowIn,
    );
  }

  void sendMessage(String message) {
    if (message.isNotEmpty) {
      messages.add({
        'message': message,
        'createdAt': DateTime.now(),
        'id': emailController,
      });
      _controller.clear();
    } else {}
  }
}
