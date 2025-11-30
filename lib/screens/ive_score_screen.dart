import 'package:flutter/material.dart';
import '../services/websocket_service.dart';
import '../services/api_service.dart';
import '../widgets/score_card.dart';

class LiveScoreScreen extends StatefulWidget {
  final String matchId;

  const LiveScoreScreen({super.key, required this.matchId});

  @override
  State<LiveScoreScreen> createState() => _LiveScoreScreenState();
}

class _LiveScoreScreenState extends State<LiveScoreScreen> {
  final ws = WebsocketService();
  final api = ApiService();

  Map<String, dynamic>? currentScore;

  @override
  void initState() {
    super.initState();
    ws.connect(widget.matchId);

    // initial score load
    api.getScore(widget.matchId).then((value) {
      setState(() => currentScore = value);
    });

    // live updates
    ws.stream.listen((event) {
      setState(() => currentScore = event);
    });
  }

  @override
  void dispose() {
    ws.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Live Score")),
      body: currentScore == null
          ? Center(child: CircularProgressIndicator())
          : ScoreCard(score: currentScore!),
    );
  }
}
