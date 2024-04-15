import 'package:hubia/screens/fav_screen.dart';
import 'package:hubia/screens/info_app.dart';
import 'package:hubia/screens/politica_privacidad.dart';
import 'package:hubia/screens/screens_barril.dart';
import 'package:hubia/screens/tutorial_inside.dart';
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
        path: '/infoApp',
        builder: (context, state) => const infoApp(),
      ),
      GoRoute(
        path: '/politica',
        builder: (context, state) => const politicaPrivacidad(),
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
      GoRoute(
        path: '/search',
        builder: (context, state) => SearchIA(),
      ),
      GoRoute(
        path: '/favs',
        builder: (context, state) => const FavoriteScreen(),
      ),
      GoRoute(
        path: '/tutorialInside',
        builder: (context, state) => TutorialInside(),
      ),
    ],
  );
}
