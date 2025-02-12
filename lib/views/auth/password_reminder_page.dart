import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter/common_widget/close_only_dialog.dart';
import 'package:twitter/common_widget/margin_box.dart';
import 'package:twitter/functions/global_functions.dart';
import 'package:twitter/views/auth/components/auth_text_form_widget.dart';

class PasswordReminderPage extends StatelessWidget {
  PasswordReminderPage({super.key});

  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("パスワード再設定")),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: formKey,
              child: Column(children: [
                AuthTextFormWidget(
                    controller: emailController,
                    label: "メールアドレス",
                    isMask: false),
                // TextFormField(
                //   decoration: InputDecoration(label: Text("メールアドレス")),
                //   controller: emailController,
                // ),
                MarginBox.bigHeightMargin,
                ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate() == false) {
                        //失敗したときに処理をストップ
                        return;
                      }
                      //パスワード再設定メール送信部分
                      try {
                        await FirebaseAuth.instance.sendPasswordResetEmail(
                            email: emailController.text);
                        showToast("メールボックスを確認してください");
                        // print("再設定");
                      } on FirebaseAuthException catch (e) {
                        // print(e.code);
                        if (e.code == 'invalid-email') {
                          // ignore: use_build_context_synchronously
                          showCloseOnlyDialog(
                              context, "失敗", "メールアドレスの形式ではありません");
                        }
                      } catch (e) {
                        showCloseOnlyDialog(
                            // ignore: use_build_context_synchronously
                            context,
                            "失敗しました",
                            "予期せぬエラーです");
                        // print(e);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text("パスワード再設定メールを送る"),
                    ))
              ]),
            ),
          ),
        ));
  }
}
