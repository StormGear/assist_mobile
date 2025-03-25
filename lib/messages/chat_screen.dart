import 'package:flutter/material.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.conversationId});

  final String conversationId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZIMKitMessageListPage(
        conversationID: widget.conversationId,
        conversationType: ZIMConversationType.peer,
      ),
    );
  }
}
