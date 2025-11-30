import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../config/app_config.dart';

class WebsocketService {
  late WebSocketChannel channel;

  void connect(String matchId) {
    channel = WebSocketChannel.connect(
      Uri.parse(AppConfig.wsUrl(matchId)),
    );
  }

  Stream<dynamic> get stream => channel.stream.map((event) {
        return jsonDecode(event);
      });

  void dispose() {
    channel.sink.close();
  }
}
