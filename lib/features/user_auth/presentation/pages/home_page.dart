import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/user_info_page.dart';
import 'package:flutter_application_1/global/provider/chats_provider.dart';
import 'package:flutter_application_1/widgets/chat_item.dart';
import 'package:flutter_application_1/widgets/text_and_voice_field.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatController _chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Flutter GPT"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                // Điều hướng tới trang thứ hai
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserInfoPage()),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: _chatController.chats.length,
                  itemBuilder: (context, index) {
                    final chat = _chatController.chats[index];
                    return ListTile(
                      title: ChatItem(isMe: chat.isMe, text: chat.message),
                    );
                  },
                );
              }),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: TextAndVoiceField(),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ));
  }
}
