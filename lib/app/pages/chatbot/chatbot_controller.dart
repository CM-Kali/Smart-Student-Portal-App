import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'api_key.dart';

class ChatbotController extends GetxController {
  var messages = <Map<String, String>>[].obs;
  var isLoading = false.obs;


  Future<void> sendMessage(String prompt) async {
    if (prompt.isEmpty) return;

    // Add user message
    messages.add({"role": "user", "content": prompt});
    isLoading.value = true;

    try {
      var url = Uri.parse("https://api.groq.com/openai/v1/chat/completions");
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': apiKey,
        },
        body: jsonEncode({
          "model": "qwen/qwen3-32b",
          "temperature": 0.7,
          "messages": messages,
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        // Check your API structure, adjust below if needed
        String botReply = data['choices'][0]['message']['content'];
        messages.add({"role": "assistant", "content": botReply});
      } else {
        messages.add({
          "role": "assistant",
          "content": "Error: ${response.statusCode} ${response.reasonPhrase}"
        });
      }
    } catch (e) {
      messages.add({"role": "assistant", "content": "Error: $e"});
    } finally {
      isLoading.value = false;
    }
  }
}


