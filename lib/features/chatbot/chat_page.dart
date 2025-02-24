import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class ChatPage extends StatefulWidget {
  static const routeName = '/chat';
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _chatHistory = [];
  String? _file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Chat",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Stack(
          children: [
            SizedBox(
              //get max height
              height: MediaQuery.of(context).size.height - 160,
              child: ListView.builder(
                itemCount: _chatHistory.length,
                shrinkWrap: false,
                controller: _scrollController,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(
                        left: 14, right: 14, top: 10, bottom: 10),
                    child: Align(
                      alignment: (_chatHistory[index]["isSender"]
                          ? Alignment.topRight
                          : Alignment.topLeft),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withAlpha(150),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          color: (_chatHistory[index]["isSender"]
                              ? Color(0xFFF69170)
                              : Colors.white),
                        ),
                        padding: EdgeInsets.all(16),
                        child: _chatHistory[index]["isImage"]
                            ? Image.file(File(_chatHistory[index]["message"]),
                                width: 200)
                            : Text(_chatHistory[index]["message"],
                                style: TextStyle(
                                    fontSize: 15,
                                    color: _chatHistory[index]["isSender"]
                                        ? Colors.white
                                        : Colors.black)),
                      ),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  MaterialButton(
                    onPressed: () {},
                    minWidth: 42.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: const EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFFF69170),
                              Color(0xFF7D96E6),
                            ]),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      child: Container(
                          constraints: const BoxConstraints(
                              minWidth: 42.0, minHeight: 36.0),
                          alignment: Alignment.center,
                          child: Icon(
                            _file == null ? Icons.image : Icons.check,
                            color: Colors.white,
                          )),
                    ),
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        border: GradientBoxBorder(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFFF69170),
                                Color(0xFF7D96E6),
                              ]),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: "Type a message",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(8.0),
                          ),
                          controller: _chatController,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  MaterialButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: const EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFFF69170),
                              Color(0xFF7D96E6),
                            ]),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      child: Container(
                          constraints: const BoxConstraints(
                              minWidth: 88.0,
                              minHeight:
                                  36.0), // min sizes for Material buttons
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.send,
                            color: Colors.white,
                          )),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
