import 'package:equatable/equatable.dart';
import 'package:plass_getx/lib/src/domain/entities/location_entity.dart';
import 'package:plass_getx/lib/src/domain/entities/origin_entity.dart';

class CharacterEntity extends Equatable {
  const CharacterEntity({
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

  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final OriginEntity? origin;
  final LocationEntity? location;
  final String image;
  final List<String> episode;
  final String url;


  ///Get Episodes
  List<String> get getEpisodesIds {
    var episodesList = Set<String>();
    episode.where((episode) => episodesList.add(episode.split('/')[5])).toList();
    return episodesList.toList();
  }

  ///Get First Episode
  String get getFirstEpisode {
    return episode.first.split('/')[5];
  }


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
