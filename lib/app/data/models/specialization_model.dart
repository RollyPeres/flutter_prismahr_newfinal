import 'package:flutter_prismahr/app/data/models/workfield_model.dart';

class Specialization {
  int id;
  String name;
  List<Workfield> workfields;

  Specialization({id, name, workfields});

  Specialization.fromJson(Map<String, dynamic> json) {
    final List listWorkfields = json['work_fields'] as List;
    final List<Workfield> workfields = listWorkfields
        .map((workfield) => Workfield.fromJson(workfield))
        .toList();

    this.id = json['id'];
    this.name = json['name'];
    this.workfields = workfields;
  }
}
