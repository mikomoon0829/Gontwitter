import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter/common_widget/confirm_dialog.dart';
import 'package:twitter/config/utils/margin/margin_box.dart';
import 'package:twitter/data_models/liked_by/likedby.dart';
import 'package:twitter/data_models/posts/posts.dart';
import 'package:twitter/data_models/save_posts/saveposts.dart';
import 'package:twitter/data_models/user_data/userdata.dart';
import 'package:twitter/functions/global_functions.dart';
import 'package:twitter/repo/auth/auth_repo.dart';
import 'package:twitter/repo/like/liked_by_collection_repo.dart';
import 'package:twitter/repo/like/liked_by_repo.dart';
import 'package:twitter/repo/post/post_repo.dart';
import 'package:twitter/repo/save/save_collection_repo.dart';
import 'package:twitter/repo/save/save_repo.dart';
import 'package:twitter/repo/user/user_repo.dart';

class PostCard extends ConsumerWidget {
  const PostCard({
    super.key,
    required this.post,
  });

  final Posts post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 指定したuserId（postのuserId）のユーザ情報を監視する
    return ref.watch(userStreamProvider(post.userId)).when(
        data: (UserData postUser) {
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
                // StreamBuilder(
                //     stream: getLikedReference(post.postId).snapshots(),
                //     builder: (context, snapshot) {
                //       if (snapshot.hasData == false) {
                //         return const Text("♡0");
                //       }

                //       return Text("♡${snapshot.data!.size}");
                //     })
                ref.watch(likedBysStreamProvider(post.postId)).when(
                    data: (List<LikedBy> likedByList) {
                  return Text("♡${likedByList.length}");
                }, error: (error, stackTrace) {
                  return Text("エラーです");
                }, loading: () {
                  return Text("読み込み中");
                })
              ],
            ),
            subtitle: Text(post.createdAt.toDate().toString().substring(0, 16)),
            trailing: (post.userId == ref.watch(authRepoProvider)!.uid)
                // trailing: (post.userId == FirebaseAuth.instance.currentUser!.uid)
                ? IconButton(
                    onPressed: () {
                      showConfirmDialog(
                          context: context,
                          text: "本当に削除しますか",
                          onConfirmPressed: () async {
                            await ref
                                .read(postRepoProvider.notifier)
                                .deletePost(post.postId);
                            // await FirebaseFirestore.instance
                            //     .collection("posts")
                            //     .doc(post.postId)
                            //     .delete();

                            showToast("正常に削除されました");
                          });
                    },
                    icon: Icon((Icons.delete)))
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ref.watch(ifISavePostsStreamProvider(post.postId)).when(
                          data: (List<SavePosts> ifISaveThisPost) {
                        print(ifISaveThisPost.length);
                        //一件入っているかどうか
                        return IconButton(
                            onPressed: () {
                              if (ifISaveThisPost.isEmpty) {
                                print("${ifISaveThisPost.isEmpty}");
                                //入っていない時：保存してない！
                                //保存されていないので保存処理
                                SavePosts addPostData = SavePosts(
                                    userId: ref.watch(authRepoProvider)!.uid,
                                    postId: post.postId,
                                    savedAt: Timestamp.now());
                                ref
                                    .read(saveRepoProvider(
                                            ref.watch(authRepoProvider)!.uid)
                                        .notifier)
                                    .addSavePost(addPostData);
                              } else {
                                //保存されているので削除処理
                                ref
                                    .read(saveRepoProvider(
                                            ref.watch(authRepoProvider)!.uid)
                                        .notifier)
                                    .deletePost(post.postId);
                              }
                            },
                            icon: Icon((ifISaveThisPost.isEmpty)
                                ?
                                //保存してない時
                                Icons.bookmark_border
                                : Icons.bookmark));
                      }, error: (error, stackTrace) {
                        print(error);
                        return Text("エラーです");
                      }, loading: () {
                        return Text("読み込み中です");
                      }),
                      ref.watch(myLikedBysStreamProvider(post.postId)).when(
                          data: (List<LikedBy> ifILikeThisPost) {
                        return IconButton(
                            onPressed: () {
                              if (ifILikeThisPost.isEmpty) {
                                print("${ifILikeThisPost.isEmpty}");
                                //入っていない時：いいねしてない！
                                //いいねされていないのでいいね処理

                                LikedBy addLikeData = LikedBy(
                                    userId: ref.watch(authRepoProvider)!.uid,
                                    postId: post.postId,
                                    likedAt: Timestamp.now());

                                ref
                                    .read(likedByRepoProvider(post.postId)
                                        .notifier)
                                    .addLike(addLikeData);
                              } else {
                                //いいねされているので削除処理

                                ref
                                    .read(likedByRepoProvider(post.postId)
                                        .notifier)
                                    .deleteLike(
                                        ref.watch(authRepoProvider)!.uid);
                              }
                            },
                            icon: Icon((ifILikeThisPost.isEmpty)
                                ?
                                //いいねしてない時
                                Icons.favorite_border
                                : Icons.favorite));
                      }, error: (error, stackTrace) {
                        print(error);
                        return Text("エラーです");
                      }, loading: () {
                        return Text("読み込み中");
                      }),

