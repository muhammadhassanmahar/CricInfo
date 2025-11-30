import 'package:flutter/material.dart';

class ScoreCard extends StatelessWidget {
  final Map<String, dynamic> score;

  const ScoreCard({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 5,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${score['runs']}/${score['wickets']}",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("Overs: ${score['overs']}", style: TextStyle(fontSize: 22)),
              SizedBox(height: 20),
              if (score.containsKey('event'))
                Text(
                  "Event: ${score['event']}",
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
