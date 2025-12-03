import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart'; // <-- debugPrint fix
import '../config/app_config.dart';
import '../models/match_model.dart';

class ApiService {
  // -----------------------------------------------------
  // Fetch all matches
  // -----------------------------------------------------
  Future<List<MatchModel>> fetchMatches() async {
    final url = Uri.parse('${AppConfig.baseUrl}/matches');
    final res = await http.get(url);

    if (res.statusCode != 200) {
      throw Exception("Failed to load matches");
    }

    final List data = jsonDecode(res.body);
    return data.map((e) => MatchModel.fromJson(e)).toList();
  }

  // -----------------------------------------------------
  // Fetch score of a specific match
  // -----------------------------------------------------
  Future<Map<String, dynamic>> getScore(String matchId) async {
    final url = Uri.parse('${AppConfig.baseUrl}/matches/$matchId/score');
    final res = await http.get(url);

    if (res.statusCode != 200) {
      throw Exception("Failed to load score");
    }

    return jsonDecode(res.body);
  }

  // -----------------------------------------------------
  // ADD NEW MATCH (Admin)
  // -----------------------------------------------------
  Future<bool> addMatch(String team1, String team2, String status) async {
    final url = Uri.parse('${AppConfig.baseUrl}/matches/add');

    final res = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "team1": team1,
        "team2": team2,
        "status": status,
      }),
    );

    if (res.statusCode == 200) {
      return true;
    } else {
      // debugPrint use kiya hai print ki jagah, safe for Flutter web
      debugPrint("Error adding match: ${res.body}");
      return false;
    }
  }
}
