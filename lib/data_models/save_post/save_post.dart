import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:twitter/functions/timestamp_converter.dart';

part 'save_post.freezed.dart';
part 'save_post.g.dart';

@freezed
class SavePost with _$SavePost {
  factory SavePost({
    required String savePostId,
    required String userId,
    required String postId,
    @TimestampConverter() required Timestamp createdAt,
    @TimestampConverter() required Timestamp updatedAt,
  }) = _SavePost;

  factory SavePost.fromJson(Map<String, dynamic> json) =>
      _$SavePostFromJson(json);
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
