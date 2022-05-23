import 'package:json_annotation/json_annotation.dart';

part 'location_model.g.dart';

@JsonSerializable(createToJson: false)
class LocationModel {
  LocationModel({
    this.name,
    this.url,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  final String? name;
  final String? url;
}


