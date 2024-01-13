import 'package:flutter/material.dart';
import 'package:scholar_chat/components/constants/constants.dart';
import 'package:scholar_chat/models/messages_model.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.messageModel,
  });
  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 16,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 20,
        ),
        decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              16,
            ),
            bottomLeft: Radius.circular(
              16,
            ),
            topRight: Radius.circular(
              16,
            ),
          ),
        ),
        child: Text(
          messageModel.message,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ChatBubbleForFriend extends StatelessWidget {
  const ChatBubbleForFriend({
    super.key,
    required this.messageModel,
  });
  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 16,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 20,
        ),
        decoration: const BoxDecoration(
          color: Color(0xff006D84),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              16,
            ),
            bottomRight: Radius.circular(
              16,
            ),
            topRight: Radius.circular(
              16,
            ),
          ),
        ),
        child: Text(
          messageModel.message,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
