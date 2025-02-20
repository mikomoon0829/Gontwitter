import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter/router/app_router.dart';
import 'package:twitter/router/router_utils.dart';
import 'package:twitter/views/all_post_page/all_post_widget.dart';
import 'package:twitter/views/my_page/my_page.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key, required this.body});
  final Widget body;

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      context.goNamed(APP_PAGE.allPost.name);
      // context.go("/");
      // context.go(APP_PAGE.home.toPath);
    }
    if (index == 1) {
      context.goNamed(APP_PAGE.mypage.name);
      // context.go("/mypage");
      // context.go(APP_PAGE.mypage.toPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    _selectedIndex = getSelectedIndex(context);
    return Scaffold(
      body: widget.body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:
            _selectedIndex, //このcurrentIndexによってボトムナビゲーションバーのどこのアイコンに焦点が当たるのかを決める
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'みんな'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'マイページ'),
        ],
      ),
    );
  }

  int getSelectedIndex(BuildContext context) {
    //このlocationにパスが入っている
    //現在地のパスを取る方法①　この数行を書く
    final router = AppRouter.appRouter;
    final RouteMatch lastMatch =
        router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : router.routerDelegate.currentConfiguration;
    final String location = matchList.uri.toString();

    //現在地のパスをとる方法②　fullPathメソッド
    final String? path = GoRouterState.of(context).fullPath;
    // print(location);
    // print(path);
    if (path == APP_PAGE.allPost.toPath) {
      // if (path == APP_PAGE.home.toPath) {
      return 0;
    } else {
      return 1;
    }
  }
}
