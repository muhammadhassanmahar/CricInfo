import 'package:flutter/material.dart';
import '../../models/match_model.dart';
import '../../services/admin_api_service.dart';

class MatchUpdateScreen extends StatefulWidget {
  final MatchModel match;
  const MatchUpdateScreen({super.key, required this.match});

  @override
  State<MatchUpdateScreen> createState() => _MatchUpdateScreenState();
}

class _MatchUpdateScreenState extends State<MatchUpdateScreen> {
  final adminApi = AdminApiService();

  final runsController = TextEditingController();
  final wicketsController = TextEditingController();
  final oversController = TextEditingController();

  final eventTypeController = TextEditingController();
  final batsmanController = TextEditingController();
  final bowlerController = TextEditingController();
  final overController = TextEditingController();

  bool isUpdatingScore = false;
  bool isAddingEvent = false;

  @override
  void dispose() {
    runsController.dispose();
    wicketsController.dispose();
    oversController.dispose();
    eventTypeController.dispose();
    batsmanController.dispose();
    bowlerController.dispose();
    overController.dispose();
    super.dispose();
  }

  Future<void> updateScore() async {
    setState(() => isUpdatingScore = true);

    try {
      final score = {
        "runs": int.tryParse(runsController.text) ?? 0,
        "wickets": int.tryParse(wicketsController.text) ?? 0,
        "overs": double.tryParse(oversController.text) ?? 0.0,
      };
      await adminApi.updateScore(widget.match.matchId, score);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Score updated successfully")),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating score: $e")),
      );
    } finally {
      if (mounted) setState(() => isUpdatingScore = false);
    }
  }

  Future<void> addEvent() async {
    setState(() => isAddingEvent = true);

    try {
      final event = {
        "event_type": eventTypeController.text,
        "batsman": batsmanController.text,
        "bowler": bowlerController.text,
        "over": double.tryParse(overController.text) ?? 0.0,
      };
      await adminApi.addEvent(widget.match.matchId, event);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Event added successfully")),
      );

      // Clear event fields after successful add
      eventTypeController.clear();
      batsmanController.clear();
      bowlerController.clear();
      overController.clear();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error adding event: $e")),
      );
    } finally {
      if (mounted) setState(() => isAddingEvent = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text("Update: ${widget.match.team1} vs ${widget.match.team2}")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Update Score",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              controller: runsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Runs"),
            ),
            TextField(
              controller: wicketsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Wickets"),
            ),
            TextField(
              controller: oversController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Overs"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: isUpdatingScore ? null : updateScore,
              child: isUpdatingScore
                  ? const CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 2)
                  : const Text("Update Score"),
            ),
            const Divider(height: 30),
            const Text("Add Event",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              controller: eventTypeController,
              decoration:
                  const InputDecoration(labelText: "Event Type (WICKET, SIX...)"),
            ),
            TextField(
              controller: batsmanController,
              decoration: const InputDecoration(labelText: "Batsman"),
            ),
            TextField(
              controller: bowlerController,
              decoration: const InputDecoration(labelText: "Bowler"),
            ),
            TextField(
              controller: overController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Over"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: isAddingEvent ? null : addEvent,
              child: isAddingEvent
                  ? const CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 2)
                  : const Text("Add Event"),
            ),
          ],
        ),
      ),
    );
  }
}
