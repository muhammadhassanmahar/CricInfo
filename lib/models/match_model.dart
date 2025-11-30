class MatchModel {
  final String matchId;
  final String team1;
  final String team2;
  final String status;

  MatchModel({
    required this.matchId,
    required this.team1,
    required this.team2,
    required this.status,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      matchId: json['match_id'],
      team1: json['team1'],
      team2: json['team2'],
      status: json['status'],
    );
  }
}
