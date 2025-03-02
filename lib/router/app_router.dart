// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:twitter/router/router_utils.dart';
// import 'package:twitter/views/my_page/edit_profile/edit_profile_riverpod.dart';
// import 'package:twitter/views/post_list/add_post_page.dart';

// import 'package:twitter/views/post_list/tab_page.dart';
// import 'package:twitter/views/auth/auth_page.dart';
// import 'package:twitter/views/auth/password_reminder_page.dart';
// import 'package:twitter/views/navigation/bottom_navigation_page.dart';
// import 'package:twitter/views/my_page/edit_email/edit_email_page.dart';

// import 'package:twitter/views/my_page/my_page.dart';

// //プロフィール編集画面の親元が大元のGoRouter(ボトムナビゲーションがないGoRouter)と認識させ、
// //プロフィール編集画面にボトムナビゲーションを表示させない
// final _rootNavigationKey = GlobalKey<NavigatorState>();
// final _shellNavigationKey = GlobalKey<NavigatorState>();

// class AppRouter {
//   static final GoRouter appRouter = GoRouter(
//     navigatorKey: _rootNavigationKey,
//     initialLocation: AppRoute.tabPage.toPath,
//     // initialLocation: AppRoute.home.toPath,
//     redirect: (context, state) {
//       final user = FirebaseAuth.instance.currentUser;
//       // final bool isLogin = true;
//       if (user == null) {
//         //loginしていなかったら（isLoginがfalse）initialLocationはhomeやけどloginにする
//         return AppRoute.auth.toPath;
//         // return AppRoute.login.toPath;
//       } else {
//         //loginしていたら（isLoginがtrue）何もしない(homeのまま)
//         return null;
//       }
//     },
//     //自分が設定していないURLのページに行こうとしたとき、このウィジェットを出す
//     errorBuilder: (context, state) {
//       return Scaffold(body: Center(child: Text("存在しないページです")));
//     },
//     routes: <RouteBase>[
//       GoRoute(
//           path: AppRoute.auth.toPath,
//           // path: AppRoute.login.toPath,
//           name: AppRoute.auth.name,
//           // builder: (BuildContext context, GoRouterState state) {
//           //   return AuthPage();
//           // },
//           pageBuilder: (context, state) {
//             return NoTransitionPage(child: AuthPage());
//           },
//           routes: [
//             GoRoute(
//                 parentNavigatorKey: _rootNavigationKey,
//                 path: AppRoute.passReminder.toPath,
//                 name: AppRoute.passReminder.name,
//                 pageBuilder: (context, state) {
//                   //この画面に遷移する時渡された文字列をPageに代入する
//                   // final String userId = state.extra as String;

//                   return NoTransitionPage(
//                       // child: ProfileEditPage(userId: userId));
//                       child: PasswordReminderPage());
//                 }),
//           ]),
//       ShellRoute(
//           navigatorKey: _shellNavigationKey,
//           builder: (context, state, child) {
//             return BottomNavigationPage(
//               body: child,
//             );
//           },
//           routes: [
//             GoRoute(
//                 path: AppRoute.tabPage.toPath,
//                 // path: AppRoute.home.toPath,
//                 name: AppRoute.tabPage.name,
//                 // builder: (BuildContext context, GoRouterState state) {
//                 //   return const HomePage();
//                 // },
//                 pageBuilder: (context, state) {
//                   return NoTransitionPage(child: TabPage());
//                 },
//                 routes: [
//                   GoRoute(
//                       parentNavigatorKey: _rootNavigationKey,
//                       path: AppRoute.addPost.toPath,
//                       name: AppRoute.addPost.name,
//                       // path: AppRoute.mypageEdit.toPath,

//                       // builder: (BuildContext context, GoRouterState state) {
//                       //   return const HomePage();
//                       // },
//                       pageBuilder: (context, state) {
//                         //この画面に遷移する時渡された文字列をPageに代入する
//                         // final String userId = state.extra as String;

//                         return NoTransitionPage(
//                             // child: ProfileEditPage(userId: userId));
//                             child: AddPostPage());
//                       }),
//                 ]),
//             GoRoute(
//                 path: AppRoute.mypage.toPath,
//                 name: AppRoute.mypage.name,
//                 // path: AppRoute.mypage.toPath,
//                 // builder: (BuildContext context, GoRouterState state) {
//                 //   return const MyPage();
//                 // },
//                 pageBuilder: (context, state) {
//                   return const NoTransitionPage(child: MyPage());
//                 },
//                 routes: [
//                   GoRoute(
//                       parentNavigatorKey: _rootNavigationKey,
//                       path: AppRoute.editProfile.toPath,
//                       name: AppRoute.editProfile.name,
//                       // path: AppRoute.mypageEdit.toPath,

