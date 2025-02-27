import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twitter/config/firebase/firebase_provider.dart';
import 'package:twitter/config/utils/keys/firebase_key.dart';
import 'package:twitter/data_models/posts/posts.dart';
import 'package:twitter/repo/auth/auth_repo.dart';

part 'post_repo.g.dart';

@riverpod
//下のに変える
// class TaskRepo {
class PostRepo extends _$PostRepo {
//buildを加える
  @override
  CollectionReference<Posts> build() {
    // return FirebaseFirestore.instance
    //firebaseFirestore.instanceがref.read(firestoreProvider)に変わった！firebase_provider.dartを書くと！
    return ref
        .read(firebaseFirestoreProvider)
        .collection(FirebasePostsKey.postsCollection)
        .withConverter<Posts>(
          fromFirestore: (snapshot, _) => Posts.fromJson(snapshot.data()!),
          toFirestore: (Posts value, _) => value.toJson(),
        );
  }
  // final db = FirebaseFirestore.instance
  //     .collection(FirebaseTaskKey.taskCollection)
  //     .withConverter<Task>(
  //       fromFirestore: (snapshot, _) => Task.fromJson(snapshot.data()!),
  //       toFirestore: (Task value, _) => value.toJson(),
  //     );

  //taskIdからドキュメント取得
  Future<Posts> getPost(String postId) async {
    final postDoc = await state.doc(postId).get();
    return postDoc.data()!;
  }

  //FutureでTaskListを取得
  Future<List<Posts>> getPosts() async {
    final snapshot = await state.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

////Task型データのリストを扱うとき
  Stream<List<Posts>> watchPosts() {
    // return db.orderBy('createdAt', descending: true).snapshots().map(
    return state
        .orderBy(FirebasePostsKey.createdAt, descending: true)
        .snapshots()
        .map(
      //ここでmapとすることで、各要素として<QuerySnapshot<Task>>が入る
      //（Asyncじゃないから.dataを省略可能（.dataはviewの方で行う！））
      (QuerySnapshot<Posts> snapshot) {
        return snapshot.docs.map(
          //それぞれのドキュメントのどきゅめんとsnapshotのリストを返す。と思いきやリストの要素それぞれからTaskを取り出す処理を下で行う
          (QueryDocumentSnapshot<Posts> doc) {
            return doc.data();
          },
        ).toList();
      },
    );
  }

  ///自分が作ったTask型データのリストを扱うとき
  Stream<List<Posts>> watchMyPosts() {
    // return db.orderBy('createdAt', descending: true).snapshots().map(
    return state
        .orderBy(FirebasePostsKey.createdAt, descending: true)
        .where(FirebasePostsKey.userId,
            isEqualTo: ref.watch(authRepoProvider)!.uid)
        .snapshots()
        .map(
      //ここでmapとすることで、各要素として<QuerySnapshot<Task>>が入る
      //（Asyncじゃないから.dataを省略可能（.dataはviewの方で行う！））
      (QuerySnapshot<Posts> snapshot) {
        return snapshot.docs.map(
          //それぞれのドキュメントのどきゅめんとsnapshotのリストを返す。と思いきやリストの要素それぞれからTaskを取り出す処理を下で行う
          (QueryDocumentSnapshot<Posts> doc) {
            return doc.data();
          },
        ).toList();
      },
    );
  }

//一件のTask型データを扱うとき
  Stream<Posts> watchPost(String postId) {
    // return db.doc('docId').snapshots().map(
    return state.doc(postId).snapshots().map(
      (DocumentSnapshot<Posts> snapshot) {
        return snapshot.data()!; //.data()でDocumentSnapshotを外せる
      },
    );
  }

//ドキュメント追加
  Future<void> addPost(Posts addPostData) async {
    // await db.doc(addTaskData.taskId).set(addTaskData);
    await state.doc(addPostData.postId).set(addPostData);
  }

  //ドキュメント削除
  Future<void> deletePost(String postId) async {
    await state.doc(postId).delete();
  }

//ドキュメント更新
  Future<void> updatePost(Posts updatePostData) async {
    await state.doc(updatePostData.postId).update(updatePostData.toJson());
  }
}

// //watchTaskのみを切り出したプロバイダを作る
@riverpod
Stream<Posts> postStream(Ref ref, String postId) {
  return ref.watch(postRepoProvider.notifier).watchPost(postId);
  //snapshotでコレクションを監視したものの一覧を降順にならべたものが状態であるbasicProvider
  //その状態を返すということはstream型を返すプロバイダだからwhen使える！
  //これ切り出してなかったら、TaskRepoプロバイダは単に固定値を返すものやからwhen使えないよね！
}

// //watchTasksのみを切り出したプロバイダを作る
@riverpod
Stream<List<Posts>> postsStream(Ref ref) {
  return ref.watch(postRepoProvider.notifier).watchPosts();
  //snapshotでコレクションを監視したものの一覧を降順にならべたものが状態であるbasicProvider
  //その状態を返すということはstream型を返すプロバイダだからwhen使える！
  //これ切り出してなかったら、TaskRepoプロバイダは単に固定値を返すものやからwhen使えないよね！
}

// //watchTasksのみを切り出したプロバイダを作る
@riverpod
Stream<List<Posts>> myPostsStream(Ref ref) {
  return ref.watch(postRepoProvider.notifier).watchMyPosts();
  //snapshotでコレクションを監視したものの一覧を降順にならべたものが状態であるbasicProvider
  //その状態を返すということはstream型を返すプロバイダだからwhen使える！
  //これ切り出してなかったら、TaskRepoプロバイダは単に固定値を返すものやからwhen使えないよね！
}
