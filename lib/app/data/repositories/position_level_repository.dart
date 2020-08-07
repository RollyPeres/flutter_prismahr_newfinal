import 'package:flutter_prismahr/app/data/models/position_level_model.dart';
import 'package:flutter_prismahr/app/data/providers/position_level_provider.dart';

class PositionLevelRepository {
  final PositionLevelProvider provider = PositionLevelProvider();

  Future<List<PositionLevel>> fetch() {
    return provider.fetch();
  }
}
