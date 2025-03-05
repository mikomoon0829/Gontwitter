import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:twitter/data_models/post/post.dart';
import 'package:twitter/repo/post/post_repo.dart';

import 'package:twitter/common_widget/post_card.dart';

class AllPosts extends ConsumerWidget {
  const AllPosts({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //以下streamをコメントアウトのものでなくwithConverterのものを使うことで、
        //剥がす処理とかのMap型の部分が全てPost型に＆fromJsonでPost型に戻す一行がなくなった
        child:

            //サブコレクションに入れるのPostsがたやったら、
            //保存した投稿表示するとこでは、サブこれのstream<List<Task>>を取得することができるのに、、
            //今回SavePosts型やから、、
            ref.watch(postsStreamProvider).when(
          data: (List<Post> postsList) {
            return ListView.builder(
              itemCount: postsList.length,
              itemBuilder: (context, index) {
                Post post = postsList[index];
                return PostCard(post: post);
              },
            );
          },
          error: (error, stackTrace) {
            return Text('エラーです');
          },
          loading: () {
            return Center(child: const CircularProgressIndicator());
          },
        )
        // child: StreamBuilder<QuerySnapshot<Post>>(
        //     // stream: FirebaseFirestore.instance
        //     //     .collection("posts")
        //     //     .orderBy("createdAt", descending: true)
        //     //     .snapshots(),
        //     stream:
        //         postsReference.orderBy("createdAt", descending: true).snapshots(),
        //     builder: (context, snapshot) {
        //       // print(snapshot);
        //       if (snapshot.hasData == false) {
        //         return const SizedBox.shrink();
        //       }
        //       // //目標は[{},{},{},{}]（Mapがリストの中にたくさんある状態）、これだとlistViewできる
        //       // final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        //       //     snapshot.data!;
        //       final QuerySnapshot<Post> querySnapshot = snapshot.data!;
        //       // //querySnapshot=⭐️{},{},{}⭐️
        //       // //⭐️をリストに変換してくれるメソッド：docs
        //       // //しかし、docsは配列にしてQueryDocumentSnapshot（あ）でかこってしまうので、外さなあかん
        //       // final List<QueryDocumentSnapshot<Map<String, dynamic>>> listData =
        //       //     querySnapshot.docs;
        //       final List<QueryDocumentSnapshot<Post>> listData =
        //           querySnapshot.docs;
        //       // //あで囲われた状態で配列となっているので、配列一要素づつ外したらいい

        //       return ListView.builder(
        //         itemCount: listData.length,
        //         itemBuilder: (context, index) {
        //           // final QueryDocumentSnapshot<Map<String, dynamic>>
        //           //     queryDocumentSnapshot = listData[index];
        //           final QueryDocumentSnapshot<Post> queryDocumentSnapshot =
        //               listData[index];
        //           //あを外すのは.data()
        //           // Map<String, dynamic> mapData = queryDocumentSnapshot.data();
        //           Post post = queryDocumentSnapshot.data();

        //           //Mapまで取り出せたところで、、インスタンス化することでclassで扱える
        //           // Post post = Post.fromJson(mapData);

        //           return PostCard(post: post);
        //         },
        //       );
        //     }),
        );
  }
}
