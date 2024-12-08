import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatBotService {
  static const String apiUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent";
  static const String apiKey = "AIzaSyCpB43s-GecR5BPPSSodaBYaYtYG7IwdVo"; // Make sure this is correct

  static Future<String> sendMessage(String message) async {
    try {
      final headers = {
        "Content-Type": "application/json",
      };

      final body = jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": message}
            ]
          }
        ]
      });

      print("Using API key: $apiKey"); // Log the API key used in the request

      final response = await http.post(
        Uri.parse('$apiUrl?key=$apiKey'),
        headers: headers,
        body: body,
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Parsed Response: $data"); // Log the parsed response

        if (data.containsKey('candidates') &&
            data['candidates'] != null &&
            data['candidates'][0]['content'] != null &&
            data['candidates'][0]['content']['parts'] != null) {
          return data['candidates'][0]['content']['parts'][0]['text'] ?? "No response from Bard";
        } else {
          return "No valid content in the response";
        }
      } else {
        return "Error: ${response.statusCode}, ${response.body}";
      }
    } catch (e) {
      print("Exception: $e");
      return "Error: Unable to send message. $e";
    }
  }
}
