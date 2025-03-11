import 'dart:async';
import 'dart:developer';
import 'package:assist/common_widgets/constants/colors.dart';
import 'package:assist/features/chatbot/common.dart';
// import 'package:assist/features/chatbot/widgets/custom_button.dart';
import 'package:assist/services/database/user_details_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:syncfusion_flutter_chat/assist_view.dart';

// String geminiKey = String.fromEnvironment('GEMINI_API_KEY');
String? geminiKey = dotenv.env['GEMINI_API_KEY'];

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _AssistViewState();
}

class _AssistViewState extends State<ChatPage> {
  final AssistMessageAuthor _userAuthor = AssistMessageAuthor(
      id: UserDetails.instance.getUserId,
      name: UserDetails.instance.firstname.string);
  final AssistMessageAuthor _aiAuthor =
      const AssistMessageAuthor(id: 'assistbot', name: 'AssistBot');

  late List<AssistMessage> _messages;
  late List<String> _bubbleAlignmentItem;
  late List<String> _placeholderBehaviorItem;

  final double _widthFactor = 0.9;
  // String _selectedAlignment = 'Auto';
  // String _selectedBehavior = 'Scroll';
  final AssistPlaceholderBehavior _placeholderBehavior =
      AssistPlaceholderBehavior.scrollWithMessage;
  final AssistBubbleAlignment _bubbleAlignment = AssistBubbleAlignment.auto;

  final bool _showRequestAvatar = true;
  final bool _showRequestUserName = true;
  final bool _showRequestTimestamp = false;
  final bool _showResponseAvatar = true;
  final bool _showResponseUserName = true;
  final bool _showResponseTimestamp = false;
  // bool _lightTheme = true;

  SelectionArea _buildAIAssistView() {
    return SelectionArea(
      child: SfAIAssistView(
        messages: _messages,
        placeholderBuilder: _buildPlaceholder,
        placeholderBehavior: _placeholderBehavior,
        bubbleAvatarBuilder: _buildAvatar,
        bubbleAlignment: _bubbleAlignment,
        requestBubbleSettings: AssistBubbleSettings(
          widthFactor: _widthFactor,
          showUserAvatar: _showRequestAvatar,
          showTimestamp: _showRequestTimestamp,
          showUserName: _showRequestUserName,
          contentBackgroundColor: Colors.white,
          contentShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: primaryColor, width: 2.0),
          ),
          textStyle: const TextStyle(color: primaryColor),
          headerTextStyle: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        responseBubbleSettings: AssistBubbleSettings(
          widthFactor: _widthFactor,
          showUserAvatar: _showResponseAvatar,
          showTimestamp: _showResponseTimestamp,
          showUserName: _showResponseUserName,
          headerTextStyle: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        composer: const AssistComposer(
          decoration: InputDecoration(
            hintText: 'Type message here...',
          ),
        ),
        actionButton: AssistActionButton(
            onPressed: _handleActionButtonPressed,
            backgroundColor: primaryColor),
        bubbleContentBuilder: (context, int index, AssistMessage message) {
          return MarkdownBody(data: message.data);
        },
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox.square(
            dimension: 80.0,
            child: Image.asset(
              'assets/images/chat/ai_avatar_light.png',
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 10.0),
          const Text(
            'Ask AI Anything!',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 10.0,
              runSpacing: 10.0,
              children: _generateQuickAccessTiles(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _generateQuickAccessTiles() {
    return topics.map((topic) {
      return Column(
        children: [
          GestureDetector(
            onTapDown: (TapDownDetails details) =>
                _handleQuickAccessTileTap(topic),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2.0,
                  color: primaryColor,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      topic['title']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5.0),
        ],
      );
    }).toList();
  }

  void _handleQuickAccessTileTap(Map<String, String> topic) {
    _addMessageAndRebuild(AssistMessage.request(
      data: topic['title']!,
      author: _userAuthor,
      time: DateTime.now(),
    ));
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _generateResponse(
          topic['title'].toString(),
          topic['description'].toString(),
        );
      });
    });
  }

  // Future<void> _generateResponse(String prompt,
  //     [String localResponse = '']) async {
  //   final GenerativeModel aiModel = GenerativeModel(
  //     model: 'gemini-1.5-flash-latest',
  //     apiKey: geminiKey,
  //   );

  //   try {
  //     final GenerateContentResponse response =
  //         await aiModel.generateContent([Content.text(prompt)]);
  //     _addResponseMessage(response.text!);
  //   } catch (err) {
  //     if (localResponse.isNotEmpty) {
  //       _addResponseMessage(localResponse);
  //     } else {
  //       _addResponseMessage('The given $err');
  //     }
  //   }
  // }

  Future<void> _generateResponse(String prompt,
      [String localResponse = '']) async {
    if (localResponse.isNotEmpty) {
      _addResponseMessage(localResponse);
    } else {
      try {
        // Initialize Firestore reference and add document
        final DocumentReference ref =
            await FirebaseFirestore.instance.collection('bot_messages').add({
          'prompt': prompt,
        });

        // Set up snapshot listener
        ref.snapshots().listen((DocumentSnapshot snapshot) {
          if (snapshot.exists && snapshot.data() != null) {
            final data = snapshot.data() as Map<String, dynamic>;
            if (data['response'] != null) {
              log('RESPONSE: ${data['response']}');
              _addResponseMessage(data['response']);
            }
          }
        }, onError: (error) {
          log('Error listening to snapshot: $error');
          _addResponseMessage('The given $error');
        });
      } catch (error) {
        log('Error: $error');
        _addResponseMessage('The given $error');
      }
    }
  }

  void _addResponseMessage(String response) {
    _addMessageAndRebuild(AssistMessage.response(
      data: response,
      author: _aiAuthor,
      time: DateTime.now(),
    ));
  }

  void _addMessageAndRebuild(AssistMessage message) {
    setState(() => _messages.add(message));
  }

  Widget _buildAvatar(BuildContext context, int index, AssistMessage message) {
    return message.isRequested
        ? Image.asset('assets/images/chat/People_Circle7.png')
        : Image.asset(
            'assets/images/chat/ai_avatar_light.png',
            color: primaryColor,
          );
  }

  void _handleActionButtonPressed(String prompt) {
    _addMessageAndRebuild(AssistMessage.request(
      data: prompt,
      author: _userAuthor,
      time: DateTime.now(),
    ));
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        if (geminiKey != null && geminiKey!.isEmpty) {
          _addMessageAndRebuild(
            AssistMessage.response(
              data:
                  'Please connect to your preferred AI server for real-time queries.',
              author: _aiAuthor,
              time: DateTime.now(),
            ),
          );
        } else {
          _generateResponse(prompt);
        }
      },
    );
  }

