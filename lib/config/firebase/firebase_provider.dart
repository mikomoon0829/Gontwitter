import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_provider.g.dart';

@riverpod
FirebaseFirestore firebaseFirestore(Ref ref) {
  return FirebaseFirestore.instance;
}

@riverpod
FirebaseAuth firebaseAuth(Ref ref) {
  return FirebaseAuth
      .instance; //FirebaseAuthというクラスがすでにある。そのインスタンス化したものを返すメソッドの結果をreturnする
}

@riverpod
FirebaseStorage firebaseStorage(Ref ref) {
  return FirebaseStorage.instance;
}
