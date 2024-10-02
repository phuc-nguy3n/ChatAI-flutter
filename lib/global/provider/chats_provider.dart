import 'package:flutter_application_1/model/chat_model.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  var chats = <ChatModel>[].obs;

  void addChat(ChatModel chatModel) {
    chats.add(chatModel);
  }

  void removeTyping() {
    chats.removeWhere((chat) => chat.id == 'typing');
  }
}
