// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'likedby.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LikedByImpl _$$LikedByImplFromJson(Map<String, dynamic> json) =>
    _$LikedByImpl(
      userId: json['userId'] as String,
      postId: json['postId'] as String,
      likedAt:
          const TimestampConverter().fromJson(json['likedAt'] as Timestamp),
    );

Map<String, dynamic> _$$LikedByImplToJson(_$LikedByImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'postId': instance.postId,
      'likedAt': const TimestampConverter().toJson(instance.likedAt),
    };
