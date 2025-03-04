import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twitter/common_widget/close_only_dialog.dart';
import 'package:twitter/config/utils/margin/margin_box.dart';
import 'package:twitter/data_models/user_data/userdata.dart';
import 'package:twitter/functions/global_functions.dart';
import 'package:twitter/repo/auth/auth_repo.dart';
import 'package:twitter/repo/user/user_repo.dart';
import 'package:twitter/router/router_utils.dart';
import 'package:twitter/views/auth/components/auth_text_form_widget.dart';

class AuthPage extends HookConsumerWidget {
  AuthPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passController = useTextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: const Text("GonTwitter"),
          toolbarHeight: 125,
          backgroundColor: Colors.purple,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                  // spacing: ,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AuthTextFormWidget(
                      controller: emailController,
                      label: "メールアドレス",
                      obscureText: false,
                    ),
                    MarginBox.smallHeightMargin,
                    AuthTextFormWidget(
                      controller: passController,
                      label: "パスワード",
                      obscureText: false,
                    ),
                    MarginBox.smallHeightMargin,
                    SizedBox(
                      width: double.infinity,
                      child: InkWell(
                        onTap: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => PasswordReminderPage()));
                          context.pushNamed(AppRoute.passReminder.name);
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
                        await _createUser(
                          ref,
                          context,
                          emailController,
                          passController,
                        );
                      },
                      child: Text("会員登録"),
                    ),
                    MarginBox.smallHeightMargin,
                    ElevatedButton(
                      onPressed: () async {
                        await _login(
                          ref,
                          context,
                          emailController,
                          passController,
                        );
                      },
                      child: Text("ログイン"),
                    ),
                  ]),
            ),
          ),
        ));
  }

  Future<void> _login(
    WidgetRef ref,
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passController,
  ) async {
    if (_formKey.currentState!.validate() == false) {
      return;
    }
    String signInResult = await ref
        .read(authRepoProvider.notifier)
        .signIn(email: emailController.text, password: passController.text);
    if (signInResult == "success") {
      UserData myUserData = await ref
          .read(userRepoProvider.notifier)
          .getUser(ref.read(authRepoProvider)!.uid);
      UserData updateAccount = myUserData.copyWith(updatedAt: Timestamp.now());
      ref.read(userRepoProvider.notifier).updateUser(updateAccount);
      //ログイン完了
      showToast("ログイン成功!");
      if (context.mounted) {
        context.goNamed(AppRoute.tabPage.name);
      }
    } else {
      if (context.mounted) {
        showCloseOnlyDialog(context, "ログイン失敗", signInResult);
      }
    }
    return;
  }

  Future<void> _createUser(
    WidgetRef ref,
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passController,
  ) async {
    if (_formKey.currentState!.validate() == false) {
      //失敗したときに処理をストップ
      return;
    }
    //以下によって、currentUserが今作ったUserになる
    String createUserResult = await ref
        .read(authRepoProvider.notifier)
        .createUser(email: emailController.text, password: passController.text);
    if (createUserResult == "success") {
      final UserData createUserData = UserData(
          userName: "",
          imageUrl: "",
          userId: ref.watch(authRepoProvider)!.uid,
          profile: "",
          createdAt: Timestamp.now(),
          updatedAt: Timestamp.now());
      ref.read(userRepoProvider.notifier).createUser(createUserData);

      //Userコレクションに登録完了
      showToast("ユーザー登録完了！");
      if (context.mounted) {
        context.goNamed(AppRoute.tabPage.name);
      }
    } else {
      if (context.mounted) {
        showCloseOnlyDialog(context, "会員登録失敗", createUserResult);
      }
    }
    return;
  }
}
