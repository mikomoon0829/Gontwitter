//パスを指定するとこって二つあるよね。app_utils.dartでパスとページの対応を指定してるとこと、
//画面遷移のpush("/home")みたいなとこ。
//前者はぜひとも?絶対？略したパスを書くけど、後者はフルパスじゃないとダメ
//よってパスを取得する関数を二つ用意しないといけなくなる
//したがってenumだけ用意して！パスを取得する関数は書かない！
//enumの.nameをつかってnameで前者も後者もページを指定する！

enum AppRoute {
  auth,
  passReminder,
  allPost,
  mypage,
  addPost,
  editEmail,
  editProfile
}

extension AppPageExtention on AppRoute {
  String get toPath {
    switch (this) {
      case AppRoute.auth:
        return "/auth";

      case AppRoute.passReminder:
        return "passReminder";

      case AppRoute.allPost:
        return "/";

      case AppRoute.mypage:
        return "/mypage";

      case AppRoute.addPost:
        // return "edit/:userId";
        return "addPost";

      case AppRoute.editEmail:
        // return "edit/:userId";
        return "editEmail";

      case AppRoute.editProfile:
        // return "edit/:userId";
        return "editProfile";

      // default:
      //   return "/";
    }
  }
}
