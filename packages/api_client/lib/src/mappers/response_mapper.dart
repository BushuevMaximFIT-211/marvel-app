import 'package:json_annotation/json_annotation.dart';

part 'response_mapper.g.dart';

@JsonSerializable()
class ResponseMapper {
  final String status;
  @JsonKey(name: 'total')
  final int totalResults;
  @JsonKey(name: 'results')
  final List<Map<String, dynamic>> heroes;

  ResponseMapper({
    required this.status,
    required this.totalResults,
    required this.heroes,
  });

  factory ResponseMapper.fromJson(Map<String, dynamic> json) =>
      _$ResponseMapperFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMapperToJson(this);
}
