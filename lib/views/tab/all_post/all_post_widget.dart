import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:twitter/data_models/posts/posts.dart';
import 'package:twitter/functions/global_functions.dart';

import 'package:twitter/views/components/post_card.dart';

// class AllPostPage extends StatelessWidget {
//   const AllPostPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("みんなの投稿一覧"),
//         ),
//         floatingActionButton: FloatingActionButton(
//             child: const Icon(Icons.add),
//             onPressed: () {
//               // Navigator.of(context)
//               //     .push(MaterialPageRoute(builder: (context) => AddPostPage()));
//               context.pushNamed(APP_PAGE.addPost.name);
//             }),
//         body: AllPosts());
//   }
// }

class AllPosts extends StatelessWidget {
  const AllPosts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      //以下streamをコメントアウトのものでなくwithConverterのものを使うことで、
      //剥がす処理とかのMap型の部分が全てPost型に＆fromJsonでPost型に戻す一行がなくなった
      child: StreamBuilder<QuerySnapshot<Posts>>(
          // stream: FirebaseFirestore.instance
          //     .collection("posts")
          //     .orderBy("createdAt", descending: true)
          //     .snapshots(),
          stream:
              postsReference.orderBy("createdAt", descending: true).snapshots(),
          builder: (context, snapshot) {
            // print(snapshot);
            if (snapshot.hasData == false) {
              return const SizedBox.shrink();
            }
            // //目標は[{},{},{},{}]（Mapがリストの中にたくさんある状態）、これだとlistViewできる
            // final QuerySnapshot<Map<String, dynamic>> querySnapshot =
            //     snapshot.data!;
            final QuerySnapshot<Posts> querySnapshot = snapshot.data!;
            // //querySnapshot=⭐️{},{},{}⭐️
            // //⭐️をリストに変換してくれるメソッド：docs
            // //しかし、docsは配列にしてQueryDocumentSnapshot（あ）でかこってしまうので、外さなあかん
            // final List<QueryDocumentSnapshot<Map<String, dynamic>>> listData =
            //     querySnapshot.docs;
            final List<QueryDocumentSnapshot<Posts>> listData =
                querySnapshot.docs;
            // //あで囲われた状態で配列となっているので、配列一要素づつ外したらいい

            return ListView.builder(
              itemCount: listData.length,
              itemBuilder: (context, index) {
                // final QueryDocumentSnapshot<Map<String, dynamic>>
                //     queryDocumentSnapshot = listData[index];
                final QueryDocumentSnapshot<Posts> queryDocumentSnapshot =
                    listData[index];
                //あを外すのは.data()
                // Map<String, dynamic> mapData = queryDocumentSnapshot.data();
                Posts post = queryDocumentSnapshot.data();

                //Mapまで取り出せたところで、、インスタンス化することでclassで扱える
                // Posts post = Posts.fromJson(mapData);

                return PostCard(post: post);
              },
            );
          }),
    );
  }
}
