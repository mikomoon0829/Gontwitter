import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter/firebase_options.dart';
import 'package:twitter/router/app_router.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         // title: 'Flutter Demo',
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//           useMaterial3: true,
//         ),
//         debugShowCheckedModeBanner: false,
//         home: StreamBuilder(
//             stream: FirebaseAuth.instance.authStateChanges(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const SizedBox();
//               }
//               if (snapshot.hasData) {
//                 return const BottomNavigationPage(body: null,);
//               }
//               return AuthPage();
//             })

//         // AuthPage(),
//         );
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
  // runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       debugShowCheckedModeBanner: false,
//       routerConfig: AppRouter.appRouter,
//     );
//   }
// }

//TODO
//Auth実装終わったら、こっちにすること！（AppProviderに対応）
// //stlと打つと stlConsumerという候補が出てくるので、それを押すとConsumerWidgetの雛形ができる
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);
    return MaterialApp.router(
      // theme: ThemeData(appBarTheme: AppBarTheme(color: Colors.pink)),
      // routerConfig: AppRouter.goRouter,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
