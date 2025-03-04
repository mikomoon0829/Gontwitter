import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twitter/common_widget/close_only_dialog.dart';
import 'package:twitter/config/utils/margin/margin_box.dart';
import 'package:twitter/functions/global_functions.dart';
import 'package:twitter/repo/auth/auth_repo.dart';
import 'package:twitter/views/auth/components/auth_text_form_widget.dart';

class PasswordReminderPage extends HookConsumerWidget {
  PasswordReminderPage({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
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
                      await _sendPasswordResetEmail(ref, context);
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

  Future<void> _sendPasswordResetEmail(
      WidgetRef ref, BuildContext context) async {
    if (formKey.currentState!.validate() == false) {
      //失敗したときに処理をストップ
      return;
    }
    //パスワード再設定メール送信部分
    String sendEmailResult =
        await ref.read(authRepoProvider.notifier).sendPasswordResetEmail();
    if (sendEmailResult == "success") {
      showToast("メールボックスを確認してください");
    } else {
      if (context.mounted) {
        showCloseOnlyDialog(context, "失敗しました", sendEmailResult);
      }
    }
    return;
  }
}
