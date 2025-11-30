import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/ive_score_screen.dart';
import '../services/api_service.dart';
import '../models/match_model.dart';

class MatchListScreen extends StatefulWidget {
  @override
  State<MatchListScreen> createState() => _MatchListScreenState();
}

class _MatchListScreenState extends State<MatchListScreen> {
  final api = ApiService();
  late Future<List<MatchModel>> matchFuture;

  @override
  void initState() {
    matchFuture = api.fetchMatches();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Live Matches")),
      body: FutureBuilder<List<MatchModel>>(
        future: matchFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final matches = snapshot.data!;
          return ListView.builder(
            itemCount: matches.length,
            itemBuilder: (context, i) {
              final match = matches[i];
              return ListTile(
                title: Text("${match.team1} vs ${match.team2}"),
                subtitle: Text(match.status),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LiveScoreScreen(matchId: match.matchId),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
