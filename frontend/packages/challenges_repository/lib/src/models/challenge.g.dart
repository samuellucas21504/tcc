// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChallengeImpl _$$ChallengeImplFromJson(Map<String, dynamic> json) =>
    _$ChallengeImpl(
      name: json['name'] as String,
      creator: json['creator'] == null
          ? null
          : User.fromJson(json['creator'] as String),
      participants: (json['participants'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as String))
          .toList(),
    );

Map<String, dynamic> _$$ChallengeImplToJson(_$ChallengeImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'creator': instance.creator,
      'participants': instance.participants,
    };
