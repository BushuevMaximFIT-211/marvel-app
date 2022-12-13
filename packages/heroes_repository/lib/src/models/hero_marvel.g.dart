// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hero_marvel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HeroMarvel _$HeroMarvelFromJson(Map<String, dynamic> json) => HeroMarvel(
      json['name'].toString().contains('(')
          ? json['name']
              .toString()
              .substring(0, json['name'].toString().indexOf('('))
          : json['name'] as String,
      json['id'] as int,
      json['thumbnail']['path'] as String,
      json['info'] as String?,
    );

Map<String, dynamic> _$HeroMarvelToJson(HeroMarvel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'thumbnail': {'path': instance.thumbnail},
      'info': instance.info,
    };