  // Widget _buildWidthFactorSetting() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: <Widget>[
  //       const Text(
  //         'Width factor',
  //         style: TextStyle(fontSize: 16),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.only(right: 8.0),
  //         child: CustomDirectionalButtons(
  //           maxValue: 1.0,
  //           minValue: 0.8,
  //           step: 0.05,
  //           initialValue: _widthFactor,
  //           onChanged: (double val) => setState(() {
  //             _widthFactor = val;
  //           }),
  //           iconColor: primaryColor,
  //           style: TextStyle(fontSize: 16.0, color: primaryColor),
  //         ),
  //       )
  //     ],
  //   );
  // }

  // Widget _buildBubbleAlignmentSetting(StateSetter stateSetter) {
  //   return SizedBox(
  //     width: 230,
  //     child: Row(
  //       children: <Widget>[
  //         Expanded(
  //           child: Text(
  //             'Bubble alignment',
  //             overflow: TextOverflow.clip,
  //             softWrap: false,
  //             style: TextStyle(fontSize: 16.0, color: primaryColor),
  //           ),
  //         ),
  //         DropdownButton<String>(
  //           dropdownColor: primaryColor,
  //           focusColor: Colors.transparent,
  //           underline: Container(
  //             color: const Color(0xFFBDBDBD),
  //             height: 1.0,
  //           ),
  //           value: _selectedAlignment,
  //           items: _bubbleAlignmentItem.map((String value) {
  //             return DropdownMenuItem<String>(
  //               value: (value != null) ? value : 'Auto',
  //               child: Text(
  //                 value,
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(color: primaryColor),
  //               ),
  //             );
  //           }).toList(),
  //           onChanged: (String? value) {
  //             stateSetter(() {
  //               _handleAlignmentChange(value.toString());
  //             });
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // void _handleAlignmentChange(String value) {
  //   setState(() {
  //     _selectedAlignment = value;
  //     switch (value) {
  //       case 'Start':
  //         _bubbleAlignment = AssistBubbleAlignment.start;
  //         break;
  //       case 'End':
  //         _bubbleAlignment = AssistBubbleAlignment.end;
  //         break;
  //       case 'Auto':
  //         _bubbleAlignment = AssistBubbleAlignment.auto;
  //         break;
  //     }
  //   });
  // }

