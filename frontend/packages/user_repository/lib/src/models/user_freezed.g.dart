// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_freezed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      name: json['name'] as String,
      email: json['email'] as String?,
      habitRegistered: json['habitRegistered'] as bool?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'habitRegistered': instance.habitRegistered,
      'token': instance.token,
    };
