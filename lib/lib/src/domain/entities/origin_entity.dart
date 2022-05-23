import 'package:equatable/equatable.dart';

class OriginEntity extends Equatable {
  const OriginEntity({
    required this.name,
    this.url,
  });

  final String name;
  final String? url;

  @override
  List<Object?> get props => [
    name,
    url,
  ];
}
