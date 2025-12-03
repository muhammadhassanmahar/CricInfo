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

  void refreshMatches() {
    setState(() {
      matchFuture = api.fetchMatches();
    });
  }

  // -----------------------------
  // SHOW ADD MATCH POPUP FORM
  // -----------------------------
  void showAddMatchDialog() {
    final team1Controller = TextEditingController();
    final team2Controller = TextEditingController();
    final statusController = TextEditingController(text: "upcoming");

    showDialog(
      context: context,
      builder: (dialogCtx) {
        return AlertDialog(
          title: const Text("Add New Match"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: team1Controller,
                  decoration: const InputDecoration(labelText: "Team 1"),
                ),
                TextField(
                  controller: team2Controller,
                  decoration: const InputDecoration(labelText: "Team 2"),
                ),
                TextField(
                  controller: statusController,
                  decoration: const InputDecoration(labelText: "Status"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogCtx),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (team1Controller.text.isEmpty ||
                    team2Controller.text.isEmpty ||
                    statusController.text.isEmpty) {
                  ScaffoldMessenger.of(dialogCtx).showSnackBar(
                    const SnackBar(content: Text("All fields required!")),
                  );
                  return;
                }

                final success = await api.addMatch(
                  team1Controller.text,
                  team2Controller.text,
                  statusController.text,
                );

                Navigator.pop(dialogCtx);

                if (!mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(success
                        ? "Match Added Successfully"
                        : "Error adding match"),
                  ),
                );

                if (success) refreshMatches();
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  // -----------------------------
  // BUILD UI
  // -----------------------------
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

          if (matches.isEmpty) {
            return const Center(child: Text("No matches available"));
          }

          return ListView.builder(
            itemCount: matches.length,
            itemBuilder: (context, index) {
              final match = matches[index];

              return ListTile(
                title: Text("${match.team1} vs ${match.team2}"),
                subtitle: Text(match.status),
                trailing: const Icon(Icons.edit),
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) =>
                          MatchUpdateScreen(match: match),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                      transitionsBuilder: (_, __, ___, child) => child,
                    ),
                  ).then((_) => refreshMatches());
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "admin_add_btn",
        tooltip: "Add New Match",
        onPressed: showAddMatchDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
