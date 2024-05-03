import 'package:hubia/screens/apoyanos.dart';
import 'package:hubia/screens/fav_screen.dart';
import 'package:hubia/screens/info_app.dart';
import 'package:hubia/screens/politica_privacidad.dart';
import 'package:hubia/screens/screens_barril.dart';
import 'package:hubia/screens/tutorial_screen.dart';
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
        path: '/apoyanos',
        builder: (context, state) => const ApoyanosScreen(),
      ),
      GoRoute(
        path: '/InfoAppScreen',
        builder: (context, state) => const InfoAppScreen(),
      ),
      GoRoute(
        path: '/politica',
        builder: (context, state) => const PoliticaScreen(),
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
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: '/favs',
        builder: (context, state) => const FavoriteScreen(),
      ),
      GoRoute(
        path: '/TutorialScreen',
        builder: (context, state) => TutorialScreen(),
      ),
    ],
  );
}
