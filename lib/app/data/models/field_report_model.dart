import 'dart:convert';

import 'package:flutter_prismahr/app/data/models/image_model.dart';
import 'package:flutter_prismahr/app/data/models/user_model.dart';

class FieldReport {
  int id;
  String title;
  String chronology;
  List<ImageModel> images;
  User author;
  String createdAt;
  String updatedAt;
  List<User> participants;

  FieldReport.fromJson(Map<String, dynamic> json) {
    List<ImageModel> images = <ImageModel>[];
    List<User> participants = <User>[];
    User author = User();

    if (json['images'] != null) {
      final List rawImages = jsonDecode(json['images']) as List;
      images = rawImages.map((image) {
        return ImageModel.fromJson(image);
      }).toList();
    }

    if (json['participants'] != null) {
      final List rawParticipants = json['participants'] as List;
      participants = rawParticipants.map((participant) {
        return User.fromJson(participant);
      }).toList();
    }

    if (json['author'] != null) {
      author = User.fromJson(json['author']);
    }

    this.id = json['id'];
    this.title = json['title'];
    this.chronology = json['chronology'];
    this.images = images;
    this.author = author;
    this.createdAt = json['created_at'];
    this.updatedAt = json['updated_at'];
    this.participants = participants;
  }
}
