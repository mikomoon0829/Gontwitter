//パスを指定するとこって二つあるよね。app_utils.dartでパスとページの対応を指定してるとこと、
//画面遷移のpush("/home")みたいなとこ。
//前者はぜひとも?絶対？略したパスを書くけど、後者はフルパスじゃないとダメ
//よってパスを取得する関数を二つ用意しないといけなくなる
//したがってenumだけ用意して！パスを取得する関数は書かない！
//enumの.nameをつかってnameで前者も後者もページを指定する！
enum APP_PAGE {
  auth,
  passReminder,
  allPost,
  mypage,
  addPost,
  editEmail,
  editProfile
}

extension AppPageExtention on APP_PAGE {
  String get toPath {
    switch (this) {
      case APP_PAGE.auth:
        return "/auth";

      case APP_PAGE.passReminder:
        return "passReminder";

      case APP_PAGE.allPost:
        return "/";

      case APP_PAGE.mypage:
        return "/mypage";

      case APP_PAGE.addPost:
        // return "edit/:userId";
        return "addPost";

      case APP_PAGE.editEmail:
        // return "edit/:userId";
        return "editEmail";

      case APP_PAGE.editProfile:
        // return "edit/:userId";
        return "editProfile";

      default:
        return "/";
    }
  }
}
