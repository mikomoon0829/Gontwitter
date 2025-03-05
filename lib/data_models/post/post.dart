import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:twitter/data_models/timestamp_converter.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  factory Post(
      {required String imageUrl,
      required String postText,
      required String userId,
      required String postId,
      @TimestampConverter() required Timestamp createdAt,
      @TimestampConverter() required Timestamp updatedAt}) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}

// class TimestampConverter implements JsonConverter<Timestamp, Timestamp> {
//   const TimestampConverter();

//   @override
//   Timestamp fromJson(Timestamp timestamp) {
//     return timestamp;
//   }

//   @override
//   Timestamp toJson(Timestamp date) => date;
// }
