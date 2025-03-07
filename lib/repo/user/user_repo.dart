import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twitter/config/firebase/firebase_provider.dart';
import 'package:twitter/config/utils/keys/firebase_key.dart';
import 'package:twitter/data_models/user_data/user_data.dart';
import 'package:twitter/repo/auth/auth_repo.dart';

part 'user_repo.g.dart';

@riverpod
class UserRepo extends _$UserRepo {
  @override
  CollectionReference<UserData> build() {
    return ref
        .read(firebaseFirestoreProvider)
        .collection(FirebaseUsersKey.usersCollection)
        .withConverter<UserData>(
          fromFirestore: (snapshot, _) => UserData.fromJson(snapshot.data()!),
          toFirestore: (UserData value, _) => value.toJson(),
        );
  }

  //ドキュメント追加
  Future<void> createUser(UserData addAccount) async {
    await state.doc(addAccount.userId).set(addAccount);
  }

  //ドキュメント更新
  Future<void> updateUser(UserData updateAccount) async {
//update文のときはtoJsonしないとデータベースに反映できないらしい
    await state.doc(updateAccount.userId).update(updateAccount.toJson());
  }

  //ドキュメント削除
  //実際のアプリではユーザドキュメントを削除することはない
  Future<void> deleteUser(String deleteAccountUserId) async {
    await state.doc(deleteAccountUserId).delete();
  }

  //ドキュメント取得
  Future<UserData> getUser(String accountUserId) async {
    //ドキュメントを指定して！！取得する！！ってときはget()メソッド
    final DocumentSnapshot<UserData> snapshot =
        await state.doc(accountUserId).get();
    //docId指定でsnapshotを受け取るときはdata()のみでもうAccount型のデータが現れる
    return snapshot.data()!;
  }

  //コレクション取得
  Future<List<UserData>> getUsers() async {
    //コレクションを指定して！！Future型で取得する！！ってときはget()メソッド
    final QuerySnapshot<UserData> snapshot = await state.get();
    //collectionごと指定でsnapshotを受け取ったときgは、普通は.data,.doc,.data()
    //だが、mapを使うことで最初の.dataを省略できる。view側で書く！
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  //streamでuserドキュメント取得
  Stream<UserData> watchUser(String accountUserId) {
    //docId指定でsnapshotを受け取るときはdata()のみでもうAccount型のデータが現れる
    return state
        .doc(accountUserId)
        .snapshots()
        // .map((DocumentSnapshot<UserData> snapshot) => snapshot.data()!);
        .map(
      (DocumentSnapshot<UserData> snapshot) {
        return snapshot.data()!;
      },
    );
  }

  //streamでuserListを取得
  Stream<List<UserData>> watchUsers() {
    //コレクションを指定して！！取得する！！ってときはget()メソッド
    // final snapshot= state.get();
    //collectionごと指定でsnapshotを受け取ったときgは、普通は.data,.doc,.data()
    //だが、mapを使うことで最初の.dataを省略できる。view側で書く！
    return state
        .orderBy(FirebaseUsersKey.createdAt, descending: true)
        .snapshots()
        .map(
      (QuerySnapshot<UserData> snapshot) {
        return snapshot.docs.map(
          //それぞれのドキュメントのどきゅめんとsnapshotのリストを返す。と思いきやリストの要素それぞれからTaskを取り出す処理を下で行う
          (QueryDocumentSnapshot<UserData> doc) {
            return doc.data();
          },
        ).toList();
      },
    );
  }
}

//ログインしているユーザーの情報よくつかうから、自分おAccountを返すプロバイダも定義しとく！
@riverpod
Stream<UserData> myUserStream(Ref ref) {
  return ref
      .watch(userRepoProvider.notifier)
      .watchUser(ref.watch(authRepoProvider)!.uid);
  //snapshotでコレクションを監視したものの一覧を降順にならべたものが状態であるbasicProvider
  //その状態を返すということはstream型を返すプロバイダだからwhen使える！
  //これ切り出してなかったら、TaskRepoプロバイダは単に固定値を返すものやからwhen使えないよね！
}

//watchUserのみを切り出したプロバイダを作る
@riverpod
Stream<UserData> userStream(Ref ref, String userId) {
  return ref.watch(userRepoProvider.notifier).watchUser(userId);
  //snapshotでコレクションを監視したものの一覧を降順にならべたものが状態であるbasicProvider
  //その状態を返すということはstream型を返すプロバイダだからwhen使える！
  //これ切り出してなかったら、TaskRepoプロバイダは単に固定値を返すものやからwhen使えないよね！
}

//watchUsersのみを切り出したプロバイダを作る
@riverpod
Stream<List<UserData>> usersStream(Ref ref) {
  return ref.watch(userRepoProvider.notifier).watchUsers();
  //snapshotでコレクションを監視したものの一覧を降順にならべたものが状態であるbasicProvider
  //その状態を返すということはstream型を返すプロバイダだからwhen使える！
  //これ切り出してなかったら、TaskRepoプロバイダは単に固定値を返すものやからwhen使えないよね！
}
