import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:plass_getx/lib/src/data/models/location_model.dart';
import 'package:plass_getx/lib/src/data/models/origin_model.dart';

part 'character_model.g.dart';

@JsonSerializable(createToJson: false)
class CharacterModel extends Equatable {
  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    this.origin,
    this.location,
    required this.image,
    required this.episode,
    required this.url,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);

  ///Get Episodes
  List<String> get getEpisodesIds {
    var episodesList = Set<String>();
    episode
        .where((episode) => episodesList.add(episode.split('/')[5]))
        .toList();
    return episodesList.toList();
  }

  ///Get First Episode
  String get getFirstEpisode {
    return episode.first.split('/')[5];
  }

  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final OriginModel? origin;
  final LocationModel? location;
  final String image;
  final List<String> episode;
  final String url;

  @override
  List<Object?> get props => [
        id,
        name,
        status,
        species,
        type,
        gender,
        origin,
        location,
        image,
        episode,
        url,
      ];
}
