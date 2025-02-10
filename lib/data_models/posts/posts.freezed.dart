// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'posts.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Posts _$PostsFromJson(Map<String, dynamic> json) {
  return _Posts.fromJson(json);
}

/// @nodoc
mixin _$Posts {
  String get imageUrl => throw _privateConstructorUsedError;
  String get postText => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get postId => throw _privateConstructorUsedError;
  @TimestampConverter()
  Timestamp get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  Timestamp get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Posts to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Posts
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostsCopyWith<Posts> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostsCopyWith<$Res> {
  factory $PostsCopyWith(Posts value, $Res Function(Posts) then) =
      _$PostsCopyWithImpl<$Res, Posts>;
  @useResult
  $Res call(
      {String imageUrl,
      String postText,
      String userId,
      String postId,
      @TimestampConverter() Timestamp createdAt,
      @TimestampConverter() Timestamp updatedAt});
}

/// @nodoc
class _$PostsCopyWithImpl<$Res, $Val extends Posts>
    implements $PostsCopyWith<$Res> {
  _$PostsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Posts
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageUrl = null,
    Object? postText = null,
    Object? userId = null,
    Object? postId = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      postText: null == postText
          ? _value.postText
          : postText // ignore: cast_nullable_to_non_nullable
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
abstract class _$$PostsImplCopyWith<$Res> implements $PostsCopyWith<$Res> {
  factory _$$PostsImplCopyWith(
          _$PostsImpl value, $Res Function(_$PostsImpl) then) =
      __$$PostsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String imageUrl,
      String postText,
      String userId,
      String postId,
      @TimestampConverter() Timestamp createdAt,
      @TimestampConverter() Timestamp updatedAt});
}

/// @nodoc
class __$$PostsImplCopyWithImpl<$Res>
    extends _$PostsCopyWithImpl<$Res, _$PostsImpl>
    implements _$$PostsImplCopyWith<$Res> {
  __$$PostsImplCopyWithImpl(
      _$PostsImpl _value, $Res Function(_$PostsImpl) _then)
      : super(_value, _then);

  /// Create a copy of Posts
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageUrl = null,
    Object? postText = null,
    Object? userId = null,
    Object? postId = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$PostsImpl(
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      postText: null == postText
          ? _value.postText
          : postText // ignore: cast_nullable_to_non_nullable
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
class _$PostsImpl implements _Posts {
  _$PostsImpl(
      {required this.imageUrl,
      required this.postText,
      required this.userId,
      required this.postId,
      @TimestampConverter() required this.createdAt,
      @TimestampConverter() required this.updatedAt});

  factory _$PostsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostsImplFromJson(json);

  @override
  final String imageUrl;
  @override
  final String postText;
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
    return 'Posts(imageUrl: $imageUrl, postText: $postText, userId: $userId, postId: $postId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostsImpl &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.postText, postText) ||
                other.postText == postText) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, imageUrl, postText, userId, postId, createdAt, updatedAt);

  /// Create a copy of Posts
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostsImplCopyWith<_$PostsImpl> get copyWith =>
      __$$PostsImplCopyWithImpl<_$PostsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostsImplToJson(
      this,
    );
  }
}

abstract class _Posts implements Posts {
  factory _Posts(
      {required final String imageUrl,
      required final String postText,
      required final String userId,
      required final String postId,
      @TimestampConverter() required final Timestamp createdAt,
      @TimestampConverter() required final Timestamp updatedAt}) = _$PostsImpl;

  factory _Posts.fromJson(Map<String, dynamic> json) = _$PostsImpl.fromJson;

  @override
  String get imageUrl;
  @override
  String get postText;
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

  /// Create a copy of Posts
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostsImplCopyWith<_$PostsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
