//切り出しではなくcollectionグループ用のベーシックプロバイダは別に作ろう！なぜならtaskId渡さなくていいから
//postId,userId両方で絞らなあかんけど
//これだとpostIdのみしか絞れてない？？
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twitter/config/firebase/firebase_provider.dart';
import 'package:twitter/config/utils/keys/firebase_key.dart';
import 'package:twitter/data_models/liked_by/likedby.dart';
import 'package:twitter/repo/auth/auth_repo.dart';

part 'liked_by_collection_repo.g.dart';

@riverpod
class LikedByCollectionGroupRepo extends _$LikedByCollectionGroupRepo {
// Stream<List<SavePosts>> watchMyLikedBys(Ref ref,String postId) {
  //watchLikesのcollection,doc,collectionで指定してたとこが、まるまるcollectionGroupに
  @override
  Query<LikedBy> build() {
    return ref
        .read(firebaseFirestoreProvider)
        .collectionGroup(FirebaseLikedByKey.likedByCollection)
        .withConverter<LikedBy>(
          fromFirestore: (snapshot, _) => LikedBy.fromJson(snapshot.data()!),
          toFirestore: (LikedBy value, _) => value.toJson(),
        );
  }

//userIdがログイン中のユーザ、postIdが指定されたIDっていう二回検索かける！
//内容一件のみ入ったリストか、リストが空かどっちか
  Stream<List<LikedBy>> watchMyLikedBys(String postId) {
    // return db.orderBy('createdAt', descending: true).snapshots().map(
    return state
        .orderBy(FirebaseLikedByKey.likedAt, descending: true)
        //コレクションまで（もしくはコレクショングループまで）指定したら、
        //そこからコレクションでのキーを使って条件を満たすドキュメントだけ返す検索ができる
        .where(FirebaseLikedByKey.userId,
            isEqualTo: ref.watch(authRepoProvider)!.uid)
        .where(FirebaseLikedByKey.postId, isEqualTo: postId)
        .snapshots()
        .map(
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
//     //collectionの下はwatchLikeに自分のみを絞るwhere文のみ加えた
//     .where(FirebaseSavePostsKey.postId,
//         isEqualTo: postId)
//     .snapshots()
//     .map(
//   //ここでmapとすることで、各要素として<QuerySnapshot<Task>>が入る
//   //（Asyncじゃないから.dataを省略可能（.dataはviewの方で行う！））
//   (QuerySnapshot<SavePosts> snapshot) {
//     return snapshot.docs.map(
//       //それぞれのドキュメントのどきゅめんとsnapshotのリストを返す。と思いきやリストの要素それぞれからTaskを取り出す処理を下で行う
//       (QueryDocumentSnapshot<SavePosts> doc) {
//         return doc.data();
//       },
//     ).toList();
//   },
// );

// //watchSavePostsのみを切り出したプロバイダを作る
@riverpod
Stream<List<LikedBy>> myLikedBysStream(Ref ref, String postId) {
  return ref
      .watch(likedByCollectionGroupRepoProvider.notifier)
      .watchMyLikedBys(postId);

  //snapshotでコレクションを監視したものの一覧を降順にならべたものが状態であるbasicProvider
  //その状態を返すということはstream型を返すプロバイダだからwhen使える！
  //これ切り出してなかったら、TaskRepoプロバイダは単に固定値を返すものやからwhen使えないよね！
}
