import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'api_key.dart';

class Message {
  final String role;
  final String content;
  final String? thinking;
  final DateTime timestamp;

  Message({
    required this.role,
    required this.content,
    this.thinking,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

class ChatbotController extends GetxController {
  var messages = <Message>[].obs;
  var isLoading = false.obs;
  var isTyping = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Add welcome message
    messages.add(Message(
      role: "assistant",
      content: "Hello! I'm your AI assistant. How can I help you today?",
    ));
  }

  Future<void> sendMessage(String prompt) async {
    if (prompt.trim().isEmpty) return;

    // Add user message
    messages.add(Message(
      role: "user",
      content: prompt.trim(),
    ));

    isLoading.value = true;
    isTyping.value = true;

    try {
      var url = Uri.parse("https://api.groq.com/openai/v1/chat/completions");

      // Prepare messages for API
      var apiMessages = messages.map((msg) => {
        "role": msg.role,
        "content": msg.content,
      }).toList();

      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': apiKey,
        },
        body: jsonEncode({
          "model": "qwen/qwen3-32b",
          "temperature": 0.7,
          "messages": apiMessages,
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        String fullResponse = data['choices'][0]['message']['content'];

        // Parse thinking and response
        String? thinking;
        String actualResponse;

        // Check if response contains thinking tags
        if (fullResponse.contains('<think>') && fullResponse.contains('</think>')) {
          final thinkingMatch = RegExp(r'<think>(.*?)</think>', dotAll: true)
              .firstMatch(fullResponse);

          if (thinkingMatch != null) {
            thinking = thinkingMatch.group(1)?.trim();
            actualResponse = fullResponse
                .replaceAll(RegExp(r'<think>.*?</think>', dotAll: true), '')
                .trim();
          } else {
            actualResponse = fullResponse;
          }
        } else {
          actualResponse = fullResponse;
        }

        messages.add(Message(
          role: "assistant",
          content: actualResponse.isEmpty ? "I understand." : actualResponse,
          thinking: thinking,
        ));
      } else {
        messages.add(Message(
          role: "assistant",
          content: "Sorry, I encountered an error. Please try again.",
        ));

        Get.snackbar(
          "Error",
          "Failed to get response: ${response.statusCode}",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      messages.add(Message(
        role: "assistant",
        content: "Sorry, something went wrong. Please check your connection and try again.",
      ));

      Get.snackbar(
        "Error",
        "Connection error: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
      isTyping.value = false;
    }
  }

  void clearChat() {
    messages.clear();
    messages.add(Message(
      role: "assistant",
      content: "Chat cleared! How can I help you?",
    ));
  }
}