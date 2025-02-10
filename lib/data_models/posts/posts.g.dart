// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostsImpl _$$PostsImplFromJson(Map<String, dynamic> json) => _$PostsImpl(
      imageUrl: json['imageUrl'] as String,
      postText: json['postText'] as String,
      userId: json['userId'] as String,
      postId: json['postId'] as String,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      updatedAt:
          const TimestampConverter().fromJson(json['updatedAt'] as Timestamp),
    );

Map<String, dynamic> _$$PostsImplToJson(_$PostsImpl instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'postText': instance.postText,
      'userId': instance.userId,
      'postId': instance.postId,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };
