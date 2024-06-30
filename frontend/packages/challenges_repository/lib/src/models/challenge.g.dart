// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChallengeImpl _$$ChallengeImplFromJson(Map<String, dynamic> json) =>
    _$ChallengeImpl(
      name: json['name'] as String,
      id: json['id'] as String?,
      creator: json['creator'] == null
          ? null
          : User.fromJson(json['creator'] as String),
      finishesAt: json['finishesAt'] == null
          ? null
          : DateTime.parse(json['finishesAt'] as String),
      participants: (json['participants'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as String))
          .toList(),
      records: (json['records'] as List<dynamic>?)
          ?.map((e) => ChallengeRecord.fromJson(e as String))
          .toList(),
    );

Map<String, dynamic> _$$ChallengeImplToJson(_$ChallengeImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'creator': instance.creator,
      'finishesAt': instance.finishesAt?.toIso8601String(),
      'participants': instance.participants,
      'records': instance.records,
    };
