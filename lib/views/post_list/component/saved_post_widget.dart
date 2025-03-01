import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:twitter/data_models/posts/posts.dart';
import 'package:twitter/data_models/save_posts/saveposts.dart';

import 'package:twitter/common_widget/post_card.dart';
import 'package:twitter/repo/auth/auth_repo.dart';
import 'package:twitter/repo/post/post_repo.dart';
import 'package:twitter/repo/save/save_repo.dart';

class SavedPost extends ConsumerWidget {
  const SavedPost({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //以下streamをコメントアウトのものでなくwithConverterのものを使うことで、
        //剥がす処理とかのMap型の部分が全てSavePost型に＆fromJsonでSavePost型に戻す一行がなくなった
        child: ref
            .watch(savePostsStreamProvider(ref.watch(authRepoProvider)!.uid))
            .when(data: (List<SavePosts> savePostsList) {
          return ListView.builder(
              itemCount: savePostsList.length,
              itemBuilder: (context, index) {
                //savePost一個一個を受け取って、そこからPosts型への型変換はitemBuilderの中で行う
                SavePosts savePost = savePostsList[index];
                String savePostId = savePost.postId;
                return ref.watch(postStreamProvider(savePostId)).when(
                    data: (Posts post) {
                  return PostCard(post: post);
                }, error: (error, stackTrace) {
                  return Text("エラーです");
                }, loading: () {
                  return Text("読み込み中");
                });
              });
        }, error: (error, stackTrace) {
          return Text("エラーです");
        }, loading: () {
          return Text("読み込み中");
        })
        // StreamBuilder(
        //     // stream: FirebaseFirestore.instance
        //     //     .collection("users")
        //     //     .doc(FirebaseAuth.instance.currentUser!.uid)
        //     //     .collection("savePosts")
        //     //     .orderBy("savedAt", descending: true)
        //     //     .snapshots(),
        //     stream: savePostsReference
        //         .orderBy("savedAt", descending: true)
        //         .snapshots(),
        //     builder: (context, snapshot) {
        //       if (snapshot.hasData == false) {
        //         return const SizedBox.shrink();
        //       }
        //       // print(snapshot.data!.size);
        //       //目標は[{},{},{},{}]（Mapがリストの中にたくさんある状態）、これだとlistViewできる
        //       // final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        //       //     snapshot.data!;
        //       final QuerySnapshot<SavePosts> querySnapshot = snapshot.data!;
        //       //querySnapshot=⭐️{},{},{}⭐️
        //       //⭐️をリストに変換してくれるメソッド：docs
        //       //しかし、docsは配列にしてQueryDocumentSnapshot（あ）でかこってしまうので、外さなあかん
        //       // final List<QueryDocumentSnapshot<Map<String, dynamic>>> listData =
        //       //     querySnapshot.docs;
        //       final List<QueryDocumentSnapshot<SavePosts>> listData =
        //           querySnapshot.docs;
        //       //あで囲われた状態で配列となっているので、配列一要素づつ外したらいい
        //       // print(listData);
        //       // print(listData.length);

        //       return ListView.builder(
        //         itemCount: listData.length,
        //         itemBuilder: (context, index) {
        //           // final QueryDocumentSnapshot<Map<String, dynamic>>
        //           //     queryDocumentSnapshot = listData[index];
        //           final QueryDocumentSnapshot<SavePosts> queryDocumentSnapshot =
        //               listData[index];

        //           //あを外すのは.data()
        //           // Map<String, dynamic> mapData = queryDocumentSnapshot.data();
        //           SavePosts savePost = queryDocumentSnapshot.data();
        //           //Mapまで取り出せたところで、、インスタンス化することでclassで扱える
        //           //mapDataはSavePosts

        //           // SavePosts savePost = SavePosts.fromJson(mapData);

        //           //savePostは現在SavePosts型なので,Post型に変換する！
        //           //postCardにあるように、ドキュメントを指定してとるstreamBuilder
        //           //以下streamをコメントアウトのものでなくwithConverterのものを使うことで、
        //           //剥がす処理とかのMap型の部分が全てPost型に＆fromJsonでPost型に戻す一行がなくなった
        //           return StreamBuilder(
        //               // stream: FirebaseFirestore.instance
        //               //     .collection("posts")
        //               //     .doc(savePost.postId)
        //               //     .snapshots(),
        //               stream: postsReference.doc(savePost.postId).snapshots(),
        //               builder: (context, postSnapshot) {
        //                 if (postSnapshot.hasData == false) {
        //                   return const SizedBox.shrink();
        //                 }
        //                 //snapshotしたら、mapに向かって剥がしていく処理必ずしないといけない
        //                 // final DocumentSnapshot<Map<String, dynamic>>
        //                 //     documentSnapshot = postSnapshot.data!;
        //                 final DocumentSnapshot<Posts> documentSnapshot =
        //                     postSnapshot.data!;
        //                 // final Map<String, dynamic> postMap =
        //                 //     documentSnapshot.data()!;
        //                 final Posts post = documentSnapshot.data()!;
        //                 // final Posts post = Posts.fromJson(postMap);

        //                 return PostCard(post: post);
        //               });

        //           // =Firebase
        //         },
        //       );
        //     }),
        );
  }
}
