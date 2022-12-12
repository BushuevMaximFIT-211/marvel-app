import 'package:json_annotation/json_annotation.dart';

part 'hero_marvel.g.dart';

@JsonSerializable()
class HeroMarvel {
  @JsonKey(name: "name")
  final String name;

  @JsonKey(name: "description")
  final String info;

  @JsonKey(name: "thumbnail")
  final String thumbnail;

  HeroMarvel(this.name, this.info, this.thumbnail);

  factory HeroMarvel.fromJson(Map<String, dynamic> json) =>
      _$HeroMarvelFromJson(json);
  Map<String, dynamic> toJson() => _$HeroMarvelToJson(this);

  String getPath() => '$thumbnail.jpg';
}
