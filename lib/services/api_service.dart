import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';
import '../models/match_model.dart';

class ApiService {
  Future<List<MatchModel>> fetchMatches() async {
    final url = Uri.parse('${AppConfig.baseUrl}/matches');
    final res = await http.get(url);

    final List data = jsonDecode(res.body);
    return data.map((e) => MatchModel.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> getScore(String matchId) async {
    final url = Uri.parse('${AppConfig.baseUrl}/matches/$matchId/score');
    final res = await http.get(url);
    return jsonDecode(res.body);
  }
}
