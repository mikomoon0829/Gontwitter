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
import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:twitter/common_widget/close_only_dialog.dart';
import 'package:twitter/common_widget/confirm_dialog.dart';
import 'package:twitter/config/utils/margin/margin_box.dart';
import 'package:twitter/functions/global_functions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twitter/repo/auth/auth_repo.dart';

class EditEmailPage extends HookConsumerWidget {
  EditEmailPage({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final newEmailController = useTextEditingController();
    final passController = useTextEditingController();
    emailController.text = FirebaseAuth.instance.currentUser!.email!;

    return GestureDetector(
      //他のとこタップでunfocusのためにすること二点！
      //①ScaffoldをGestureDetectorで囲む
      //②このふたつのプロパティ入れる
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("メールアドレス変更"),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                    decoration:
                        const InputDecoration(label: Text("新しいメールアドレス")),
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
                        await _editEmail(ref, context, emailController,
                            passController, newEmailController);
                      },
                      child: const Text("メールアドレス変更"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _editEmail(
    WidgetRef ref,
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passController,
    TextEditingController newEmailController,
  ) async {
    if (formKey.currentState!.validate() == false) {
      //失敗したときに処理をストップ
      return;
    }

    String signInResult = await ref
        //1.サインイン処理
        .read(authRepoProvider.notifier)
        .signIn(email: emailController.text, password: passController.text);
    if (signInResult == "success") {
      //2.メールアドレスを変更する
      showConfirmDialog(
        // ignore: use_build_context_synchronously
        context: context,
        text: "ログアウトしますがよろしいですか？",
        onConfirmPressed: () async {
          String verifyResult = await ref
              .read(authRepoProvider.notifier)
              .verifyBeforeUpdateEmail(newEmail: newEmailController.text);
          if (verifyResult == "success") {
            showToast("新しいメールアドレスのメールボックスを確認してください");
            //3.サインアウト処理
            ref.read(authRepoProvider.notifier).signOut();

            return;
          } else {
            if (context.mounted) {
              showCloseOnlyDialog(context, "失敗", verifyResult);
            }
          }
        },
      );
    } else {
      if (context.mounted) {
        showCloseOnlyDialog(context, "失敗", signInResult);
      }
    }
    return;
  }
}
