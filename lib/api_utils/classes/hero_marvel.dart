import 'package:json_annotation/json_annotation.dart';

part 'hero_marvel.g.dart';

@JsonSerializable()
class HeroMarvel {
  @JsonKey(name: "name")
  final String name;

  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "thumbnail")
  final String thumbnail;

  String info = '';

  HeroMarvel(this.name, this.id, this.thumbnail, this.info);

  factory HeroMarvel.fromJson(Map<String, dynamic> json) =>
      _$HeroMarvelFromJson(json);
  Map<String, dynamic> toJson() => _$HeroMarvelToJson(this);

  String getPath() => '$thumbnail.jpg';
}