  // Widget _buildPlaceholderBehaviorSetting(StateSetter stateSetter) {
  //   return SizedBox(
  //     width: 230,
  //     child: Row(
  //       children: <Widget>[
  //         Expanded(
  //           child: Text(
  //             'Placeholder',
  //             overflow: TextOverflow.clip,
  //             softWrap: false,
  //             style: TextStyle(fontSize: 16.0, color: primaryColor),
  //           ),
  //         ),
  //         DropdownButton<String>(
  //           dropdownColor: primaryColor,
  //           focusColor: Colors.transparent,
  //           underline: Container(color: const Color(0xFFBDBDBD), height: 1.0),
  //           value: _selectedBehavior,
  //           items: _placeholderBehaviorItem.map((String value) {
  //             return DropdownMenuItem<String>(
  //               value: 'Scroll',
  //               child: Text(
  //                 value,
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(color: primaryColor),
  //               ),
  //             );
  //           }).toList(),
  //           onChanged: (String? value) {
  //             stateSetter(() {
  //               _handlePlaceholderBehavior(value.toString());
  //             });
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // void _handlePlaceholderBehavior(String value) {
  //   setState(() {
  //     _selectedBehavior = value;
  //     switch (value) {
  //       case 'Scroll':
  //         _placeholderBehavior = AssistPlaceholderBehavior.scrollWithMessage;
  //         break;
  //       case 'Hide':
  //         _placeholderBehavior = AssistPlaceholderBehavior.hideOnMessage;
  //     }
  //   });
  // }

