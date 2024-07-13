import 'dart:convert';
import 'dart:math';

import 'package:ai_assistant_with_quotes/utils/app_constant.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<String> generateResponse(String prompt) async {
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${Constants.API_KEY}",
    };
    final body = jsonEncode({
      "messages": [
        {
          "role": "user",
          "content": prompt,
        }
      ],
      "model": Constants.MODEL_TURBO,
      "max_tokens": 200,
      "temperature": 0.5,
    });

    final response = await http.post(Uri.parse(Constants.API_URL),
        headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["choices"][0]["message"]["content"].toString();
    } else {
      throw Exception("Failed to get chat completion: ${response.statusCode}");
    }
  }

  static Future<String> fetchImage(String searchTerm) async {
    final url = '${Constants.PEXALS_BASE_URL}$searchTerm&per_page=50&page=1';
    final response = await http.get(Uri.parse(url),
        headers: {'Authorization': Constants.PEXELS_API_KEY});

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final photos = jsonResponse['photos'];
      final randomIndex = Random().nextInt(photos.length);
      return photos[randomIndex]['src']['large2x'];
    } else {
      throw Exception('Failed to load image');
    }
  }
}
