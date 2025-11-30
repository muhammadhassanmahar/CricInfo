class AppConfig {
  // Backend ka HTTP base URL
  static const String baseUrl = "http://127.0.0.1:8000";

  // WebSocket URL generator
  // Agar backend localhost pe hai to use ws://127.0.0.1:8000
  static String wsUrl(String matchId) {
    return "ws://127.0.0.1:8000/ws/match/$matchId";
  }
}
