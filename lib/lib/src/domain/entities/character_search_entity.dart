import 'package:equatable/equatable.dart';

enum CharacterSearchDataFormGender {
  all,
  unknown,
  female,
  male,
  genderless,
}

class CharacterSearchData extends Equatable {
  const CharacterSearchData({
    required this.search,
    required this.page,
    required this.gender,
    this.characterIds,
  });

  final int page;
  final String search;
  final CharacterSearchDataFormGender gender;
  final List<String>? characterIds;

  String toQueryParam() {
    final buffer = StringBuffer();

    final ids = characterIds ?? '';
    if (ids != '') {
      buffer
        ..write(characterIds!.isEmpty ? '' : characterIds);
    }
    buffer
      ..write('?')
      ..write('page=$page');
    if (search != '') {
      buffer
        ..write('&')
        ..write('name=$search');
    }
    if (gender != CharacterSearchDataFormGender.all) {
      print(CharacterSearchDataFormGender.all);
      buffer
        ..write('&')
        ..write('gender=${gender.name}');
    }
    return buffer.toString();
  }

  @override
  List<Object?> get props => [
        page,
        search,
        gender,
        characterIds,
      ];
}
