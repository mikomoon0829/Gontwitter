// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:twitter/router/router_utils.dart';
// import 'package:twitter/views/post_list/component/all_post_widget.dart';
// import 'package:twitter/views/post_list/component/saved_post_widget.dart';

// // ignore: use_key_in_widget_constructors
// class TabPage extends StatefulWidget {
//   @override
//   TabPageState createState() => TabPageState();
// }

// class TabPageState extends State<TabPage> with SingleTickerProviderStateMixin {
//   late TabController tabController = TabController(length: 2, vsync: this);

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   // TabControllerの初期化、タブの数を指定
//   //   _tabController = TabController(length: 3, vsync: this);
//   // }

//   // @override
//   // void dispose() {
//   //   _tabController.dispose();  // 使用後はTabControllerを解放
//   //   super.dispose();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('投稿一覧'),
//         bottom: TabBar(
//           controller: tabController, // TabControllerを設定
//           tabs: [
//             Tab(child: Text('みんなの投稿一覧')),
//             Tab(text: '保存した投稿一覧'),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//           child: const Icon(Icons.add),
//           onPressed: () {
//             // Navigator.of(context)
//             //     .push(MaterialPageRoute(builder: (context) => AddPostPage()));
//             context.pushNamed(AppRoute.addPost.name);
//           }),
//       body: TabBarView(
//         controller: tabController, // TabControllerを設定
//         children: [
//           AllPosts(),
//           SavedPost(),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twitter/router/router_utils.dart';
import 'package:twitter/views/post_list/component/all_post_widget.dart';
import 'package:twitter/views/post_list/component/saved_post_widget.dart';

class TabPage extends HookConsumerWidget {
  const TabPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TabController tabController =
        useTabController(initialLength: 2); //  Hook で TabController を管理

    return Scaffold(
      appBar: AppBar(
        title: Text('投稿一覧'),
        bottom: TabBar(
          controller: tabController, // TabControllerを設定
          tabs: [
            Tab(text: 'みんなの投稿一覧'),
            Tab(text: '保存した投稿一覧'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => AddPostPage()));
          context.pushNamed(AppRoute.addPost.name);
        },
      ),
      body: TabBarView(
        controller: tabController, // TabControllerを設定
        children: [
          AllPosts(),
          SavedPost(),
        ],
      ),
    );
  }
}
