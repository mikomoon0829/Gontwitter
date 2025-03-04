// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'liked_by.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LikedBy _$LikedByFromJson(Map<String, dynamic> json) {
  return _LikedBy.fromJson(json);
}

/// @nodoc
mixin _$LikedBy {
  String get likeId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get postId => throw _privateConstructorUsedError;
  @TimestampConverter()
  Timestamp get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  Timestamp get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this LikedBy to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LikedBy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LikedByCopyWith<LikedBy> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LikedByCopyWith<$Res> {
  factory $LikedByCopyWith(LikedBy value, $Res Function(LikedBy) then) =
      _$LikedByCopyWithImpl<$Res, LikedBy>;
  @useResult
  $Res call(
      {String likeId,
      String userId,
      String postId,
      @TimestampConverter() Timestamp createdAt,
      @TimestampConverter() Timestamp updatedAt});
}

/// @nodoc
class _$LikedByCopyWithImpl<$Res, $Val extends LikedBy>
    implements $LikedByCopyWith<$Res> {
  _$LikedByCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LikedBy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? likeId = null,
    Object? userId = null,
    Object? postId = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      likeId: null == likeId
          ? _value.likeId
          : likeId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as Timestamp,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as Timestamp,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LikedByImplCopyWith<$Res> implements $LikedByCopyWith<$Res> {
  factory _$$LikedByImplCopyWith(
          _$LikedByImpl value, $Res Function(_$LikedByImpl) then) =
      __$$LikedByImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String likeId,
      String userId,
      String postId,
      @TimestampConverter() Timestamp createdAt,
      @TimestampConverter() Timestamp updatedAt});
}

/// @nodoc
class __$$LikedByImplCopyWithImpl<$Res>
    extends _$LikedByCopyWithImpl<$Res, _$LikedByImpl>
    implements _$$LikedByImplCopyWith<$Res> {
  __$$LikedByImplCopyWithImpl(
      _$LikedByImpl _value, $Res Function(_$LikedByImpl) _then)
      : super(_value, _then);

  /// Create a copy of LikedBy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? likeId = null,
    Object? userId = null,
    Object? postId = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$LikedByImpl(
      likeId: null == likeId
          ? _value.likeId
          : likeId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as Timestamp,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as Timestamp,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LikedByImpl implements _LikedBy {
  _$LikedByImpl(
      {required this.likeId,
      required this.userId,
      required this.postId,
      @TimestampConverter() required this.createdAt,
      @TimestampConverter() required this.updatedAt});

  factory _$LikedByImpl.fromJson(Map<String, dynamic> json) =>
      _$$LikedByImplFromJson(json);

  @override
  final String likeId;
  @override
  final String userId;
  @override
  final String postId;
  @override
  @TimestampConverter()
  final Timestamp createdAt;
  @override
  @TimestampConverter()
  final Timestamp updatedAt;

  @override
  String toString() {
    return 'LikedBy(likeId: $likeId, userId: $userId, postId: $postId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LikedByImpl &&
            (identical(other.likeId, likeId) || other.likeId == likeId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, likeId, userId, postId, createdAt, updatedAt);

  /// Create a copy of LikedBy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LikedByImplCopyWith<_$LikedByImpl> get copyWith =>
      __$$LikedByImplCopyWithImpl<_$LikedByImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LikedByImplToJson(
      this,
    );
  }
}

abstract class _LikedBy implements LikedBy {
  factory _LikedBy(
          {required final String likeId,
          required final String userId,
          required final String postId,
          @TimestampConverter() required final Timestamp createdAt,
          @TimestampConverter() required final Timestamp updatedAt}) =
      _$LikedByImpl;

  factory _LikedBy.fromJson(Map<String, dynamic> json) = _$LikedByImpl.fromJson;

  @override
  String get likeId;
  @override
  String get userId;
  @override
  String get postId;
  @override
  @TimestampConverter()
  Timestamp get createdAt;
  @override
  @TimestampConverter()
  Timestamp get updatedAt;

  /// Create a copy of LikedBy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LikedByImplCopyWith<_$LikedByImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
