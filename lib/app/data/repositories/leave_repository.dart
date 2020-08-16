import 'package:flutter_prismahr/app/data/models/leave_model.dart';
import 'package:flutter_prismahr/app/data/providers/leave_provider.dart';

class LeaveRepository {
  final LeaveProvider provider = LeaveProvider();

  Future<List<Leave>> fetch() {
    return provider.fetch();
  }

  Future<dynamic> add(Map<String, dynamic> data) {
    return provider.store(data);
  }
}
