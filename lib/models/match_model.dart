class MatchModel {
  final String matchId;
  final String team1;
  final String team2;
  final String status;
  final String? score; // optional field for live score

  MatchModel({
    required this.matchId,
    required this.team1,
    required this.team2,
    required this.status,
    this.score,
  });

  // Getter for convenience
  String get id => matchId;

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      matchId: json['match_id'],
      team1: json['team1'],
      team2: json['team2'],
      status: json['status'],
      score: json['score'] != null ? json['score'].toString() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'match_id': matchId,
      'team1': team1,
      'team2': team2,
      'status': status,
      'score': score,
    };
  }
}
