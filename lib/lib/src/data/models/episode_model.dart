import 'package:json_annotation/json_annotation.dart';

part 'episode_model.g.dart';

@JsonSerializable(createToJson: false)
class EpisodeModel {
  EpisodeModel({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.characters,
    required this.url,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) =>
      _$EpisodeModelFromJson(json);

  final int id;
  final String name;
  @JsonKey(name: 'air_date')
  final String airDate;
  final String episode;
  final List<String> characters;
  final String url;
}


