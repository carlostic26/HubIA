import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hubia/screens/detail_screen.dart';
import 'package:hubia/screens/list_category_screen.dart';
import 'package:hubia/screens/screens_barril.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'HubIA',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),

        routerConfig: appRoutes(),
        //home: const LoadingScreen(),
      ),
    );
  }

  GoRouter appRoutes() {
    return GoRouter(routes: [
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/categoryList',
        builder: (context, state) => const ListCategoryScreen(),
      ),
      GoRoute(
        path: '/loading',
        builder: (context, state) => const LoadingScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const DetailScreen(),
      ),
    ]);
  }
}
