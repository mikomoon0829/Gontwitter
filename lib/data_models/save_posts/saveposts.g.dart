// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saveposts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SavePostsImpl _$$SavePostsImplFromJson(Map<String, dynamic> json) =>
    _$SavePostsImpl(
      userId: json['userId'] as String,
      postId: json['postId'] as String,
      savedAt:
          const TimestampConverter().fromJson(json['savedAt'] as Timestamp),
    );

Map<String, dynamic> _$$SavePostsImplToJson(_$SavePostsImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'postId': instance.postId,
      'savedAt': const TimestampConverter().toJson(instance.savedAt),
    };
