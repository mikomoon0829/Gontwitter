//切り出しではなくcollectionグループ用のベーシックプロバイダは別に作ろう！なぜならtaskId渡さなくていいから
//postId,userId両方で絞らなあかんけど
//これだとpostIdのみしか絞れてない？？
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twitter/config/firebase/firebase_provider.dart';
import 'package:twitter/config/utils/keys/firebase_key.dart';
import 'package:twitter/data_models/save_posts/saveposts.dart';
import 'package:twitter/repo/auth/auth_repo.dart';

part 'save_collection_repo.g.dart';

@riverpod
class SaveCollectionGroupRepo extends _$SaveCollectionGroupRepo {
// Stream<List<SavePosts>> watchMyLikedBys(Ref ref,String postId) {
  //watchLikesのcollection,doc,collectionで指定してたとこが、まるまるcollectionGroupに
  @override
  Query<SavePosts> build() {
    return ref
        .read(firebaseFirestoreProvider)
        .collectionGroup(FirebaseSavePostsKey.savePostsCollection)
        .withConverter<SavePosts>(
          fromFirestore: (snapshot, _) => SavePosts.fromJson(snapshot.data()!),
          toFirestore: (SavePosts value, _) => value.toJson(),
        );
  }

//userIdがログイン中のユーザ、postIdが指定されたIDっていう二回検索かける！
//内容一件のみ入ったリストか、リストが空かどっちか
  Stream<List<SavePosts>> watchSavePosts(String postId) {
    // return db.orderBy('createdAt', descending: true).snapshots().map(
    return state
        .orderBy(FirebaseSavePostsKey.savedAt, descending: true)
        //コレクションまで（もしくはコレクショングループまで）指定したら、
        //そこからコレクションでのキーを使って条件を満たすドキュメントだけ返す検索ができる
        .where(FirebaseSavePostsKey.userId,
            isEqualTo: ref.watch(authRepoProvider)!.uid)
        .where(FirebaseSavePostsKey.postId, isEqualTo: postId)
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
Stream<List<SavePosts>> mySavePostsStream(Ref ref, String postId) {
  return ref
      .watch(saveCollectionGroupRepoProvider.notifier)
      .watchSavePosts(postId);

  //snapshotでコレクションを監視したものの一覧を降順にならべたものが状態であるbasicProvider
  //その状態を返すということはstream型を返すプロバイダだからwhen使える！
  //これ切り出してなかったら、TaskRepoプロバイダは単に固定値を返すものやからwhen使えないよね！
}
