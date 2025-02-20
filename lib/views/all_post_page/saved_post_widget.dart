import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter/common_widget/confirm_dialog.dart';
import 'package:twitter/common_widget/margin_box.dart';
import 'package:twitter/data_models/posts/posts.dart';
import 'package:twitter/data_models/save_posts/saveposts.dart';
import 'package:twitter/data_models/user_data/userdata.dart';
import 'package:twitter/functions/global_functions.dart';
import 'package:twitter/router/router_utils.dart';
import 'package:twitter/views/all_post_page/add_post/add_post_page.dart';
import 'package:twitter/views/components/post_card.dart';

class SavedPost extends StatelessWidget {
  const SavedPost({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("posts")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("savePosts")
              .orderBy("savedAt", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            print(snapshot);
            if (snapshot.hasData == false) {
              return const SizedBox.shrink();
            }
            //目標は[{},{},{},{}]（Mapがリストの中にたくさんある状態）、これだとlistViewできる
            final QuerySnapshot<Map<String, dynamic>> querySnapshot =
                snapshot.data!;
            //querySnapshot=⭐️{},{},{}⭐️
            //⭐️をリストに変換してくれるメソッド：docs
            //しかし、docsは配列にしてQueryDocumentSnapshot（あ）でかこってしまうので、外さなあかん
            final List<QueryDocumentSnapshot<Map<String, dynamic>>> listData =
                querySnapshot.docs;
            //あで囲われた状態で配列となっているので、配列一要素づつ外したらいい

            return ListView.builder(
              itemCount: listData.length,
              itemBuilder: (context, index) {
                final QueryDocumentSnapshot<Map<String, dynamic>>
                    queryDocumentSnapshot = listData[index];
                //あを外すのは.data()
                Map<String, dynamic> mapData = queryDocumentSnapshot.data();
                //Mapまで取り出せたところで、、インスタンス化することでclassで扱える
                //mapDataはSavePosts
                Posts post = Posts.fromJson(mapData);
                // SavePosts savePost = SavePosts.fromJson(mapData);

                //postCardのドキュメントを指定してとるstれあmぶいlでr？

                // =Firebase

                //postは現在SavePosts型なので,Post型に変換する！

                return PostCard(post: post);
              },
            );
          }),
    );
  }
}