                      // StreamBuilder(
                      //     stream: FirebaseFirestore.instance
                      //         .collection("posts")
                      //         .doc(post.postId)
                      //         .collection("likedBy")
                      //         .doc(FirebaseAuth.instance.currentUser!.uid)
                      //         .snapshots(),
                      //     builder: (context, likeSnapshot) {
                      //       if (likeSnapshot.hasData == false) {
                      //         return SizedBox.shrink();
                      //       }
                      //       if (likeSnapshot.data?.exists == false) {
                      //         return IconButton(
                      //             onPressed: () async {
                      //               //この一行追加　①ドキュメントリファレンス作る
                      //               final newDocumentReference =
                      //                   // savePostsReference.doc(post.postId);
                      //                   getLikedReference(post.postId).doc(
                      //                       FirebaseAuth
                      //                           .instance.currentUser!.uid);
                      //               //②likedByのデータモデルのインスタンスをつくる
                      //               final LikedBy likeUser = LikedBy(
                      //                 userId: FirebaseAuth
                      //                     .instance.currentUser!.uid,
                      //                 postId: post.postId,
                      //                 likedAt: Timestamp.now(),
                      //               );

                      //               //次の一行で追加できる！ ③LikedBy型でsetできる！
                      //               newDocumentReference.set(likeUser);
                      //               showToast("いいねしました！");
                      //             },
                      //             icon: Icon(Icons.favorite_border));
                      //       } else {
                      //         return IconButton(
                      //             onPressed: () async {
                      //               // ここはsavePostのデータモデルのインスタンスをつくる

                      //               await FirebaseFirestore.instance
                      //                   .collection("posts")
                      //                   .doc(post.postId)
                      //                   .collection("likedBy")
                      //                   .doc(FirebaseAuth
                      //                       .instance.currentUser!.uid)
                      //                   .delete();
                      //               // showToast("保存しました！");
                      //             },
                      //             icon: Icon(Icons.favorite));
                      //       }
                      //       //snapshotはAsyncSnapshot<QuerySnapshot>型
                      //       //.sizeプロパティはQuerySnapshot型のものなので、.dataしてから.sizeする
                      //     })
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
    }, error: (error, stackTrace) {
      //TODO
      return Text("エラーです");
    }, loading: () {
      return Text("読み込み中");
    });
  }
}






