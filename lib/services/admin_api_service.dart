import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';

class AdminApiService {
  // Update match score
  Future<void> updateScore(String matchId, Map<String, dynamic> score) async {
    final url = Uri.parse('${AppConfig.baseUrl}/admin/match/$matchId/update_score');
    final res = await http.post(url, body: jsonEncode(score), headers: {
      "Content-Type": "application/json",
    });
    if (res.statusCode != 200) {
      throw Exception('Failed to update score');
    }
  }

  // Add event
  Future<void> addEvent(String matchId, Map<String, dynamic> event) async {
    final url = Uri.parse('${AppConfig.baseUrl}/admin/match/$matchId/event');
    final res = await http.post(url, body: jsonEncode(event), headers: {
      "Content-Type": "application/json",
    });
    if (res.statusCode != 200) {
      throw Exception('Failed to add event');
    }
  }
}
