import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_student_portal/app/pages/chatbot/chatbot_controller.dart';

class ChatbotPage extends StatelessWidget {
  ChatbotPage({super.key});
  final ChatbotController controller = Get.put(ChatbotController());
  final TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chatbot")),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: controller.messages.length,
              itemBuilder: (context, index) {
                var msg = controller.messages[index];
                bool isUser = msg['role'] == 'user';
                return Align(
                  alignment:
                  isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 4, horizontal: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      msg['content']!,
                      style: TextStyle(
                          color: isUser ? Colors.white : Colors.black),
                    ),
                  ),
                );
              },
            )),
          ),
          Obx(() => controller.isLoading.value
              ? const LinearProgressIndicator()
              : const SizedBox.shrink()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: inputController,
                    decoration: const InputDecoration(
                      hintText: "Ask something...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    controller.sendMessage(inputController.text);
                    inputController.clear();
                  },
                  child: const Text("Send"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
