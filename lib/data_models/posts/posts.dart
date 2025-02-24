import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:twitter/data_models/timestamp_converter.dart';

part 'posts.freezed.dart';
part 'posts.g.dart';

@freezed
class Posts with _$Posts {
  factory Posts(
      {required String imageUrl,
      required String postText,
      required String userId,
      required String postId,
      @TimestampConverter() required Timestamp createdAt,
      @TimestampConverter() required Timestamp updatedAt}) = _Posts;

  factory Posts.fromJson(Map<String, dynamic> json) => _$PostsFromJson(json);
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
