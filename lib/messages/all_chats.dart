import 'package:assist/messages/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class AllMessages extends StatefulWidget {
  const AllMessages({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  State<AllMessages> createState() => _AllMessagesState();
}

class _AllMessagesState extends State<AllMessages> {
  void startNewChat(BuildContext context, String receipientId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          conversationId: receipientId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: ZIMKitConversationListView(
          scrollController: widget.scrollController,
          onPressed: (context, conversation, defaultAction) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    conversationId: conversation.id,
                  ),
                ),
              )),
    );
  }
}
