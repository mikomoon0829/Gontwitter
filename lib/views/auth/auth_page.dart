import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter/common_widget/close_only_dialog.dart';
import 'package:twitter/common_widget/margin_box.dart';
import 'package:twitter/data_models/user_data/userdata.dart';
import 'package:twitter/functions/global_functions.dart';
import 'package:twitter/views/auth/components/auth_text_form_widget.dart';
import 'package:twitter/views/auth/password_reminder_page.dart';

// class AuthPage extends StatelessWidget {
//   const AuthPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const ;
//   }
// }

class AuthPage extends StatelessWidget {
  AuthPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          AuthTextFormWidget(
            controller: emailController,
            label: "メールアドレス",
            isMask: false,
          ),
          MarginBox.smallHeightMargin,
          AuthTextFormWidget(
            controller: passController,
            label: "パスワード",
            isMask: true,
          ),
          SizedBox(
            width: double.infinity,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PasswordReminderPage()));
              },
              child: const Text(
                "パスワードを忘れた方はこちら>",
                style: TextStyle(color: Colors.blue),
                textAlign: TextAlign.end,
              ),
            ),
          ),
          MarginBox.bigHeightMargin,
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate() == false) {
                //失敗したときに処理をストップ
                return;
              }
              try {
                final User? user = (await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passController.text))
                    .user;
                if (user != null) {
                  // print("ユーザ登録しました");
                  final UserData createUserData = UserData(
                      userName: "",
                      imageUrl: "",
                      userId: user.uid,
                      profile: "",
                      createdAt: Timestamp.now(),
                      updatedAt: Timestamp.now());
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(user.uid)
                      .set(createUserData.toJson());
                  showToast("ユーザー登録完了！");
                } else {
                  showCloseOnlyDialog(
                      // ignore: use_build_context_synchronously
                      context,
                      "ログイン失敗",
                      "予期せぬエラーです。登録はできましたがログインできません。");
                }
              } on FirebaseAuthException catch (e) {
                if (e.code == 'email-already-in-use') {
                  // ignore: use_build_context_synchronously
                  showCloseOnlyDialog(context, "会員登録失敗", "指定したメールアドレスは登録済みです");
                } else if (e.code == 'invalid-email') {
                  showCloseOnlyDialog(
                      // ignore: use_build_context_synchronously
                      context,
                      "会員登録失敗",
                      "メールアドレスのフォーマットが正しくありません");
                  // print("フォーマット");
                } else if (e.code == 'operation-not-allowed') {
                  showCloseOnlyDialog(
                      // ignore: use_build_context_synchronously
                      context,
                      "会員登録失敗",
                      "指定したメールアドレス・パスワードは現在使用できません");
                } else if (e.code == 'weak-password') {
                  // ignore: use_build_context_synchronously
                  showCloseOnlyDialog(context, "会員登録失敗", "パスワードが弱すぎます");
                }
              } catch (e) {
                print(e);
                // print("予期せぬエラー");
                // ignore: use_build_context_synchronously
                showCloseOnlyDialog(context, "会員登録失敗", "予期せぬエラーです");
              }
            },
            child: Text("会員登録"),
          ),
          MarginBox.smallHeightMargin,
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate() == false) {
                return;
              }
              try {
                // メール/パスワードでログイン
                final FirebaseAuth auth = FirebaseAuth.instance;
                final User? user = (await auth.signInWithEmailAndPassword(
                  email: emailController.text,
                  password: passController.text,
                ))
                    .user;
                if (user != null) {
                  // print("ログイン成功");
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(user.uid)
                      .update({
                    "updatedAt": Timestamp.now(),
                  });
                } else {
                  showCloseOnlyDialog(
                      // ignore: use_build_context_synchronously
                      context,
                      "ログイン失敗",
                      "予期せぬエラーです。ログインはできたけどユーザーがnullです");
                }
              } on FirebaseAuthException catch (e) {
                if (e.code == "user-not-found") {
                  // ignore: use_build_context_synchronously
                  showCloseOnlyDialog(context, "ログイン失敗", "ユーザーが見つかりません");
                } else if (e.code == "invalid-email") {
                  // ignore: use_build_context_synchronously
                  showCloseOnlyDialog(context, "ログイン失敗", "メールアドレスの形式ではありません");
                } else if (e.code == "wrong-password") {
                  showCloseOnlyDialog(context, "ログイン失敗", "パスワードが間違っています");
                }
              } catch (e) {
                // ログインに失敗した場合
                // ignore: use_build_context_synchronously
                showCloseOnlyDialog(context, "ログイン失敗", "予期せぬエラーです$e");
              }
            },
            child: Text("ログイン"),
          ),
        ]),
      ),
    ));
  }
}
