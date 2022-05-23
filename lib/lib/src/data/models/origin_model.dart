import 'package:json_annotation/json_annotation.dart';

part 'origin_model.g.dart';

@JsonSerializable(createToJson: false)
class OriginModel {
  OriginModel({
    required this.name,
    this.url,
  });

  factory OriginModel.fromJson(Map<String, dynamic> json) =>
      _$OriginModelFromJson(json);

  final String name;
  final String? url;
}


