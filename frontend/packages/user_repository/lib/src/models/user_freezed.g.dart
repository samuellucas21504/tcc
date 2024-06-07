// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_freezed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      name: json['name'] as String,
      email: json['email'] as String,
      habitRegistered: json['habitRegistered'] as bool,
      registeredAt: json['registeredAt'] == null
          ? null
          : DateTime.parse(json['registeredAt'] as String),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'habitRegistered': instance.habitRegistered,
      'registeredAt': instance.registeredAt?.toIso8601String(),
    };
