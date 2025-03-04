// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// import 'package:twitter/router/router_utils.dart';

// class BottomNavigationPage extends StatefulWidget {
//   const BottomNavigationPage({super.key, required this.body});
//   final Widget body;

//   @override
//   State<BottomNavigationPage> createState() => _BottomNavigationPageState();
// }

// class _BottomNavigationPageState extends State<BottomNavigationPage> {
//   int _selectedIndex = 0;
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     if (index == 0) {
//       context.goNamed(AppRoute.tabPage.name);
//       // context.go("/");
//       // context.go(AppRoute.home.toPath);
//     }
//     if (index == 1) {
//       context.goNamed(AppRoute.mypage.name);
//       // context.go("/mypage");
//       // context.go(AppRoute.mypage.toPath);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     _selectedIndex = getSelectedIndex(context);
//     return Scaffold(
//       body: widget.body,
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex:
//             _selectedIndex, //このcurrentIndexによってボトムナビゲーションバーのどこのアイコンに焦点が当たるのかを決める
//         onTap: _onItemTapped,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(icon: Icon(Icons.book), label: 'みんな'),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'マイページ'),
//         ],
//       ),
//     );
//   }

//   int getSelectedIndex(BuildContext context) {
//     //このlocationにパスが入っている
//     //現在地のパスを取る方法①　このコメントアウトした7行を書く
//     // final router = AppRouter.appRouter;
//     // final RouteMatch lastMatch =
//     //     router.routerDelegate.currentConfiguration.last;
//     // final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
//     //     ? lastMatch.matches
//     //     : router.routerDelegate.currentConfiguration;
//     // final String location = matchList.uri.toString();

//     //現在地のパスをとる方法②　fullPathメソッド
//     final String? path = GoRouterState.of(context).fullPath;
//     // print(location);
//     // print(path);
//     if (path == AppRoute.tabPage.toPath) {
//       // if (path == AppRoute.home.toPath) {
//       return 0;
//     } else {
//       return 1;
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twitter/router/app_router.dart';
import 'package:twitter/router/router_utils.dart';

class BottomNavigationPage extends HookConsumerWidget {
  const BottomNavigationPage({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState(0);
    useEffect(() {
      //現在のパス取得
      //pathを取得して、pathに応じてcurrentIndexの初期値を変える

      //Providerでパスを取りたいけど、location使えない。fullPathでいい?
      // final String currentPath = ref.read(appRouterProvider).location;
      // final String? currentPath = GoRouterState.of(context).fullPath;

      final String currentPath = ref
          .read(appRouterProvider)
          .routerDelegate
          .currentConfiguration
          .uri
          .toString();

      // print(currentPath);
      if (currentPath == AppRoute.tabPage.toPath) {
        selectedIndex.value = 0;
      } else if (currentPath == AppRoute.mypage.toPath) {
        selectedIndex.value = 1;
      } else {
        selectedIndex.value = 0;
      }
      return null;
    }, [
      //ここに監視したい変数を入れる（今回パス）
      // ref.watch(appRouterProvider).location
      // GoRouterState.of(context).fullPath
      ref.watch(appRouterProvider).routerDelegate.currentConfiguration.uri
    ]);
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        //②ここでwatchしているので、状態が変わるとcurrentIndexが変わる。つまり色ついてるアイコンが変わる
        // currentIndex: ref.watch(bottomNavigationSelectedIndexProvider),
        currentIndex: selectedIndex.value,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "ホーム"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "マイページ"),
        ],
        onTap: (int value) {
          selectedIndex.value = value;
          //アイコンを押すと、、、①状態を変えた後、ページ遷移を行う！！
          // ref.read(bottomNavigationSelectedIndexProvider.notifier).change(value);
          switch (value) {
            case 0:
              context.goNamed(AppRoute.tabPage.name);
              break;
            case 1:
              context.goNamed(AppRoute.mypage.name);
              break;
          }
        },
      ),
    );
  }
}
