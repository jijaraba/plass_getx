import 'package:dio/dio.dart';
import 'package:plass_getx/lib/src/core/interceptors/logging_interceptors.dart';
import 'package:plass_getx/lib/src/data/models/character_model.dart';
import 'package:plass_getx/lib/src/domain/entities/character_search_entity.dart';
import 'package:plass_getx/lib/src/domain/repositories/i_character_repository.dart';

class CharacterRepository implements ICharacterRepository {
  final Dio _dio = Dio(BaseOptions(
      baseUrl: 'https://rickandmortyapi.com/api', connectTimeout: 15000))
    ..interceptors.add(LoggingInterceptor());

  Future<List<CharacterModel>?> getCharacterList(
      CharacterSearchData data) async {
    try {
      final response = await _dio.get(
        '/character/${data.toQueryParam()}',
      );
      if (response.statusCode == 200) {
        return (response.data['results']! as List)
            .map((x) => CharacterModel.fromJson(x))
            .toList();
      }
      return null;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<CharacterModel?> getCharacter(String characterId) async {
    try {
      final response = await _dio.get(
        '/character/${characterId}',
      );
      if (response.statusCode == 200) {
        return CharacterModel.fromJson(response.data!);
      }
      return null;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<List<CharacterModel>?> getRandomCharacterList(
      List<String> characterIds) async {
    try {
      final response = await _dio.get(
        '/character/${characterIds}',
      );
      if (response.statusCode == 200) {
        return (response.data! as List)
            .map((x) => CharacterModel.fromJson(x))
            .toList();
      }
      return null;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

}
