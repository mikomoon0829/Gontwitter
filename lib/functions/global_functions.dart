import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:twitter/data_models/liked_by/likedby.dart';
import 'package:twitter/data_models/posts/posts.dart';
import 'package:twitter/data_models/save_posts/saveposts.dart';
import 'package:twitter/data_models/user_data/userdata.dart';

void showToast(String toastMessage) {
  Fluttertoast.showToast(
      msg: toastMessage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 24);
}

final postsReference =
    FirebaseFirestore.instance.collection('posts').withConverter<Posts>(
  // <> ここに変換したい型名をいれます。今回は Post です。
  fromFirestore: ((snapshot, _) {
    // 第二引数は使わないのでその場合は _ で不使用であることを分かりやすくしています。
    return Posts.fromJson(
        snapshot.data()!); // 先ほど定期着した fromFirestore がここで活躍します。
  }),
  toFirestore: ((value, _) {
    return value.toJson(); // 先ほど適宜した toMap がここで活躍します。
  }),
);

final userDataReference =
    FirebaseFirestore.instance.collection('users').withConverter<UserData>(
  // <> ここに変換したい型名をいれます。今回は Post です。
  fromFirestore: ((snapshot, _) {
    // 第二引数は使わないのでその場合は _ で不使用であることを分かりやすくしています。
    return UserData.fromJson(
        snapshot.data()!); // 先ほど定期着した fromFirestore がここで活躍します。
  }),
  toFirestore: ((value, _) {
    return value.toJson(); // 先ほど適宜した toMap がここで活躍します。
  }),
);

final savePostsReference = FirebaseFirestore.instance
    .collection("users")
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .collection('savePosts')
    .withConverter<SavePosts>(
  // <> ここに変換したい型名をいれます。今回は Post です。
  fromFirestore: ((snapshot, _) {
    // 第二引数は使わないのでその場合は _ で不使用であることを分かりやすくしています。
    return SavePosts.fromJson(
        snapshot.data()!); // 先ほど定期着した fromFirestore がここで活躍します。
  }),
  toFirestore: ((value, _) {
    return value.toJson(); // 先ほど適宜した toMap がここで活躍します。
  }),
);

CollectionReference<LikedBy> getLikedReference(String postId) {
  final likedByReference = FirebaseFirestore.instance
      .collection("posts")
      .doc(postId)
      .collection('likedBy')
      .withConverter<LikedBy>(
    // <> ここに変換したい型名をいれます。今回は Post です。
    fromFirestore: ((snapshot, _) {
      // 第二引数は使わないのでその場合は _ で不使用であることを分かりやすくしています。
      return LikedBy.fromJson(
          snapshot.data()!); // 先ほど定期着した fromFirestore がここで活躍します。
    }),
    toFirestore: ((value, _) {
      return value.toJson(); // 先ほど適宜した toMap がここで活躍します。
    }),
  );
  return likedByReference;
}
