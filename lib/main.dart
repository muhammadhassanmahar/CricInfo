import 'package:flutter/material.dart';
import 'screens/match_list_screen.dart';
import 'screens/admin/admin_home_screen.dart'; // import admin screen

void main() {
  runApp(const CricApp());
}

class CricApp extends StatelessWidget {
  const CricApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Live Cricket",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeWrapper(), // use wrapper to add FAB
    );
  }
}

// ✅ Wrapper widget to combine MatchList + Admin button
class HomeWrapper extends StatelessWidget {
  const HomeWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const MatchListScreen(),
      floatingActionButton: FloatingActionButton(
        tooltip: "Go to Admin Panel",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AdminHomeScreen()),
          );
        },
        child: const Icon(Icons.admin_panel_settings), // ✅ child last
      ),
    );
  }
}
