import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter/common_widget/close_only_dialog.dart';
import 'package:twitter/common_widget/confirm_dialog.dart';
import 'package:twitter/common_widget/custom_font_size.dart';
import 'package:twitter/common_widget/margin_box.dart';
import 'package:twitter/data_models/posts/posts.dart';
import 'package:twitter/data_models/user_data/userdata.dart';
import 'package:twitter/functions/global_functions.dart';
import 'package:twitter/views/my_page/components/drawer_textbutton.dart';
import 'package:twitter/views/my_page/components/post_card.dart';
import 'package:twitter/views/my_page/edit_email/edit_email_page.dart';
import 'package:twitter/views/my_page/edit_profile/edit_profile_page.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final String? myUserEmail = user?.email;
    final String? myUserId = user?.uid;

    return Scaffold(
        appBar: AppBar(
            title: const Text("マイページ"),
            automaticallyImplyLeading: true,
            actions: [
              IconButton(
                  onPressed: () {
                    showConfirmDialog(
                        context: context,
                        text: "本当にログアウトしますか",
                        onConfirmPressed: () async {
                          await FirebaseAuth.instance.signOut();
                        });
                  },
                  icon: const Icon(Icons.logout))
            ]),

        //ドロワーここから
        drawer: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(myUserId ?? "")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData == false) {
                return const SizedBox.shrink();
              }
              final DocumentSnapshot<Map<String, dynamic>>? documentSnapshot =
                  snapshot.data;
              final Map<String, dynamic> map = documentSnapshot!.data()!;
              final UserData userData = UserData.fromJson(map);
              return SizedBox(
                width: 150,
                child: Drawer(
                    child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(children: [
                      DrawerTextbutton(
                          onButtonPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditEmailPage()));
                          },
                          text: "メールアドレス変更"),
                      DrawerTextbutton(
                          onButtonPressed: () {
                            //パスワード再設定メール送信部分
                            showConfirmDialog(
                              context: context,
                              text: "パスワード再設定メールを送信しますか",
                              onConfirmPressed: () async {
                                try {
                                  await FirebaseAuth.instance
                                      .sendPasswordResetEmail(
                                          email: myUserEmail!);
                                  showToast("パスワード再設定メールを送信しました");
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pop();

                                  // print("再設定");
                                } catch (e) {
                                  showCloseOnlyDialog(
                                      // ignore: use_build_context_synchronously
                                      context,
                                      "メール送信失敗",
                                      "予期せぬエラーです");
                                  // print(e.toString());
                                }
                              },
                            );
                          },
                          text: "パスワード変更"),
                      DrawerTextbutton(
                          onButtonPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditProfilePage(
                                    userName: userData.userName,
                                    imageUrl: userData.imageUrl,
                                    profile: userData.profile)));
                          },
                          text: "プロフィール変更"),
                      DrawerTextbutton(
                          onButtonPressed: () {
                            showConfirmDialog(
                                context: context,
                                text: "本当にログアウトしますか",
                                onConfirmPressed: () async {
                                  await FirebaseAuth.instance.signOut();
                                });
                          },
                          text: "ログアウト")
                    ]),
                  ),
                )),
              );
            }),
        //ドロワーここまで

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(myUserId ?? "")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData == false) {
                      return const SizedBox.shrink();
                    }
                    final DocumentSnapshot<Map<String, dynamic>>?
                        documentSnapshot = snapshot.data;
                    final Map<String, dynamic> map = documentSnapshot!.data()!;
                    final UserData userData = UserData.fromJson(map);

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
                          Text(userData.userName,
                              style: CustomFontSize.mediumFontSize),
                          MarginBox.smallHeightMargin,
                          Text(myUserEmail ?? ''
                              // myUserEmail != null ? myUserEmail : '',
                              ),
                          MarginBox.smallHeightMargin,
                          Text(userData.profile),
                          MarginBox.smallHeightMargin,
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("posts")
                                  .orderBy("createdAt", descending: true)
                                  .where("userId",
                                      isEqualTo: FirebaseAuth
                                          .instance.currentUser!.uid)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                // print(snapshot);
                                if (snapshot.hasData == false) {
                                  return const SizedBox.shrink();
                                }
                                //目標は[{},{},{},{}]（Mapがリストの中にたくさんある状態）、これだとlistViewできる
                                final QuerySnapshot<Map<String, dynamic>>
                                    querySnapshot = snapshot.data!;
                                //querySnapshot=⭐️{},{},{}⭐️
                                //⭐️をリストに変換してくれるメソッド：docs
                                //しかし、docsは配列にしてQueryドキュメントショット（あ）でかこってしまうので、外さなあかん
                                final List<
                                        QueryDocumentSnapshot<
                                            Map<String, dynamic>>> listData =
                                    querySnapshot.docs;
                                //あで囲われた状態で配列となっているので、配列一要素づつ外したらいい

                                //Map型のデータのリストができた！
                                List<Map<String, dynamic>> mapList = listData
                                    .map((item) => item.data())
                                    .toList();

                                //Post型のリストができた！
                                List<Posts> postsList = mapList
                                    .map((item) => Posts.fromJson(item))
                                    .toList();
                                return Column(
                                  children: postsList
                                      .map((item) => PostCard(post: item))
                                      .toList(),
                                );
                              })
                        ]);
                  }),
            ),
          ),
        ));
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


