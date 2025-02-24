import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:twitter/data_models/timestamp_converter.dart';

part 'saveposts.freezed.dart';
part 'saveposts.g.dart';

@freezed
class SavePosts with _$SavePosts {
  factory SavePosts({
    required String userId,
    required String postId,
    @TimestampConverter() required Timestamp savedAt,
  }) = _SavePosts;

  factory SavePosts.fromJson(Map<String, dynamic> json) =>
      _$SavePostsFromJson(json);
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
