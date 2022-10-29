import 'package:json_annotation/json_annotation.dart';
import 'package:marvel_app/api_utils/classes/hero_marvel.dart';
part 'hero_list_response.g.dart';

@JsonSerializable()
class HeroListResponse {
  HeroListResponse();
  @JsonKey(name: 'results')
  List<HeroMarvel>? listHeroes;

  factory HeroListResponse.fromJson(Map<String, dynamic> json) =>
      _$HeroListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HeroListResponseToJson(this);
}
