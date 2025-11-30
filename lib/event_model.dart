class EventModel {
  final String type;
  final dynamic data;

  EventModel({required this.type, required this.data});

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      type: json['type'],
      data: json['data'],
    );
  }
}
