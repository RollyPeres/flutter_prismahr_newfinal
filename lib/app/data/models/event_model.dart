import 'package:flutter_prismahr/app/data/models/user_model.dart';

class Event {
  int id;
  String name;
  String date;
  String location;
  String details;
  List<User> participants;
  String createdAt;
  String updatedAt;
  User author;

  Event({
    this.id,
    this.name,
    this.location,
    this.details,
    this.date,
    this.participants,
    this.createdAt,
    this.updatedAt,
    this.author,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    List<User> participants = <User>[];
    if (json['participants'] != null) {
      final List listParticipant = json['participants'] as List;
      participants = listParticipant.map((p) => User.fromJson(p)).toList();
    }

    return Event(
      id: json['id'],
      name: json['name'],
      date: json['date'],
      location: json['location'],
      details: json['details'],
      participants: participants,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      author: User.fromJson(json['author']),
    );
  }
}
