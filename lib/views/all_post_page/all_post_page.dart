import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:twitter/common_widget/confirm_dialog.dart';
import 'package:twitter/common_widget/margin_box.dart';
import 'package:twitter/data_models/posts/posts.dart';
import 'package:twitter/data_models/user_data/userdata.dart';
import 'package:twitter/functions/global_functions.dart';
import 'package:twitter/views/all_post_page/add_post/add_post_page.dart';

class AllPostPage extends StatelessWidget {
  const AllPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("みんなの投稿一覧"),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AddPostPage()));
            }),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("posts")
                .orderBy("createdAt", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              // print(snapshot);
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
                  Posts post = Posts.fromJson(mapData);

                  return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(post.userId)
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                              userSnapshot) {
                        if (userSnapshot.hasData == false) {
                          return const SizedBox.shrink();
                        }
                        //snapshotしたら、mapに向かって剥がしていく処理必ずしないといけない
                        final DocumentSnapshot<Map<String, dynamic>>
                            userDocumentSnapshot = userSnapshot.data!;
                        final Map<String, dynamic> userMap =
                            userDocumentSnapshot.data()!;
                        final UserData postUser = UserData.fromJson(userMap);
//Slidableで囲うとスライドして何かできるようになる！ここから
                        return Column(
                          children: [
                            ListTile(
                              leading: (postUser.imageUrl != "")
                                  ? CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(postUser.imageUrl),
                                      radius: 20,
                                    )
                                  : CircleAvatar(
                                      backgroundImage: const AssetImage(
                                          "assets/images/image.png"),
                                      radius: 20,
                                    ),
                              title: Text(postUser.userName),
                              subtitle: Text(post.createdAt
                                  .toDate()
                                  .toString()
                                  .substring(0, 16)),
                              trailing: (post.userId ==
                                      FirebaseAuth.instance.currentUser!.uid)
                                  ? IconButton(
                                      onPressed: () {
                                        showConfirmDialog(
                                            context: context,
                                            text: "本当に削除しますか",
                                            onConfirmPressed: () async {
                                              //削除処理が走る前にダイアログを閉じる
                                              // Navigator.pop(context);
                                              await FirebaseFirestore.instance
                                                  .collection("posts")
                                                  .doc(post.postId)
                                                  .delete();
//ここの下消す写真間違ってる！
                                              await FirebaseStorage.instance
                                                  .ref(
                                                      "PostsIcon/${post.postId}")
                                                  .delete();

                                              showToast("正常に削除されました");
                                            });
                                      },
                                      icon: const Icon((Icons.delete)))
                                  : const SizedBox.shrink(),
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: SizedBox(
                                  height: 80,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      (post.imageUrl != "")
                                          ? Row(
                                              children: [
                                                Image.network(post.imageUrl,
                                                    height: 75,
                                                    width: 75,
                                                    fit: BoxFit.cover),
                                                MarginBox.smallWidthMargin,
                                              ],
                                            )
                                          : const SizedBox.shrink(),
                                      Expanded(
                                        child: Text(
                                          post.postText,
                                          softWrap: true,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      });
                },
              );
            }));
  }
}
