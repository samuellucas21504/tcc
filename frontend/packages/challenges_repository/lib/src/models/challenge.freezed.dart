// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'challenge.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Challenge _$ChallengeFromJson(Map<String, dynamic> json) {
  return _Challenge.fromJson(json);
}

/// @nodoc
mixin _$Challenge {
  String get name => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;
  User? get creator => throw _privateConstructorUsedError;
  DateTime? get finishesAt => throw _privateConstructorUsedError;
  List<User>? get participants => throw _privateConstructorUsedError;
  List<ChallengeRecord>? get records => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChallengeCopyWith<Challenge> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChallengeCopyWith<$Res> {
  factory $ChallengeCopyWith(Challenge value, $Res Function(Challenge) then) =
      _$ChallengeCopyWithImpl<$Res, Challenge>;
  @useResult
  $Res call(
      {String name,
      String? id,
      User? creator,
      DateTime? finishesAt,
      List<User>? participants,
      List<ChallengeRecord>? records});

  $UserCopyWith<$Res>? get creator;
}

/// @nodoc
class _$ChallengeCopyWithImpl<$Res, $Val extends Challenge>
    implements $ChallengeCopyWith<$Res> {
  _$ChallengeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = freezed,
    Object? creator = freezed,
    Object? finishesAt = freezed,
    Object? participants = freezed,
    Object? records = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      creator: freezed == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as User?,
      finishesAt: freezed == finishesAt
          ? _value.finishesAt
          : finishesAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      participants: freezed == participants
          ? _value.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<User>?,
      records: freezed == records
          ? _value.records
          : records // ignore: cast_nullable_to_non_nullable
              as List<ChallengeRecord>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get creator {
    if (_value.creator == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.creator!, (value) {
      return _then(_value.copyWith(creator: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChallengeImplCopyWith<$Res>
    implements $ChallengeCopyWith<$Res> {
  factory _$$ChallengeImplCopyWith(
          _$ChallengeImpl value, $Res Function(_$ChallengeImpl) then) =
      __$$ChallengeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String? id,
      User? creator,
      DateTime? finishesAt,
      List<User>? participants,
      List<ChallengeRecord>? records});

  @override
  $UserCopyWith<$Res>? get creator;
}

/// @nodoc
class __$$ChallengeImplCopyWithImpl<$Res>
    extends _$ChallengeCopyWithImpl<$Res, _$ChallengeImpl>
    implements _$$ChallengeImplCopyWith<$Res> {
  __$$ChallengeImplCopyWithImpl(
      _$ChallengeImpl _value, $Res Function(_$ChallengeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = freezed,
    Object? creator = freezed,
    Object? finishesAt = freezed,
    Object? participants = freezed,
    Object? records = freezed,
  }) {
    return _then(_$ChallengeImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      creator: freezed == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as User?,
      finishesAt: freezed == finishesAt
          ? _value.finishesAt
          : finishesAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      participants: freezed == participants
          ? _value._participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<User>?,
      records: freezed == records
          ? _value._records
          : records // ignore: cast_nullable_to_non_nullable
              as List<ChallengeRecord>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChallengeImpl implements _Challenge {
  const _$ChallengeImpl(
      {required this.name,
      this.id,
      this.creator,
      this.finishesAt,
      final List<User>? participants,
      final List<ChallengeRecord>? records})
      : _participants = participants,
        _records = records;

  factory _$ChallengeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChallengeImplFromJson(json);

  @override
  final String name;
  @override
  final String? id;
  @override
  final User? creator;
  @override
  final DateTime? finishesAt;
  final List<User>? _participants;
  @override
  List<User>? get participants {
    final value = _participants;
    if (value == null) return null;
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ChallengeRecord>? _records;
  @override
  List<ChallengeRecord>? get records {
    final value = _records;
    if (value == null) return null;
    if (_records is EqualUnmodifiableListView) return _records;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Challenge(name: $name, id: $id, creator: $creator, finishesAt: $finishesAt, participants: $participants, records: $records)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChallengeImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.creator, creator) || other.creator == creator) &&
            (identical(other.finishesAt, finishesAt) ||
                other.finishesAt == finishesAt) &&
            const DeepCollectionEquality()
                .equals(other._participants, _participants) &&
            const DeepCollectionEquality().equals(other._records, _records));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      id,
      creator,
      finishesAt,
      const DeepCollectionEquality().hash(_participants),
      const DeepCollectionEquality().hash(_records));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChallengeImplCopyWith<_$ChallengeImpl> get copyWith =>
      __$$ChallengeImplCopyWithImpl<_$ChallengeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChallengeImplToJson(
      this,
    );
  }
}

abstract class _Challenge implements Challenge {
  const factory _Challenge(
      {required final String name,
      final String? id,
      final User? creator,
      final DateTime? finishesAt,
      final List<User>? participants,
      final List<ChallengeRecord>? records}) = _$ChallengeImpl;

  factory _Challenge.fromJson(Map<String, dynamic> json) =
      _$ChallengeImpl.fromJson;

  @override
  String get name;
  @override
  String? get id;
  @override
  User? get creator;
  @override
  DateTime? get finishesAt;
  @override
  List<User>? get participants;
  @override
  List<ChallengeRecord>? get records;
  @override
  @JsonKey(ignore: true)
  _$$ChallengeImplCopyWith<_$ChallengeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
