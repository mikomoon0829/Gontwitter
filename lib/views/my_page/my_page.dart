import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter/common_widget/confirm_dialog.dart';
import 'package:twitter/config/utils/font_size/custom_font_size.dart';
import 'package:twitter/config/utils/margin/margin_box.dart';
import 'package:twitter/data_models/posts/posts.dart';
import 'package:twitter/data_models/user_data/userdata.dart';
import 'package:twitter/functions/global_functions.dart';
import 'package:twitter/repo/auth/auth_repo.dart';
import 'package:twitter/repo/post/post_repo.dart';
import 'package:twitter/repo/user/user_repo.dart';
import 'package:twitter/router/router_utils.dart';
import 'package:twitter/views/my_page/components/drawer_textbutton.dart';
import 'package:twitter/common_widget/post_card.dart';

class MyPage extends ConsumerWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;
    final String? myUserEmail = user?.email;

    return Scaffold(
        appBar: AppBar(
            title: const Text("マイページ"),
            automaticallyImplyLeading: true,
            actions: [
              IconButton(
                  onPressed: () {
                    _signOut(context, ref);
                  },
                  icon: const Icon(Icons.logout))
            ]),

        //ドロワーここから
        //以下streamをコメントアウトのものでなくwithConverterのものを使うことで、
        //剥がす処理とかのMap型の部分が全てUserData型に＆fromJsonでUserData型に戻す一行がなくなった
        drawer: ref.watch(myUserStreamProvider).when(data: (UserData userData) {
          return SizedBox(
            width: 150,
            child: Drawer(
                child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(children: [
                  DrawerTextbutton(
                      onButtonPressed: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => EditEmailPage()));
                        context.pushNamed(AppRoute.editEmail.name);
                      },
                      text: "メールアドレス変更"),
                  DrawerTextbutton(
                      onButtonPressed: () {
                        //パスワード再設定メール送信部分
                        _sendPasswordResetEmail(context, ref);
                      },
                      text: "パスワード変更"),
                  DrawerTextbutton(
                      onButtonPressed: () {
                        context.pushNamed(
                          AppRoute.editProfile.name,
                        );
                      },
                      text: "プロフィール変更"),
                  DrawerTextbutton(
                      onButtonPressed: () {
                        // showConfirmDialog(
                        //     context: context,
                        //     text: "本当にログアウトしますか",
                        //     onConfirmPressed: () async {
                        //       await ref
                        //           .read(authRepoProvider.notifier)
                        //           .signOut();
                        //       // await FirebaseAuth.instance.signOut();
                        //       // ignore: use_build_context_synchronously
                        //       context.goNamed(AppRoute.auth.name);
                        //     });
                        _signOut(context, ref);
                      },
                      text: "ログアウト")
                ]),
              ),
            )),
          );
        }, error: (error, stackTrace) {
          return Text("エラーです");
        }, loading: () {
          return Text("読み込み中");
        }),
        // StreamBuilder(
        //     // stream: FirebaseFirestore.instance
        //     //     .collection("users")
        //     //     .doc(myUserId ?? "")
        //     //     .snapshots(),
        //     stream: userDataReference.doc(myUserId!).snapshots(),
        //     builder: (context, snapshot) {
        //       if (snapshot.hasData == false) {
        //         return const SizedBox.shrink();
        //       }
        //       // final DocumentSnapshot<Map<String, dynamic>>? documentSnapshot =
        //       //     snapshot.data;
        //       final DocumentSnapshot<UserData> documentSnapshot =
        //           snapshot.data!;
        //       // final Map<String, dynamic> map = documentSnapshot.data()!;
        //       final UserData userData = documentSnapshot.data()!;

        //       // final UserData userData = UserData.fromJson(map);

        //     }),
        //ドロワーここまで

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
                width: double.infinity,
                //以下streamをコメントアウトのものでなくwithConverterのものを使うことで、
                //剥がす処理とかのMap型の部分が全てUserData型に＆fromJsonでUserData型に戻す一行がなくなった
                child: ref.watch(myUserStreamProvider).when(
                    data: (UserData userData) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // CircleAvatar(
                        //   backgroundImage: NetworkImage(
                        //       "https://user0514.cdnw.net/shared/img/thumb/nekocyanPAKE4524-437_TP_V4.jpg?w=500,h=auto"),
                        //   radius: 50,
                        // ),
                        if (userData.imageUrl == "")
                          CircleAvatar(
                            backgroundImage:
                                const AssetImage("assets/images/image.png"),
                            radius: 30,
                          )
                        else
                          CircleAvatar(
                            backgroundImage: NetworkImage(userData.imageUrl),
                            radius: 30,
                          ),
                        MarginBox.smallHeightMargin,
                        Text(
                          userData.userName,
                          style: CustomFontSize.mediumFontSize,
                          textAlign: TextAlign.center,
                        ),
                        MarginBox.smallHeightMargin,
                        Text(
                          myUserEmail ?? '',
                          // myUserEmail != null ? myUserEmail : '',
                          textAlign: TextAlign.center,
                        ),
                        MarginBox.smallHeightMargin,
                        Text(
                          userData.profile,
                          textAlign: TextAlign.center,
                        ),
                        MarginBox.smallHeightMargin,
                        Divider(),
                        //以下streamをコメントアウトのものでなくwithConverterのものを使うことで、
                        //剥がす処理とかのMap型の部分が全てPosts型に＆fromJsonでPosts型に戻す一行がなくなった
                        ref.watch(myPostsStreamProvider).when(
                            data: (List<Posts> postList) {
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: postList.length,
                              itemBuilder: (context, index) {
                                Posts post = postList[index];
                                return PostCard(post: post);
                              });
                        }, error: (error, stackTrace) {
                          return Text("エラーです");
                        }, loading: () {
                          return Text("読み込み中");
                        })
                      ]);
                }, error: (error, stackTrace) {
                  return Text("エラーです");
                }, loading: () {
                  return Text("読み込み中");
                })),
          ),
        ));
  }

  void _signOut(BuildContext context, WidgetRef ref) {
    showConfirmDialog(
        context: context,
        text: "本当にログアウトしますか",
        onConfirmPressed: () async {
          await ref.read(authRepoProvider.notifier).signOut();

          // await FirebaseAuth.instance.signOut();
          // ignore: use_build_context_synchronously
          // context.goNamed(AppRoute.auth.name);
        });
  }

  void _sendPasswordResetEmail(BuildContext context, WidgetRef ref) {
    //パスワード再設定メール送信部分
    showConfirmDialog(
      context: context,
      text: "パスワード再設定メールを送信しますか",
      onConfirmPressed: () async {
        String result =
            await ref.read(authRepoProvider.notifier).sendPasswordResetEmail();
        if (result == "success") {
          showToast("パスワード再設定メールを送信しました");
        } else {
          showToast(result);
        }
      },
    );
  }
}