  // Padding _buildBubbleSettingTitle(String title) {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 20.0, bottom: 10),
  //     child: Text(
  //       title,
  //       overflow: TextOverflow.clip,
  //       softWrap: false,
  //       style: TextStyle(
  //         fontSize: 16.0,
  //         fontWeight: FontWeight.bold,
  //         color: primaryColor,
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildRequestShowAvatarSetting(StateSetter stateSetter) {
  //   return SizedBox(
  //     width: 200,
  //     child: CheckboxListTile(
  //       value: _showRequestAvatar,
  //       title: const Text('Show avatar', softWrap: false),
  //       activeColor: primaryColor,
  //       contentPadding: EdgeInsets.zero,
  //       onChanged: (bool? value) {
  //         setState(() {
  //           stateSetter(() {
  //             _showRequestAvatar = value!;
  //           });
  //         });
  //       },
  //     ),
  //   );
  // }

  // Widget _buildRequestShowTimestampSetting(StateSetter stateSetter) {
  //   return SizedBox(
  //     width: 200,
  //     child: CheckboxListTile(
  //       value: _showRequestTimestamp,
  //       title: const Text('Show timestamp', softWrap: false),
  //       activeColor: primaryColor,
  //       contentPadding: EdgeInsets.zero,
  //       onChanged: (bool? value) {
  //         setState(() {
  //           stateSetter(() {
  //             _showRequestTimestamp = value!;
  //           });
  //         });
  //       },
  //     ),
  //   );
  // }

  // Widget _buildRequestShowUserNameSetting(StateSetter stateSetter) {
  //   return SizedBox(
  //     width: 200,
  //     child: CheckboxListTile(
  //       value: _showRequestUserName,
  //       title: const Text('Show name', softWrap: false),
  //       activeColor: primaryColor,
  //       contentPadding: EdgeInsets.zero,
  //       onChanged: (bool? value) {
  //         setState(() {
  //           stateSetter(() {
  //             _showRequestUserName = value!;
  //           });
  //         });
  //       },
  //     ),
  //   );
  // }

  // Widget _buildResponseShowAvatarSetting(StateSetter stateSetter) {
  //   return SizedBox(
  //     width: 200,
  //     child: CheckboxListTile(
  //       value: _showResponseAvatar,
  //       title: const Text('Show avatar', softWrap: false),
  //       activeColor: primaryColor,
  //       contentPadding: EdgeInsets.zero,
  //       onChanged: (bool? value) {
  //         setState(() {
  //           stateSetter(() {
  //             _showResponseAvatar = value!;
  //           });
  //         });
  //       },
  //     ),
  //   );
  // }

  // Widget _buildResponseShowUserNameSetting(StateSetter stateSetter) {
  //   return SizedBox(
  //     width: 200,
  //     child: CheckboxListTile(
  //       value: _showResponseUserName,
  //       title: const Text('Show name', softWrap: false),
  //       activeColor: primaryColor,
  //       contentPadding: EdgeInsets.zero,
  //       onChanged: (bool? value) {
  //         setState(() {
  //           stateSetter(() {
  //             _showResponseUserName = value!;
  //           });
  //         });
  //       },
  //     ),
  //   );
  // }

  // Widget _buildResponseShowTimestampSetting(StateSetter stateSetter) {
  //   return SizedBox(
  //     width: 200,
  //     child: CheckboxListTile(
  //       value: _showResponseTimestamp,
  //       title: const Text('Show timestamp', softWrap: false),
  //       activeColor: primaryColor,
  //       contentPadding: EdgeInsets.zero,
  //       onChanged: (bool? value) {
  //         setState(() {
  //           stateSetter(() {
  //             _showResponseTimestamp = value!;
  //           });
  //         });
  //       },
  //     ),
  //   );
  // }

  // Widget _buildClearChatSetting() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 10.0),
  //     child: ElevatedButton(
  //       style: ButtonStyle(
  //         backgroundColor: WidgetStateProperty.resolveWith<Color?>(
  //           (Set<WidgetState> states) {
  //             if (states.contains(WidgetState.pressed)) {
  //               return primaryColor.withAlpha(150);
  //             }
  //             return primaryColor;
  //           },
  //         ),
  //       ),
  //       onPressed: () {
  //         if (_messages.isNotEmpty) {
  //           setState(() {
  //             _messages.clear();
  //           });
  //         }
  //       },
  //       child: Text(
  //         'Clear Chat',
  //         style: TextStyle(
  //           color: primaryColor,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  void initState() {
    _messages = <AssistMessage>[];
    _bubbleAlignmentItem = ['Auto', 'Start', 'End'];
    _placeholderBehaviorItem = ['Scroll', 'Hide'];
    super.initState();

    // Show the dialog when the app starts.
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (model.isFirstTime) {
    //     showDialog(
    //       context: context,
    //       builder: (context) => WelcomeDialog(
    //         primaryColor: model.primaryColor,
    //         apiKey: model.assistApiKey,
    //         onApiKeySaved: (newApiKey) {
    //           setState(() {
    //             model.assistApiKey = newApiKey;
    //           });
    //         },
    //       ),
    //     );
    //     model.isFirstTime = false;
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'AssistBot AI Assistant',
          style: TextStyle(
              color: primaryColor,
              fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: -45,
            right: -45,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Container(
                color: primaryColor,
                height: 100,
                width: 100,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: _buildAIAssistView(),
                ),
              ),
            ),
          )
          // _buildAIConfigurationSetting()
        ],
      ),
    );
  }

  // @override
  // Widget buildSettings(BuildContext context) {
  //   return StatefulBuilder(
  //     builder: (BuildContext context, StateSetter stateSetter) {
  //       return Column(
  //         mainAxisAlignment: MainAxisAlignment.end,
  //         children: [
  //           _buildClearChatSetting(),
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               _buildWidthFactorSetting(),
  //               _buildBubbleAlignmentSetting(stateSetter),
  //               _buildPlaceholderBehaviorSetting(stateSetter),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   _buildBubbleSettingTitle('Request bubble settings'),
  //                   _buildRequestShowAvatarSetting(stateSetter),
  //                   _buildRequestShowUserNameSetting(stateSetter),
  //                   _buildRequestShowTimestampSetting(stateSetter),
  //                   _buildBubbleSettingTitle('Response bubble settings'),
  //                   _buildResponseShowAvatarSetting(stateSetter),
  //                   _buildResponseShowUserNameSetting(stateSetter),
  //                   _buildResponseShowTimestampSetting(stateSetter)
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  void dispose() {
    _messages.clear();
    _bubbleAlignmentItem.clear();
    _placeholderBehaviorItem.clear();
    super.dispose();
  }
}