//                       // builder: (BuildContext context, GoRouterState state) {
//                       //   return const HomePage();
//                       // },
//                       pageBuilder: (context, state) {
//                         //この画面に遷移する時渡された文字列をPageに代入する
//                         // final String userId = state.extra as String;
//                         // final userName = state.uri.queryParameters["userName"]!;
//                         // final imageUrl = state.uri.queryParameters["imageUrl"]!;
//                         // final profile = state.uri.queryParameters["profile"]!;
//                         return NoTransitionPage(
//                             // child: ProfileEditPage(userId: userId));
//                             child: EditProfilePage());
//                       }),
//                   GoRoute(
//                       parentNavigatorKey: _rootNavigationKey,
//                       path: AppRoute.editEmail.toPath,
//                       name: AppRoute.editEmail.name,
//                       // path: AppRoute.mypageEdit.toPath,

//                       // builder: (BuildContext context, GoRouterState state) {
//                       //   return const HomePage();
//                       // },
//                       pageBuilder: (context, state) {
//                         //この画面に遷移する時渡された文字列をPageに代入する
//                         return NoTransitionPage(child: EditEmailPage());
//                       }),
//                 ]),
//           ]),
//     ],
//   );
// }

//TODO
//Auth実装終わったらこっちにすること
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twitter/repo/auth/auth_repo.dart';
import 'package:twitter/router/go_router_refresh_stream.dart';
import 'package:twitter/router/router_utils.dart';
import 'package:twitter/views/auth/auth_page.dart';
import 'package:twitter/views/auth/password_reminder_page.dart';
import 'package:twitter/views/my_page/edit_email/edit_email_page.dart';
import 'package:twitter/views/my_page/edit_profile/edit_profile_riverpod.dart';
import 'package:twitter/views/my_page/my_page.dart';
import 'package:twitter/views/navigation/bottom_navigation_page.dart';
import 'package:twitter/views/post_list/add_post_page.dart';
import 'package:twitter/views/post_list/tab_page.dart';
part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
      initialLocation: AppRoute.tabPage.toPath,
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      redirect: (context, state) {
        if (ref.read(authRepoProvider) == null) {
          return AppRoute.auth.toPath;
        }
        return null;
      },
      //redirectだけだと、ページが遷移した時にのみredirectが読み込まれる。。ページ遷移する前にcurrentUserが変わった時とかに即座にログイン画面にとかできない
      //右辺のデータが変更されたらredirect処理を走らせるのがrefreshListenable
      refreshListenable: GoRouterRefreshStream(
          ref.watch(authRepoProvider.notifier).authStateChange()),
      //上の一行について。とりあえずメソッドを呼び出すからnotifierをwatchする。
      //メソッドを呼び出した時ref.watch(authRepoProvider.notifier).authStateChange())全体で返ってくるものは
      //メソッドの返す値！今回はStream<User?>
      routes: [
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
                  parentNavigatorKey: _rootNavigatorKey,
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
            navigatorKey: _shellNavigatorKey,
            builder: (context, state, child) {
              return BottomNavigationPage(
                child: child,
              );
            },
            routes: [
              GoRoute(
                  path: AppRoute.tabPage.toPath,
                  // path: AppRoute.home.toPath,
                  name: AppRoute.tabPage.name,
                  // builder: (BuildContext context, GoRouterState state) {
                  //   return const HomePage();
                  // },
                  pageBuilder: (context, state) {
                    return NoTransitionPage(child: TabPage());
                  },
                  routes: [
                    GoRoute(
                        parentNavigatorKey: _rootNavigatorKey,
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
                        parentNavigatorKey: _rootNavigatorKey,
                        path: AppRoute.editProfile.toPath,
                        name: AppRoute.editProfile.name,
                        // path: AppRoute.mypageEdit.toPath,

                        // builder: (BuildContext context, GoRouterState state) {
                        //   return const HomePage();
                        // },
                        pageBuilder: (context, state) {
                          //この画面に遷移する時渡された文字列をPageに代入する
                          // final String userId = state.extra as String;
                          // final userName = state.uri.queryParameters["userName"]!;
                          // final imageUrl = state.uri.queryParameters["imageUrl"]!;
                          // final profile = state.uri.queryParameters["profile"]!;
                          return NoTransitionPage(
                              // child: ProfileEditPage(userId: userId));
                              child: EditProfilePage());
                        }),
                    GoRoute(
                        parentNavigatorKey: _rootNavigatorKey,
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
      ]);
}
