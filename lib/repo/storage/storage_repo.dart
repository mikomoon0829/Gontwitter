import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:twitter/config/firebase/firebase_provider.dart';
part 'storage_repo.g.dart';

@riverpod
class StorageRepo extends _$StorageRepo {
  @override
  Reference build() {
    return ref.read(firebaseStorageProvider).ref();
  }

//   Future<String> uploadImageAndGetUrl(String userId, File fileData) async {
//     //画像をアップロード
// //childでstateですでに指定しているrefの中身を設定できる
//     final uploadTask = await state.child("users/$userId").putFile(fileData);
//     //アップロードした画像のURLを取得
//     final downloadUrl = await uploadTask.ref.getDownloadURL();
//     return downloadUrl;
//   }

  //画像をアップロード
  Future<String> uploadImageAndGetUrl(
      // String userId, Uint8List uint8list) async {
      String userId,
      File image) async {
    // var metadata = SettableMetadata(
    //   contentType: "image/jpeg",
    // );
    //画像をアップロード
    // final uploadTask = await state.child('users/$userId').putData(image);
    final storageRef = FirebaseStorage.instance.ref("UsersIcon/$userId");
    //ここで失敗している
    //TODO
    await storageRef.putFile(image);

    //アップロードした画像のURLを取得

    final downloadUrl = await storageRef.getDownloadURL();
    // final downloadUrl = await uploadTask.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> deleteImage(String userId) async {
//childでstateですでに指定しているrefの中身を設定できる
    await state.child("users/$userId").delete();
  }
}
