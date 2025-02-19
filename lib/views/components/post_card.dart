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
          final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
              userSnapshot.data!;
          final Map<String, dynamic> userMap = documentSnapshot.data()!;
          final UserData postUser = UserData.fromJson(userMap);
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
                title: Text(postUser.userName),
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
                          IconButton(
                              onPressed: () async {
                                //ここはsavePostのデータモデルのインスタンスをつくる
                                final SavePosts savedPost = SavePosts(
                                  userId:
                                      FirebaseAuth.instance.currentUser!.uid,
                                  postId: post.postId,
                                  savedAt: Timestamp.now(),
                                );
                                await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(savedPost.userId)
                                    .collection("savePosts")
                                    .doc(savedPost.postId)
                                    .set(savedPost.toJson());
                                showToast("保存しました！");
                              },
                              icon: Icon(Icons.bookmark)),
                          IconButton(
                              onPressed: () async {
                                final LikedBy likeUser = LikedBy(
                                  userId:
                                      FirebaseAuth.instance.currentUser!.uid,
                                  postId: post.postId,
                                  likedAt: Timestamp.now(),
                                );
                                await FirebaseFirestore.instance
                                    .collection("posts")
                                    .doc(likeUser.postId)
                                    .collection("likedBy")
                                    .doc(likeUser.userId)
                                    .set(likeUser.toJson());
                                showToast("いいねしました！");
                              },
                              icon: Icon(Icons.favorite)),
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
