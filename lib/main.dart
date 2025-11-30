import 'package:flutter/material.dart';
import 'screens/match_list_screen.dart';

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
      home: MatchListScreen(),
    );
  }
}
