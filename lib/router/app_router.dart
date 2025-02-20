import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter/router/router_utils.dart';
import 'package:twitter/views/tab/add_post/add_post_page.dart';

import 'package:twitter/views/tab/tab_page.dart';
import 'package:twitter/views/auth/auth_page.dart';
import 'package:twitter/views/auth/password_reminder_page.dart';
import 'package:twitter/views/bottom_navigation_page/bottom_navigation_page.dart';
import 'package:twitter/views/my_page/edit_email/edit_email_page.dart';
import 'package:twitter/views/my_page/edit_profile/edit_profile_page.dart';
import 'package:twitter/views/my_page/my_page.dart';

//プロフィール編集画面の親元が大元のGoRouter(ボトムナビゲーションがないGoRouter)と認識させ、
//プロフィール編集画面にボトムナビゲーションを表示させない
final _rootNavigationKey = GlobalKey<NavigatorState>();
final _shellNavigationKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter appRouter = GoRouter(
    navigatorKey: _rootNavigationKey,
    initialLocation: AppRoute.allPost.toPath,
    // initialLocation: AppRoute.home.toPath,
    redirect: (context, state) {
      final user = FirebaseAuth.instance.currentUser;
      // final bool isLogin = true;
      if (user == null) {
        //loginしていなかったら（isLoginがfalse）initialLocationはhomeやけどloginにする
        return AppRoute.auth.toPath;
        // return AppRoute.login.toPath;
      } else {
        //loginしていたら（isLoginがtrue）何もしない(homeのまま)
        return null;
      }
    },
    //自分が設定していないURLのページに行こうとしたとき、このウィジェットを出す
    errorBuilder: (context, state) {
      return Scaffold(body: Center(child: Text("存在しないページです")));
    },
    routes: <RouteBase>[
      GoRoute(
          path: AppRoute.auth.toPath,
          // path: AppRoute.login.toPath,
          name: AppRoute.auth.name,
          // builder: (BuildContext context, GoRouterState state) {
          //   return AuthPage();
          // },
          pageBuilder: (context, state) {
            return NoTransitionPage(child: AuthPage());
          },
          routes: [
            GoRoute(
                parentNavigatorKey: _rootNavigationKey,
                path: AppRoute.passReminder.toPath,
                name: AppRoute.passReminder.name,
                pageBuilder: (context, state) {
                  //この画面に遷移する時渡された文字列をPageに代入する
                  // final String userId = state.extra as String;

                  return NoTransitionPage(
                      // child: ProfileEditPage(userId: userId));
                      child: PasswordReminderPage());
                }),
          ]),
      ShellRoute(
          navigatorKey: _shellNavigationKey,
          builder: (context, state, child) {
            return BottomNavigationPage(
              body: child,
            );
          },
          routes: [
            GoRoute(
                path: AppRoute.allPost.toPath,
                // path: AppRoute.home.toPath,
                name: AppRoute.allPost.name,
                // builder: (BuildContext context, GoRouterState state) {
                //   return const HomePage();
                // },
                pageBuilder: (context, state) {
                  return NoTransitionPage(child: TabPage());
                },
                routes: [
                  GoRoute(
                      parentNavigatorKey: _rootNavigationKey,
                      path: AppRoute.addPost.toPath,
                      name: AppRoute.addPost.name,
                      // path: AppRoute.mypageEdit.toPath,

                      // builder: (BuildContext context, GoRouterState state) {
                      //   return const HomePage();
                      // },
                      pageBuilder: (context, state) {
                        //この画面に遷移する時渡された文字列をPageに代入する
                        // final String userId = state.extra as String;

                        return NoTransitionPage(
                            // child: ProfileEditPage(userId: userId));
                            child: AddPostPage());
                      }),
                ]),
            GoRoute(
                path: AppRoute.mypage.toPath,
                name: AppRoute.mypage.name,
                // path: AppRoute.mypage.toPath,
                // builder: (BuildContext context, GoRouterState state) {
                //   return const MyPage();
                // },
                pageBuilder: (context, state) {
                  return const NoTransitionPage(child: MyPage());
                },
                routes: [
                  GoRoute(
                      parentNavigatorKey: _rootNavigationKey,
                      path: AppRoute.editProfile.toPath,
                      name: AppRoute.editProfile.name,
                      // path: AppRoute.mypageEdit.toPath,

                      // builder: (BuildContext context, GoRouterState state) {
                      //   return const HomePage();
                      // },
                      pageBuilder: (context, state) {
                        //この画面に遷移する時渡された文字列をPageに代入する
                        // final String userId = state.extra as String;
                        final userName = state.uri.queryParameters["userName"]!;
                        final imageUrl = state.uri.queryParameters["imageUrl"]!;
                        final profile = state.uri.queryParameters["profile"]!;
                        return NoTransitionPage(
                            // child: ProfileEditPage(userId: userId));
                            child: EditProfilePage(
                                userName: userName,
                                imageUrl: imageUrl,
                                profile: profile));
                      }),
                  GoRoute(
                      parentNavigatorKey: _rootNavigationKey,
                      path: AppRoute.editEmail.toPath,
                      name: AppRoute.editEmail.name,
                      // path: AppRoute.mypageEdit.toPath,

                      // builder: (BuildContext context, GoRouterState state) {
                      //   return const HomePage();
                      // },
                      pageBuilder: (context, state) {
                        //この画面に遷移する時渡された文字列をPageに代入する
                        return NoTransitionPage(child: EditEmailPage());
                      }),
                ]),
          ]),
    ],
  );
}