//streamBuilderをbuildの中で直接返して終わりだった。前は
    // return StreamBuilder(
    //     stream: userDataReference.doc(post.userId).snapshots(),
    //     builder: (context, userSnapshot) {
    //       if (userSnapshot.hasData == false) {
    //         return const SizedBox.shrink();
    //       }

    //       final DocumentSnapshot<UserData> documentSnapshot =
    //           userSnapshot.data!;

    //       final UserData postUser = documentSnapshot.data()!;

    //       return Column(
    //         children: [
    //           ListTile(
    //             leading: (postUser.imageUrl != "")
    //                 ? CircleAvatar(
    //                     backgroundImage: NetworkImage(postUser.imageUrl),
    //                     radius: 20,
    //                   )
    //                 : CircleAvatar(
    //                     backgroundImage: AssetImage("assets/images/image.png"),
    //                     radius: 20,
    //                   ),
    //             title: Row(
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 Text(postUser.userName),
    //                 MarginBox.mediumWidthMargin,
    //                 StreamBuilder(
    //                     stream: getLikedReference(post.postId).snapshots(),
    //                     builder: (context, snapshot) {
    //                       if (snapshot.hasData == false) {
    //                         return const Text("♡0");
    //                       }

    //                       return Text("♡${snapshot.data!.size}");
    //                     })
    //               ],
    //             ),
    //             subtitle:
    //                 Text(post.createdAt.toDate().toString().substring(0, 16)),
    //             trailing: (post.userId ==
    //                     FirebaseAuth.instance.currentUser!.uid)
    //                 ? IconButton(
    //                     onPressed: () {
    //                       showConfirmDialog(
    //                           context: context,
    //                           text: "本当に削除しますか",
    //                           onConfirmPressed: () async {
    //                             await FirebaseFirestore.instance
    //                                 .collection("posts")
    //                                 .doc(post.postId)
    //                                 .delete();

    //                             showToast("正常に削除されました");
    //                           });
    //                     },
    //                     icon: Icon((Icons.delete)))
    //                 : Row(
    //                     mainAxisSize: MainAxisSize.min,
    //                     children: [
    //                       //保存がnullなら枠のみのアイコン、ここから
    //                       StreamBuilder(
    //                           stream: FirebaseFirestore.instance
    //                               .collection("users")
    //                               .doc(FirebaseAuth.instance.currentUser!.uid)
    //                               .collection("savePosts")
    //                               .doc(post.postId)
    //                               .snapshots(),
    //                           builder: (context, saveSnapshot) {
    //                             if (saveSnapshot.hasData == false) {
    //                               return SizedBox.shrink();
    //                             }
    //                             if (saveSnapshot.data?.exists == false) {
    //                               return IconButton(
    //                                   onPressed: () async {
    //                                     //この一行追加　①ドキュメントリファレンス作る
    //                                     //このsavePostsReferenceはログイン中のユーザーのsavePostsコレクションのリファレンスに自動的になってる（定義上）
    //                                     final newDocumentReference =
    //                                         savePostsReference.doc(post.postId);
    //                                     //
    //                                     //②savePostのデータモデルのインスタンスをつくる
    //                                     final SavePosts savedPost = SavePosts(
    //                                       //userIdには保存した人のuserIdが入る
    //                                       userId: FirebaseAuth
    //                                           .instance.currentUser!.uid,
    //                                       // post.userId,

    //                                       postId: post.postId,
    //                                       savedAt: Timestamp.now(),
    //                                     );

    //                                     //次の一行で追加できる！ ③SavedPosts型でsetできる！
    //                                     newDocumentReference.set(savedPost);
    //                                     showToast("保存しました！");
    //                                   },
    //                                   icon: Icon(Icons.bookmark_border));
    //                             } else {
    //                               return IconButton(
    //                                   onPressed: () async {
    //                                     // ここはsavePostのデータモデルのインスタンスをつくる

    //                                     await FirebaseFirestore.instance
    //                                         .collection("users")
    //                                         .doc(FirebaseAuth
    //                                             .instance.currentUser!.uid)
    //                                         .collection("savePosts")
    //                                         .doc(post.postId)
    //                                         .delete();
    //                                     // showToast("保存しました！");
    //                                   },
    //                                   icon: Icon(Icons.bookmark));
    //                             }
    //                             //snapshotはAsyncSnapshot<QuerySnapshot>型
    //                             //.sizeプロパティはQuerySnapshot型のものなので、.dataしてから.sizeする
    //                           }),
    //                       StreamBuilder(
    //                           stream: FirebaseFirestore.instance
    //                               .collection("posts")
    //                               .doc(post.postId)
    //                               .collection("likedBy")
    //                               .doc(FirebaseAuth.instance.currentUser!.uid)
    //                               .snapshots(),
    //                           builder: (context, likeSnapshot) {
    //                             if (likeSnapshot.hasData == false) {
    //                               return SizedBox.shrink();
    //                             }
    //                             if (likeSnapshot.data?.exists == false) {
    //                               return IconButton(
    //                                   onPressed: () async {
    //                                     //この一行追加　①ドキュメントリファレンス作る
    //                                     final newDocumentReference =
    //                                         // savePostsReference.doc(post.postId);
    //                                         getLikedReference(post.postId).doc(
    //                                             FirebaseAuth
    //                                                 .instance.currentUser!.uid);
    //                                     //②likedByのデータモデルのインスタンスをつくる
    //                                     final LikedBy likeUser = LikedBy(
    //                                       userId: FirebaseAuth
    //                                           .instance.currentUser!.uid,
    //                                       postId: post.postId,
    //                                       likedAt: Timestamp.now(),
    //                                     );

    //                                     //次の一行で追加できる！ ③LikedBy型でsetできる！
    //                                     newDocumentReference.set(likeUser);
    //                                     showToast("いいねしました！");
    //                                   },
    //                                   icon: Icon(Icons.favorite_border));
    //                             } else {
    //                               return IconButton(
    //                                   onPressed: () async {
    //                                     // ここはsavePostのデータモデルのインスタンスをつくる

    //                                     await FirebaseFirestore.instance
    //                                         .collection("posts")
    //                                         .doc(post.postId)
    //                                         .collection("likedBy")
    //                                         .doc(FirebaseAuth
    //                                             .instance.currentUser!.uid)
    //                                         .delete();
    //                                     // showToast("保存しました！");
    //                                   },
    //                                   icon: Icon(Icons.favorite));
    //                             }
    //                             //snapshotはAsyncSnapshot<QuerySnapshot>型
    //                             //.sizeプロパティはQuerySnapshot型のものなので、.dataしてから.sizeする
    //                           })
    //                     ],
    //                   ),
    //           ),
    //           Card(
    //             child: Padding(
    //               padding: const EdgeInsets.all(15),
    //               child: SizedBox(
    //                 height: 80,
    //                 child: Row(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     (post.imageUrl != "")
    //                         ? Row(
    //                             children: [
    //                               Image.network(post.imageUrl,
    //                                   height: 75, width: 75, fit: BoxFit.cover),
    //                               MarginBox.smallWidthMargin,
    //                             ],
    //                           )
    //                         : SizedBox.shrink(),
    //                     Expanded(
    //                       child: Text(
    //                         post.postText,
    //                         softWrap: true,
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           )
    //         ],
    //       );
    //     });
