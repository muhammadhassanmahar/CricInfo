import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../models/match_model.dart';
import 'match_update_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final api = ApiService();
  late Future<List<MatchModel>> matchFuture;

  @override
  void initState() {
    super.initState();
    matchFuture = api.fetchMatches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Panel")),
      body: FutureBuilder<List<MatchModel>>(
        future: matchFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final matches = snapshot.data ?? [];
          return ListView.builder(
            itemCount: matches.length,
            itemBuilder: (context, i) {
              final match = matches[i];
              return ListTile(
                title: Text("${match.team1} vs ${match.team2}"),
                subtitle: Text(match.status),
                trailing: const Icon(Icons.edit),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MatchUpdateScreen(match: match),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
