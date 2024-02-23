import 'package:hubia/screens/screens_barril.dart';
import 'package:hubia/screens/webview.dart';

GoRouter appRoutes() {
  return GoRouter(
    initialLocation: '/loading',
    routes: [
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
        path: '/detailScreen',
        builder: (context, state) => DetailScreen(),
      ),
      GoRoute(
        path: '/webView',
        builder: (context, state) => const WebViewScreen(),
      ),
    ],
  );
}
