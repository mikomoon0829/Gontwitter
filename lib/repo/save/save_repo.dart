import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twitter/config/firebase/firebase_provider.dart';
import 'package:twitter/config/utils/keys/firebase_key.dart';
import 'package:twitter/data_models/posts/posts.dart';
import 'package:twitter/data_models/save_posts/saveposts.dart';
import 'package:twitter/repo/auth/auth_repo.dart';

part 'save_repo.g.dart';

@riverpod
//下のに変える
// class TaskRepo {
class SaveRepo extends _$SaveRepo {
//buildを加える
  @override
  CollectionReference<SavePosts> build(String userId) {
    // return FirebaseFirestore.instance
    //firebaseFirestore.instanceがref.read(firestoreProvider)に変わった！firebase_provider.dartを書くと！
    return ref
        .read(firebaseFirestoreProvider)
        .collection(FirebaseUsersKey.usersCollection)
        .doc(userId)
        .collection(FirebaseSavePostsKey.savePostsCollection)
        .withConverter<SavePosts>(
          fromFirestore: (snapshot, _) => SavePosts.fromJson(snapshot.data()!),
          toFirestore: (SavePosts value, _) => value.toJson(),
        );
  }
  // final db = FirebaseFirestore.instance
  //     .collection(FirebaseTaskKey.taskCollection)
  //     .withConverter<Task>(
  //       fromFirestore: (snapshot, _) => Task.fromJson(snapshot.data()!),
  //       toFirestore: (Task value, _) => value.toJson(),
  //     );

  //taskIdからドキュメント取得
  Future<SavePosts> getSavePost(String postId) async {
    final savePostDoc = await state.doc(postId).get();
    return savePostDoc.data()!;
  }

  //FutureでTaskListを取得
  Future<List<SavePosts>> getSavePosts() async {
    final snapshot = await state.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

////Task型データのリストを扱うとき
  Stream<List<SavePosts>> watchSavePosts() {
    // return db.orderBy('createdAt', descending: true).snapshots().map(
    return state
        .orderBy(FirebaseSavePostsKey.savedAt, descending: true)
        .snapshots()
        .map(
      //ここでmapとすることで、各要素として<QuerySnapshot<Task>>が入る
      //（Asyncじゃないから.dataを省略可能（.dataはviewの方で行う！））
      (QuerySnapshot<SavePosts> snapshot) {
        return snapshot.docs.map(
          //それぞれのドキュメントのどきゅめんとsnapshotのリストを返す。と思いきやリストの要素それぞれからTaskを取り出す処理を下で行う
          (QueryDocumentSnapshot<SavePosts> doc) {
            return doc.data();
          },
        ).toList();
      },
    );
  }

// //コレクションに入っているものは全てそのuserIdのものだからいらない
//   // ///自分が作ったTask型データのリストを扱うとき
//   Stream<List<SavePosts>> watchMySavePosts() {
//     // return db.orderBy('createdAt', descending: true).snapshots().map(
//     return state
//         .orderBy(FirebaseSavePostsKey.savedAt, descending: true)
//         .where(FirebaseSavePostsKey.userId,
//             isEqualTo: ref.watch(authRepoProvider)!.uid)
//         .snapshots()
//         .map(
//       //ここでmapとすることで、各要素として<QuerySnapshot<Task>>が入る
//       //（Asyncじゃないから.dataを省略可能（.dataはviewの方で行う！））
//       (QuerySnapshot<SavePosts> snapshot) {
//         return snapshot.docs.map(
//           //それぞれのドキュメントのどきゅめんとsnapshotのリストを返す。と思いきやリストの要素それぞれからTaskを取り出す処理を下で行う
//           (QueryDocumentSnapshot<SavePosts> doc) {
//             return doc.data();
//           },
//         ).toList();
//       },
//     );
//   }

//一件のTask型データを扱うとき
  Stream<SavePosts> watchSavePost(String postId) {
    // return db.doc('docId').snapshots().map(
    return state.doc(postId).snapshots().map(
      (DocumentSnapshot<SavePosts> snapshot) {
        return snapshot.data()!; //.data()でDocumentSnapshotを外せる
      },
    );
  }

//ドキュメント追加
  Future<void> addSavePost(SavePosts addPostData) async {
    // await db.doc(addTaskData.taskId).set(addTaskData);
    await state.doc(addPostData.postId).set(addPostData);
  }

//ドキュメント削除
  Future<void> deletePost(String postId) async {
    await state.doc(postId).delete();
  }

//保存にupdateもなにもないやろ
// //ドキュメント更新
//   Future<void> updatePost(SavePosts updatePostData) async {
//     await state.doc(updatePostData.postId).update(updatePostData.toJson());
//   }
}

// //watchTaskのみを切り出したプロバイダを作る
@riverpod
Stream<SavePosts> savePostStream(Ref ref, String postId, String userId) {
  return ref.watch(saveRepoProvider(userId).notifier).watchSavePost(postId);
  //snapshotでコレクションを監視したものの一覧を降順にならべたものが状態であるbasicProvider
  //その状態を返すということはstream型を返すプロバイダだからwhen使える！
  //これ切り出してなかったら、TaskRepoプロバイダは単に固定値を返すものやからwhen使えないよね！
}

// //watchTasksのみを切り出したプロバイダを作る
@riverpod
Stream<List<SavePosts>> savePostsStream(Ref ref, String userId) {
  return ref.watch(saveRepoProvider(userId).notifier).watchSavePosts();

  //snapshotでコレクションを監視したものの一覧を降順にならべたものが状態であるbasicProvider
  //その状態を返すということはstream型を返すプロバイダだからwhen使える！
  //これ切り出してなかったら、TaskRepoプロバイダは単に固定値を返すものやからwhen使えないよね！
}

// ///自分が作ったSavePosts型データのリストを見る,watchTasksのみを切り出したプロバイダを作る
// @riverpod
// Stream<List<SavePosts>> mySavePostsStream(Ref ref, String postId) {
//   return ref
//       .watch(saveRepoProvider(ref.watch(authRepoProvider)!.uid).notifier)
//       .watchSavePosts();
//     // .where(FirebaseSavePostsKey.postId,isEqualTo:postId);
//   //snapshotでコレクションを監視したものの一覧を降順にならべたものが状態であるbasicProvider
//   //その状態を返すということはstream型を返すプロバイダだからwhen使える！
//   //これ切り出してなかったら、TaskRepoプロバイダは単に固定値を返すものやからwhen使えないよね！
// }
