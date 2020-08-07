import 'package:dio/dio.dart';
import 'package:flutter_prismahr/app/data/models/position_level_model.dart';
import 'package:flutter_prismahr/utils/request.dart';

class PositionLevelProvider {
  final Dio httpClient = Request.dio;

  Future<List<PositionLevel>> fetch() async {
    try {
      final Response response = await httpClient.get('positionLevels');
      final List list = response.data['data'] as List;

      final List<PositionLevel> levels =
          list.map((level) => PositionLevel.fromJson(level)).toList();

      return levels;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
