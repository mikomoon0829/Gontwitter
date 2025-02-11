// // import 'package:flutter/material.dart';

// // class EditEmailPage extends StatelessWidget {
// //   const EditEmailPage({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text("メールアドレス変更")),
// //     );
// //   }
// // }

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:twitter/common_widget/close_only_dialog.dart';
// import 'package:twitter/common_widget/confirm_dialog.dart';
// import 'package:twitter/common_widget/margin_box.dart';
// import 'package:twitter/functions/global_functions.dart';

// class EditEmailPage extends StatelessWidget {
//   EditEmailPage({super.key});

//   final formKey = GlobalKey<FormState>();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController newEmailController = TextEditingController();
//   final TextEditingController passController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     emailController.text = FirebaseAuth.instance.currentUser!.email!;
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("メールアドレス変更"),
//         ),
//         body: Form(
//           key: formKey,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             child:
//                 Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//               TextFormField(
//                 readOnly: true,
//                 decoration: InputDecoration(
//                   label: Text("現在のメールアドレス"),
//                 ),
//                 controller: emailController,
//               ),
//               MarginBox.smallHeightMargin,
//               TextFormField(
//                 // key: formKey,
//                 decoration: InputDecoration(label: Text("新しいメールアドレス")),
//                 controller: newEmailController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Please enter some text";
//                   }
//                   return null;
//                 },
//               ),
//               MarginBox.smallHeightMargin,
//               TextFormField(
//                 // key: formKey,
//                 decoration: InputDecoration(label: Text("パスワード")),
//                 controller: passController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Please enter some text";
//                   }
//                   return null;
//                 },
//               ),
//               MarginBox.bigHeightMargin,
//               ElevatedButton(
//                   onPressed: () async {
//                     if (formKey.currentState!.validate() == false) {
//                       //失敗したときに処理をストップ
//                       return;
//                     }
//                     //メールアドレスを変更する
//                     // await FirebaseAuth.instance.currentUser!.updateEmail(newEmailController.text);
//                     showConfirmDialog(
//                         context: context,
//                         text: "ログアウトしますがよろしいですか？",
//                         onConfirmPressed: () async {
//                           try {
//                             // final user = FirebaseAuth.instance.currentUser;
//                             // 1. ログアウト処理
//                             await FirebaseAuth.instance.signOut();

//                             // 2. 新しいメールアドレスに確認メールを送信
//                             await FirebaseAuth.instance.currentUser!
//                                 .verifyBeforeUpdateEmail(
//                                     newEmailController.text);
//                             showToast("新しいメールアドレスのメールボックスを確認してください");
//                           } on FirebaseAuthException catch (e) {
//                             if (e.code == "user-not-found") {
//                               // ignore: use_build_context_synchronously
//                               showCloseOnlyDialog(
//                                   context, "失敗", "ユーザーが見つかりません");
//                             } else if (e.code == "invalid-email") {
//                               showCloseOnlyDialog(
//                                   // ignore: use_build_context_synchronously
//                                   context,
//                                   "失敗",
//                                   "メールアドレスの形式ではありません");
//                             }
//                           } catch (e) {
//                             // ignore: use_build_context_synchronously
//                             showCloseOnlyDialog(
//                                 context, "失敗しました", e.toString());
//                           }
//                         });
//                   },
//                   child: Text("メールアドレス変更"))
//             ]),
//           ),
//         ));
//   }
// }

// import 'package:flutter/material.dart';

// class EditEmailPage extends StatelessWidget {
//   const EditEmailPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("メールアドレス変更")),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter/common_widget/close_only_dialog.dart';
import 'package:twitter/common_widget/confirm_dialog.dart';
import 'package:twitter/common_widget/margin_box.dart';
import 'package:twitter/functions/global_functions.dart';

class EditEmailPage extends StatelessWidget {
  EditEmailPage({super.key});

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    emailController.text = FirebaseAuth.instance.currentUser!.email!;
    newEmailController.text = "yamaguchi@gonmura.com";
    return Scaffold(
        appBar: AppBar(
          title: const Text("メールアドレス変更"),
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextFormField(
                readOnly: true,
                decoration: const InputDecoration(
                  label: Text("現在のメールアドレス"),
                ),
                controller: emailController,
              ),
              MarginBox.smallHeightMargin,
              TextFormField(
                // key: formKey,
                decoration: const InputDecoration(label: Text("新しいメールアドレス")),
                controller: newEmailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "テキストを入力してください";
                  }
                  return null;
                },
              ),
              MarginBox.smallHeightMargin,
              TextFormField(
                // key: formKey,
                decoration: const InputDecoration(label: Text("パスワード")),
                controller: passController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "テキストを入力してください";
                  }
                  return null;
                },
              ),
              MarginBox.bigHeightMargin,
              ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate() == false) {
                      //失敗したときに処理をストップ
                      return;
                    }
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passController.text);
                    } on FirebaseAuthException catch (e) {
                      print(e);
                      // if (e.code == "invalid-email") {
                      //           showCloseOnlyDialog(
                      //               // ignore: use_build_context_synchronously
                      //               context,
                      //               "失敗",
                      //               "メールアドレスの形式ではありません");
                      //         } else
                      if (e.code == "invalid-credential") {
                        showCloseOnlyDialog(
                            // ignore: use_build_context_synchronously
                            context,
                            "失敗",
                            "パスワードが違います");
                      }
                      return;
                    }

                    //メールアドレスを変更する
                    showConfirmDialog(
                        context: context,
                        text: "ログアウトしますがよろしいですか？",
                        onConfirmPressed: () async {
                          try {
                            try {
                              // await FirebaseAuth.instance
                              //     .signInWithEmailAndPassword(
                              //         email: emailController.text,
                              //         password: passController.text);
                              // 1. 新しいメールアドレスに確認メールを送信
                              await FirebaseAuth.instance.currentUser!
                                  .verifyBeforeUpdateEmail(
                                      newEmailController.text);
                              showToast("新しいメールアドレスのメールボックスを確認してください");
                            } on FirebaseAuthException catch (e) {
                              print(e);
                              if (e.code == "internal-error") {
                                showCloseOnlyDialog(
                                    // ignore: use_build_context_synchronously
                                    context,
                                    "失敗",
                                    "メールを送信することができませんでした\nメールアドレスの形式を確認してください");
                              }
                              // else if (e.code == "invalid-credential") {
                              //   showCloseOnlyDialog(
                              //       // ignore: use_build_context_synchronously
                              //       context,
                              //       "失敗",
                              //       "パスワードが違います");
                              // }
                              return;
                            }

                            // 2. ログアウト処理
                            await FirebaseAuth.instance.signOut();
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                          } on FirebaseAuthException catch (e) {
                            // print(e);
                            if (e.code == "invalid-email") {
                              showCloseOnlyDialog(
                                  // ignore: use_build_context_synchronously
                                  context,
                                  "失敗",
                                  "メールアドレスの形式ではありません");
                            } else if (e.code == 'invalid-credential') {
                              // ignore: use_build_context_synchronously
                              showCloseOnlyDialog(
                                  // ignore: use_build_context_synchronously
                                  context,
                                  "ログイン失敗",
                                  "パスワードが間違っています");
                            }
                          } catch (e) {
                            // ignore: use_build_context_synchronously
                            showCloseOnlyDialog(
                                // ignore: use_build_context_synchronously
                                context,
                                "失敗しました",
                                "予期せぬエラーです");
                            // print(e.toString());
                          }
                        });
                  },
                  child: const Text("メールアドレス変更"))
            ]),
          ),
        ));
  }
}
