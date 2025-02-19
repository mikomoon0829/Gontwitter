// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saveposts.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SavePosts _$SavePostsFromJson(Map<String, dynamic> json) {
  return _SavePosts.fromJson(json);
}

/// @nodoc
mixin _$SavePosts {
  String get userId => throw _privateConstructorUsedError;
  String get postId => throw _privateConstructorUsedError;
  @TimestampConverter()
  Timestamp get savedAt => throw _privateConstructorUsedError;

  /// Serializes this SavePosts to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SavePosts
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SavePostsCopyWith<SavePosts> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavePostsCopyWith<$Res> {
  factory $SavePostsCopyWith(SavePosts value, $Res Function(SavePosts) then) =
      _$SavePostsCopyWithImpl<$Res, SavePosts>;
  @useResult
  $Res call(
      {String userId, String postId, @TimestampConverter() Timestamp savedAt});
}

/// @nodoc
class _$SavePostsCopyWithImpl<$Res, $Val extends SavePosts>
    implements $SavePostsCopyWith<$Res> {
  _$SavePostsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SavePosts
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? postId = null,
    Object? savedAt = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      savedAt: null == savedAt
          ? _value.savedAt
          : savedAt // ignore: cast_nullable_to_non_nullable
              as Timestamp,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SavePostsImplCopyWith<$Res>
    implements $SavePostsCopyWith<$Res> {
  factory _$$SavePostsImplCopyWith(
          _$SavePostsImpl value, $Res Function(_$SavePostsImpl) then) =
      __$$SavePostsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId, String postId, @TimestampConverter() Timestamp savedAt});
}

/// @nodoc
class __$$SavePostsImplCopyWithImpl<$Res>
    extends _$SavePostsCopyWithImpl<$Res, _$SavePostsImpl>
    implements _$$SavePostsImplCopyWith<$Res> {
  __$$SavePostsImplCopyWithImpl(
      _$SavePostsImpl _value, $Res Function(_$SavePostsImpl) _then)
      : super(_value, _then);

  /// Create a copy of SavePosts
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? postId = null,
    Object? savedAt = null,
  }) {
    return _then(_$SavePostsImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      savedAt: null == savedAt
          ? _value.savedAt
          : savedAt // ignore: cast_nullable_to_non_nullable
              as Timestamp,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SavePostsImpl implements _SavePosts {
  _$SavePostsImpl(
      {required this.userId,
      required this.postId,
      @TimestampConverter() required this.savedAt});

  factory _$SavePostsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SavePostsImplFromJson(json);

  @override
  final String userId;
  @override
  final String postId;
  @override
  @TimestampConverter()
  final Timestamp savedAt;

  @override
  String toString() {
    return 'SavePosts(userId: $userId, postId: $postId, savedAt: $savedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavePostsImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.savedAt, savedAt) || other.savedAt == savedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, postId, savedAt);

  /// Create a copy of SavePosts
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SavePostsImplCopyWith<_$SavePostsImpl> get copyWith =>
      __$$SavePostsImplCopyWithImpl<_$SavePostsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SavePostsImplToJson(
      this,
    );
  }
}

abstract class _SavePosts implements SavePosts {
  factory _SavePosts(
          {required final String userId,
          required final String postId,
          @TimestampConverter() required final Timestamp savedAt}) =
      _$SavePostsImpl;

  factory _SavePosts.fromJson(Map<String, dynamic> json) =
      _$SavePostsImpl.fromJson;

  @override
  String get userId;
  @override
  String get postId;
  @override
  @TimestampConverter()
  Timestamp get savedAt;

  /// Create a copy of SavePosts
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SavePostsImplCopyWith<_$SavePostsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
