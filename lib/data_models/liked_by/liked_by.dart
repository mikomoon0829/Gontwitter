import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:twitter/data_models/timestamp_converter.dart';

part 'liked_by.freezed.dart';
part 'liked_by.g.dart';

@freezed
class LikedBy with _$LikedBy {
  factory LikedBy({
    required String likedById,
    required String userId,
    required String postId,
    @TimestampConverter() required Timestamp createdAt,
    @TimestampConverter() required Timestamp updatedAt,
  }) = _LikedBy;

  factory LikedBy.fromJson(Map<String, dynamic> json) =>
      _$LikedByFromJson(json);
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
