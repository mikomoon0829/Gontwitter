import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:twitter/config/firebase/firebase_provider.dart';
import 'package:twitter/config/utils/keys/firebase_key.dart';
import 'package:twitter/data_models/liked_by/liked_by.dart';
part 'liked_by_repo.g.dart';

@riverpod
class LikedByRepo extends _$LikedByRepo {
  @override
  CollectionReference<LikedBy> build({required String postId}) {
    // return FirebaseFirestore.instance
    //firebaseFirestore.instanceがref.read(firestoreProvider)に変わった！firebase_provider.dartを書くと！
    return ref
        .read(firebaseFirestoreProvider)
        .collection(FirebasePostsKey.postsCollection)
        .doc(postId)
        .collection(FirebaseLikedByKey.likedByCollection)
        .withConverter<LikedBy>(
          fromFirestore: (snapshot, _) => LikedBy.fromJson(snapshot.data()!),
          toFirestore: (LikedBy value, _) => value.toJson(),
        );
  }

  //likeドキュメント追加
  Future<void> addLike(LikedBy addLikeData) async {
    //ドキュメント指定はlikeIdではなく、userIdを指定！

    await state.doc(addLikeData.likedById).set(addLikeData);
  }

  //likeドキュメント削除
  Future<void> deleteLike(String deleteLikeId) async {
    // state.doc(addLikeData.likeId).add(addLikeData);
    await state.doc(deleteLikeId).delete();
  }

  //likesコレクションのストリームを取得する
  Stream<List<LikedBy>> watchLikedBys() {
    // return db.orderBy('createdAt', descending: true).snapshots().map(
    return state.snapshots().map(
      //ここでmapとすることで、各要素として<QuerySnapshot<Task>>が入る
      //（Asyncじゃないから.dataを省略可能（.dataはviewの方で行う！））
      (QuerySnapshot<LikedBy> snapshot) {
        return snapshot.docs.map(
          //それぞれのドキュメントのどきゅめんとsnapshotのリストを返す。と思いきやリストの要素それぞれからTaskを取り出す処理を下で行う
          (QueryDocumentSnapshot<LikedBy> doc) {
            return doc.data();
          },
        ).toList();
      },
    );
  }
}

//watchLikesを切り出した
@riverpod
Stream<List<LikedBy>> likedBysStream(Ref ref, String postId) {
  return ref
      .watch(likedByRepoProvider(postId: postId).notifier)
      .watchLikedBys();
}

//今回自分がいいねしたものの一覧は取得しないのでコメントアウト！
//切り出しではなくcollectionグループ用のベーシックプロバイダは別に作ろう！なぜならtaskId渡さなくていいから
// @riverpod
// Stream<List<LikedBy>> watchMyLikedBys(Ref ref) {
//   //watchLikesのcollection,doc,collectionで指定してたとこが、まるまるcollectionGroupに
//   return ref
//       .read(firebaseFirestoreProvider)
//       .collectionGroup(FirebaseLikedByKey.likedByCollection)
//       .withConverter<LikedBy>(
//         fromFirestore: (snapshot, _) => LikedBy.fromJson(snapshot.data()!),
//         toFirestore: (LikedBy value, _) => value.toJson(),
//       )
//       //collectionの下はwatchLikeに自分のみを絞るwhere文のみ加えた
//       .where(FirebaseLikedByKey.userId,
//           isEqualTo: ref.watch(authRepoProvider)!.uid)
//       .snapshots()
//       .map(
//     //ここでmapとすることで、各要素として<QuerySnapshot<Task>>が入る
//     //（Asyncじゃないから.dataを省略可能（.dataはviewの方で行う！））
//     (QuerySnapshot<LikedBy> snapshot) {
//       return snapshot.docs.map(
//         //それぞれのドキュメントのどきゅめんとsnapshotのリストを返す。と思いきやリストの要素それぞれからTaskを取り出す処理を下で行う
//         (QueryDocumentSnapshot<LikedBy> doc) {
//           return doc.data();
//         },
//       ).toList();
//     },
//   );
// }
