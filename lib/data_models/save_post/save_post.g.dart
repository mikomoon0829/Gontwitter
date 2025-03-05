// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SavePostImpl _$$SavePostImplFromJson(Map<String, dynamic> json) =>
    _$SavePostImpl(
      savePostId: json['savePostId'] as String,
      userId: json['userId'] as String,
      postId: json['postId'] as String,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      updatedAt:
          const TimestampConverter().fromJson(json['updatedAt'] as Timestamp),
    );

Map<String, dynamic> _$$SavePostImplToJson(_$SavePostImpl instance) =>
    <String, dynamic>{
      'savePostId': instance.savePostId,
      'userId': instance.userId,
      'postId': instance.postId,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };
