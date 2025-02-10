import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter/common_widget/close_only_dialog.dart';
import 'package:twitter/common_widget/confirm_dialog.dart';
import 'package:twitter/functions/global_functions.dart';
import 'package:twitter/views/my_page/components/drawer_textbutton.dart';
import 'package:twitter/views/my_page/edit_email/edit_email.dart';
import 'package:twitter/views/my_page/edit_profile/edit_profile.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          ]
          // leading: IconButton(
          //   icon: Icon(Icons.menu), // ← 左上のアイコン（メニューアイコン）
          //   onPressed: () {
          //     // Scaffold.of(context).openDrawer(); // ← ドロワーを開く
          //   },
          // ),
          ),
      drawer: SizedBox(
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
                    // //パスワード再設定メール送信部分
                    //               showConfirmDialog(
                    //                 context: context,
                    //                 text: "パスワード再設定メールを送信しますか",
                    //                 onConfirmPressed: () async {
                    //                   try {
                    //                     await FirebaseAuth.instance
                    //                         .sendPasswordResetEmail(
                    //                             email: myUserEmail!);
                    //                     showToast("パスワード再設定メールを送信しました");
                    //                     Navigator.of(context).pop();

                    //                     print("再設定");
                    //                   } catch (e) {
                    //                     showCloseOnlyDialog(
                    //                         context, "メール送信失敗", e.toString());
                    //                   }
                    //                 },
                    //               );
                  },
                  text: "パスワード変更"),
              DrawerTextbutton(
                  onButtonPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditProfilePage(
                            // userName: userData.userName,
                            // imageUrl: userData.imageUrl,
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
      ),
    );
  }
}
