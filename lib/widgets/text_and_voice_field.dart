import 'package:flutter/material.dart';
import 'package:flutter_application_1/global/provider/chats_provider.dart';
import 'package:flutter_application_1/model/chat_model.dart';
import 'package:flutter_application_1/services/ai_handler.dart';
import 'package:flutter_application_1/widgets/toggle_button.dart';
import 'package:get/get.dart';

enum InputMode { text, voice }

class TextAndVoiceField extends StatefulWidget {
  const TextAndVoiceField({super.key});

  @override
  State<TextAndVoiceField> createState() => _TextAndVoiceFieldState();
}

class _TextAndVoiceFieldState extends State<TextAndVoiceField> {
  InputMode _inputMode = InputMode.voice;
  final _messageController = TextEditingController();
  final AIHandler _geminiAI = AIHandler();
  var _isReplying = false;
  var _isListening = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _messageController,
            onChanged: (value) => {
              value.isNotEmpty
                  ? setInputMode(InputMode.text)
                  : setInputMode(InputMode.voice)
            },
            cursorColor: Colors.black,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
        const SizedBox(
          width: 06,
        ),
        ToggleButton(
          isListening: _isListening,
          isReplying: _isReplying,
          inputMode: _inputMode,
          sendTextMessage: () {
            final message = _messageController.text;
            _messageController.clear();
            sendTextMessage(message);
          },
          sendVoiceMessage: sendVoiceMessage,
        ),
      ],
    );
  }

  void setInputMode(InputMode inputMode) {
    setState(() {
      _inputMode = inputMode;
    });
  }

  void sendVoiceMessage() {}

  void sendTextMessage(String message) async {
    final aiResponse = await _geminiAI.getResponse(message);
    addToChatList(message, true, DateTime.now().toString());
    addToChatList(aiResponse, false, DateTime.now().toString());
  }

  void addToChatList(String message, bool isMe, String id) {
    final ChatController chatController = Get.find<ChatController>();
    chatController.addChat(ChatModel(
      id: id,
      message: message,
      isMe: isMe,
    ));

    chatController.chats.forEach((chat) {
      print('ID: ${chat.id}, Message: ${chat.message}, IsMe: ${chat.isMe}');
    });
  }
}
