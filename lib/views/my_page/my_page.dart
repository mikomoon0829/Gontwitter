import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter/common_widget/close_only_dialog.dart';
import 'package:twitter/common_widget/confirm_dialog.dart';
import 'package:twitter/common_widget/custom_font_size.dart';
import 'package:twitter/common_widget/margin_box.dart';
import 'package:twitter/data_models/user_data/userdata.dart';
import 'package:twitter/functions/global_functions.dart';
import 'package:twitter/views/my_page/add_post/add_post_page.dart';
import 'package:twitter/views/my_page/components/drawer_textbutton.dart';
import 'package:twitter/views/my_page/edit_email/edit_email.dart';
import 'package:twitter/views/my_page/edit_profile/edit_profile2.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final String? myUserEmail = user?.email;
    final String? myUserId = user?.uid;

    return Scaffold(
        appBar: AppBar(
            title: Text("マイページ"),
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
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AddPostPage()));
            }),

        //ドロワーここから
        drawer: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(myUserId ?? " ")
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
                                  Navigator.of(context).pop();

                                  print("再設定");
                                } catch (e) {
                                  showCloseOnlyDialog(
                                      context, "メール送信失敗", e.toString());
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
                                    )));
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

        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SizedBox(
            width: double.infinity,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(myUserId ?? " ")
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
                                AssetImage("assets/images/image.png"),
                            radius: 50,
                          )
                        else
                          CircleAvatar(
                            backgroundImage: NetworkImage(userData.imageUrl),
                            radius: 50,
                          ),
                        MarginBox.mediumHeightMargin,
                        Text(userData.userName,
                            style: CustomFontSize.mediumFontSize),
                        MarginBox.smallHeightMargin,
                        Text(
                          // myUserEmail ?? ''
                          myUserEmail != null ? myUserEmail : '',
                        ),
                      ]);
                }),
          ),
        ));
  }
}



// class MyPage extends StatelessWidget {
//   const MyPage({super.key});

  


//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;
//     final String? myUserEmail = user?.email;
//     final String? myUserId = user?.uid;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("マイページ"),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 showConfirmDialog(
//                     context: context,
//                     text: "本当にログアウトしますか",
//                     onConfirmPressed: () async {
//                       await FirebaseAuth.instance.signOut();
//                     });
//               },
//               icon: const Icon(Icons.logout))
//         ],
//       ),

//       // StreamBuilder を親で使ってデータを取得
//       body: StreamBuilder<DocumentSnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection("users")
//             .doc(myUserId ?? " ")
//             .snapshots(),
//         builder: (context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
//           if (!snapshot.hasData) {
//             return const SizedBox.shrink(); // データがない場合は空
//           }

//           final DocumentSnapshot<Map<String, dynamic>> documentSnapshot = snapshot.data!;
//           final Map<String, dynamic> map = documentSnapshot.data()!;
//           final UserData userData = UserData.fromJson(map);

//           return Scaffold(
//             drawer: SizedBox(
//               width: 150,
//               child: Drawer(
//                 child: SafeArea(
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 10),
//                     child: Column(
//                       children: [
//                         DrawerTextbutton(
//                           onButtonPressed: () {
//                             Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (context) => EditEmailPage()));
//                           },
//                           text: "メールアドレス変更",
//                         ),
//                         DrawerTextbutton(
//                           onButtonPressed: () {
//                             // 他の操作
//                           },
//                           text: "パスワード変更",
//                         ),
//                         DrawerTextbutton(
//                           onButtonPressed: () {
//                             Navigator.of(context).push(MaterialPageRoute(
//                               builder: (context) => EditProfilePage(
//                                 // userData を渡す
//                               ),
//                             ));
//                           },
//                           text: "プロフィール変更",
//                         ),
//                         DrawerTextbutton(
//                           onButtonPressed: () {
//                             showConfirmDialog(
//                               context: context,
//                               text: "本当にログアウトしますか",
//                               onConfirmPressed: () async {
//                                 await FirebaseAuth.instance.signOut();
//                               },
//                             );
//                           },
//                           text: "ログアウト",
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//             body: Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   if (userData.imageUrl == " ")
//                     CircleAvatar(
//                       backgroundImage: AssetImage("assets/images/image.png"),
//                       radius: 50,
//                     )
//                   else
//                     CircleAvatar(
//                       backgroundImage: NetworkImage(userData.imageUrl),
//                       radius: 50,
//                     ),
//                   Text(userData.userName),
//                   Text(myUserEmail ?? ''),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
