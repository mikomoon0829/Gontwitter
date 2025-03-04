// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liked_by.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LikedByImpl _$$LikedByImplFromJson(Map<String, dynamic> json) =>
    _$LikedByImpl(
      likeId: json['likeId'] as String,
      userId: json['userId'] as String,
      postId: json['postId'] as String,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      updatedAt:
          const TimestampConverter().fromJson(json['updatedAt'] as Timestamp),
    );

Map<String, dynamic> _$$LikedByImplToJson(_$LikedByImpl instance) =>
    <String, dynamic>{
      'likeId': instance.likeId,
      'userId': instance.userId,
      'postId': instance.postId,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };
