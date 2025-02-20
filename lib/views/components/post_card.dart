import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter/common_widget/confirm_dialog.dart';
import 'package:twitter/common_widget/margin_box.dart';
import 'package:twitter/data_models/liked_by/likedby.dart';
import 'package:twitter/data_models/posts/posts.dart';
import 'package:twitter/data_models/save_posts/saveposts.dart';
import 'package:twitter/data_models/user_data/userdata.dart';
import 'package:twitter/functions/global_functions.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
  });

  final Posts post;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        // stream: FirebaseFirestore.instance
        //     .collection("users")
        //     .doc(post.userId)
        //     .snapshots(),
        stream: userDataReference.doc(post.userId).snapshots(),
        builder: (context, userSnapshot) {
          if (userSnapshot.hasData == false) {
            return const SizedBox.shrink();
          }
          //snapshotしたら、mapに向かって剥がしていく処理必ずしないといけない
          // final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          //     userSnapshot.data!;
          final DocumentSnapshot<UserData> documentSnapshot =
              userSnapshot.data!;
          // final Map<String, dynamic> userMap = documentSnapshot.data()!;
          final UserData postUser = documentSnapshot.data()!;
          // final UserData postUser = UserData.fromJson(userMap);
          //Slidableで囲うとスライドして何かできるようになる！ここから
          return Column(
            children: [
              ListTile(
                leading: (postUser.imageUrl != "")
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(postUser.imageUrl),
                        radius: 20,
                      )
                    : CircleAvatar(
                        backgroundImage: AssetImage("assets/images/image.png"),
                        radius: 20,
                      ),
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(postUser.userName),
                    MarginBox.mediumWidthMargin,
                    //postはすでにstreamBuilderで見てるけど、サブコレであるlikedByの数をstreamで取得したものを表示したいねんな、、
                    //→新たにstreamBuilderいる！その数を表示させたい部分のみをstreamBuilderで囲う！
                    StreamBuilder(
                        // stream: FirebaseFirestore.instance
                        //     .collection("posts")
                        //     .doc(post.postId)
                        //     .collection("likedBy")
                        //     .snapshots(),
                        //postIdによってとってくるlikedReferenceが異なるので関数でとってくる
                        stream: getLikedReference(post.postId).snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData == false) {
                            return const Text("♡0");
                            // return const SizedBox.shrink();
                          }
                          //snapshotはAsyncSnapshot<QuerySnapshot>型
                          //.sizeプロパティはQuerySnapshot型のものなので、.dataしてから.sizeする
                          return Text("♡${snapshot.data!.size}");
                        })
                  ],
                ),
                subtitle:
                    Text(post.createdAt.toDate().toString().substring(0, 16)),
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

                                showToast("正常に削除されました");
                              });
                        },
                        icon: Icon((Icons.delete)))
                    // : SizedBox.shrink()
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //保存がnullなら枠のみのアイコン、ここから
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .collection("savePosts")
                                  .doc(post.postId)
                                  .snapshots(),
                              builder: (context, saveSnapshot) {
                                // print(saveSnapshot);
                                // print(saveSnapshot.data);
                                if (saveSnapshot.hasData == false) {
                                  return SizedBox.shrink();
                                }
                                if (saveSnapshot.data?.exists == false) {
                                  return IconButton(
                                      onPressed: () async {
                                        //この一行追加　①ドキュメントリファレンス作る
                                        //このsavePostsReferenceはログイン中のユーザーのsavePostsコレクションのリファレンスに自動的になってる（定義上）
                                        final newDocumentReference =
                                            savePostsReference.doc(post.postId);
                                        //
                                        //②savePostのデータモデルのインスタンスをつくる
                                        final SavePosts savedPost = SavePosts(
                                          //userIdには保存した人のuserIdが入る
                                          userId: FirebaseAuth
                                              .instance.currentUser!.uid,
                                          // post.userId,

                                          postId: post.postId,
                                          savedAt: Timestamp.now(),
                                        );
                                        // await FirebaseFirestore.instance
                                        //     .collection("users")
                                        //     .doc(FirebaseAuth
                                        //         .instance.currentUser!.uid)
                                        //     .collection("savePosts")
                                        //     .doc(post.postId)
                                        //     .set(savedPost.toJson());

                                        //次の一行で追加できる！ ③SavedPosts型でsetできる！
                                        newDocumentReference.set(savedPost);
                                        showToast("保存しました！");
                                      },
                                      icon: Icon(Icons.bookmark_border));
                                } else {
                                  return IconButton(
                                      onPressed: () async {
                                        // ここはsavePostのデータモデルのインスタンスをつくる
                                        // final SavePosts savedPost = SavePosts(
                                        //   //userIdには保存した人のuserIdが入る
                                        //   userId: FirebaseAuth
                                        //       .instance.currentUser!.uid,
                                        //   // post.userId,

                                        //   postId: post.postId,
                                        //   savedAt: Timestamp.now(),
                                        // );
                                        await FirebaseFirestore.instance
                                            .collection("users")
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .collection("savePosts")
                                            .doc(post.postId)
                                            .delete();
                                        // showToast("保存しました！");
                                      },
                                      icon: Icon(Icons.bookmark));
                                }
                                //snapshotはAsyncSnapshot<QuerySnapshot>型
                                //.sizeプロパティはQuerySnapshot型のものなので、.dataしてから.sizeする
                              }),
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("posts")
                                  .doc(post.postId)
                                  .collection("likedBy")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .snapshots(),
                              builder: (context, likeSnapshot) {
                                // print(saveSnapshot);
                                // print(saveSnapshot.data);
                                if (likeSnapshot.hasData == false) {
                                  return SizedBox.shrink();
                                }
                                if (likeSnapshot.data?.exists == false) {
                                  return IconButton(
                                      onPressed: () async {
                                        //この一行追加　①ドキュメントリファレンス作る
                                        final newDocumentReference =
                                            // savePostsReference.doc(post.postId);
                                            getLikedReference(post.postId).doc(
                                                FirebaseAuth
                                                    .instance.currentUser!.uid);
                                        //②likedByのデータモデルのインスタンスをつくる
                                        final LikedBy likeUser = LikedBy(
                                          userId: FirebaseAuth
                                              .instance.currentUser!.uid,
                                          postId: post.postId,
                                          likedAt: Timestamp.now(),
                                        );
                                        // await FirebaseFirestore.instance
                                        //     .collection("posts")
                                        //     .doc(likeUser.postId)
                                        //     .collection("likedBy")
                                        //     .doc(likeUser.userId)
                                        //     .set(likeUser.toJson());
                                        //次の一行で追加できる！ ③LikedBy型でsetできる！
                                        newDocumentReference.set(likeUser);
                                        showToast("いいねしました！");
                                      },
                                      icon: Icon(Icons.favorite_border));
                                } else {
                                  return IconButton(
                                      onPressed: () async {
                                        // ここはsavePostのデータモデルのインスタンスをつくる
                                        // final SavePosts savedPost = SavePosts(
                                        //   //userIdには保存した人のuserIdが入る
                                        //   userId: FirebaseAuth
                                        //       .instance.currentUser!.uid,
                                        //   // post.userId,

                                        //   postId: post.postId,
                                        //   savedAt: Timestamp.now(),
                                        // );
                                        await FirebaseFirestore.instance
                                            .collection("posts")
                                            .doc(post.postId)
                                            .collection("likedBy")
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .delete();
                                        // showToast("保存しました！");
                                      },
                                      icon: Icon(Icons.favorite));
                                }
                                //snapshotはAsyncSnapshot<QuerySnapshot>型
                                //.sizeプロパティはQuerySnapshot型のものなので、.dataしてから.sizeする
                              })

                          // IconButton(
                          //     onPressed: () async {
                          //       final LikedBy likeUser = LikedBy(
                          //         userId:
                          //             FirebaseAuth.instance.currentUser!.uid,
                          //         postId: post.postId,
                          //         likedAt: Timestamp.now(),
                          //       );
                          //       await FirebaseFirestore.instance
                          //           .collection("posts")
                          //           .doc(likeUser.postId)
                          //           .collection("likedBy")
                          //           .doc(likeUser.userId)
                          //           .set(likeUser.toJson());
                          //       showToast("いいねしました！");
                          //     },
                          //     icon: Icon(Icons.favorite)),
                        ],
                      ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: SizedBox(
                    height: 80,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (post.imageUrl != "")
                            ? Row(
                                children: [
                                  Image.network(post.imageUrl,
                                      height: 75, width: 75, fit: BoxFit.cover),
                                  MarginBox.smallWidthMargin,
                                ],
                              )
                            : SizedBox.shrink(),
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
  }
}
