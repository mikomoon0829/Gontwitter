import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter/common_widget/margin_box.dart';
import 'package:twitter/functions/global_functions.dart';

// class PasswordReminderPage extends StatelessWidget {
//   const PasswordReminderPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

class PasswordReminderPage extends StatelessWidget {
  PasswordReminderPage({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("パスワード再設定")),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(children: [
            TextFormField(
              decoration: InputDecoration(label: Text("メールアドレス")),
              controller: emailController,
            ),
            MarginBox.bigHeightMargin,
            ElevatedButton(
                onPressed: () async {
                  //パスワード再設定メール送信部分
                  try {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: emailController.text);
                    showToast("メールボックスを確認してください");
                    // print("再設定");
                  } catch (e) {
                    // print(e);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text("パスワード再設定メールを送る"),
                ))
          ]),
        ));
  }
}
