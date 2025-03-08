import 'dart:io';

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
      {required String folderName,
      required String photoId,
      required File image}) async {
    // var metadata = SettableMetadata(
    //   contentType: "image/jpeg",
    // );
    //画像をアップロード
    // final uploadTask = await state.child('users/$userId').putData(image);
    // final storageRef = FirebaseStorage.instance.ref("UsersIcon/$userId");
    // FirebaseStorage.instance.refがstate.childと同値らしい
    // final storageRef = state.child("UsersIcon/$userId");
    final Reference storageRef = state.child('$folderName/$photoId');

    await storageRef.putFile(image);

    //アップロードした画像のURLを取得

    final String downloadUrl = await storageRef.getDownloadURL();
    // final downloadUrl = await uploadTask.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> deleteImage(String folderName, String userId) async {
//childでstateですでに指定しているrefの中身を設定できる
    await state.child('$folderName/$userId').delete();
  }
}
