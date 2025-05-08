import 'package:assist/common_widgets/constants/colors.dart';
import 'package:assist/messages/all_chats.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatHistory extends StatelessWidget {
  ChatHistory({super.key});
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      //get colors from hex
                      primaryColor,
                      Colors.white
                    ]),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, left: 16.0),
                        child: (Text("You Can Ask Me",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white))),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: (Text("Anything About Assist",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 16.0, bottom: 16.0),
                        child: (TextButton(
                            onPressed: () {
                              Get.toNamed('/chat');
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all<Color>(Colors.white),
                              foregroundColor:
                                  WidgetStateProperty.all<Color>(Colors.black),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                "Ask Now",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ))),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/logo/favicon.png"),
                            fit: BoxFit.cover),
                      ),
                      child: SizedBox(
                        height: 100,
                        width: 100,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // const Padding(
          //   padding: EdgeInsets.only(top: 16.0, left: 16.0),
          //   child: Text(
          //     "Conversations",
          //     style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          //   ),
          // ),
          // AllMessages(scrollController: _scrollController),
        ],
      ),
    );
  }
}