// StreamBuilder(
//             stream: FirebaseFirestore.instance
//                 .collection("posts")
//                 .orderBy("createdAt", descending: true)
//                 .snapshots(),
//             builder: (context, snapshot) {
//               // print(snapshot);
//               if (snapshot.hasData == false) {
//                 return const SizedBox.shrink();
//               }
//               //目標は[{},{},{},{}]（Mapがリストの中にたくさんある状態）、これだとlistViewできる
//               final QuerySnapshot<Map<String, dynamic>> querySnapshot =
//                   snapshot.data!;
//               //querySnapshot=⭐️{},{},{}⭐️
//               //⭐️をリストに変換してくれるメソッド：docs
//               //しかし、docsは配列にしてQueryドキュメントショット（あ）でかこってしまうので、外さなあかん
//               final List<QueryDocumentSnapshot<Map<String, dynamic>>> listData =
//                   querySnapshot.docs;
//               //あで囲われた状態で配列となっているので、配列一要素づつ外したらいい

//               return ListView.builder(
//                 itemCount: listData.length,
//                 itemBuilder: (context, index) {
//                   final QueryDocumentSnapshot<Map<String, dynamic>>
//                       queryDocumentSnapshot = listData[index];
//                   //あを外すのは.data()
//                   Map<String, dynamic> mapData = queryDocumentSnapshot.data();
//                   //Mapまで取り出せたところで、、インスタンス化することでclassで扱える
//                   Posts post = Posts.fromJson(mapData);

//                   return StreamBuilder(
//                       stream: FirebaseFirestore.instance
//                           .collection("users")
//                           .doc(post.userId)
//                           .snapshots(),
//                       builder: (context,
//                           AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
//                               userSnapshot) {
//                         if (userSnapshot.hasData == false) {
//                           return const SizedBox.shrink();
//                         }
//                         //snapshotしたら、mapに向かって剥がしていく処理必ずしないといけない
//                         final DocumentSnapshot<Map<String, dynamic>>
//                             documentSnapshot = userSnapshot.data!;
//                         final Map<String, dynamic> userMap =
//                             documentSnapshot.data()!;
//                         final UserData postUser = UserData.fromJson(userMap);
// //Slidableで囲うとスライドして何かできるようになる！ここから
//                         return Column(
//                           children: [
//                             ListTile(
//                               leading: (postUser.imageUrl != "")
//                                   ? CircleAvatar(
//                                       backgroundImage:
//                                           NetworkImage(postUser.imageUrl),
//                                       radius: 20,
//                                     )
//                                   : CircleAvatar(
//                                       backgroundImage:
//                                           AssetImage("assets/images/image.png"),
//                                       radius: 20,
//                                     ),
//                               title: Text(postUser.userName),
//                               subtitle: Text(post.createdAt
//                                   .toDate()
//                                   .toString()
//                                   .substring(0, 16)),
//                               trailing: (post.userId ==
//                                       FirebaseAuth.instance.currentUser!.uid)
//                                   ? IconButton(
//                                       onPressed: () {
//                                         showConfirmDialog(
//                                             context: context,
//                                             text: "本当に削除しますか",
//                                             onConfirmPressed: () async {
//                                               //削除処理が走る前にダイアログを閉じる
//                                               // Navigator.pop(context);
//                                               await FirebaseFirestore.instance
//                                                   .collection("posts")
//                                                   .doc(post.postId)
//                                                   .delete();

//                                               showToast("正常に削除されました");
//                                             });
//                                       },
//                                       icon: Icon((Icons.delete)))
//                                   : const SizedBox.shrink(),
//                             ),
//                             Card(
//                               child: Padding(
//                                 padding: const EdgeInsets.all(15),
//                                 child: Container(
//                                   height: 80,
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       (post.imageUrl != "")
//                                           ? Image.network(post.imageUrl,
//                                               height: 50)
//                                           : SizedBox.shrink(),
//                                       Expanded(
//                                         child: Text(
//                                           post.postText,
//                                           softWrap: true,
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             )
//                           ],
//                         );
//                       });
//                 },
//               );
//             })


