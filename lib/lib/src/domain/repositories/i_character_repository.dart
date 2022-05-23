import 'package:plass_getx/lib/src/data/models/character_model.dart';
import 'package:plass_getx/lib/src/domain/entities/character_search_entity.dart';

abstract class ICharacterRepository {
  Future<List<CharacterModel>?> getCharacterList(CharacterSearchData data);
  Future<CharacterModel?> getCharacter(String characterId);
  Future<List<CharacterModel>?> getRandomCharacterList(List<String> characterIds);
}
