import 'package:go_router/go_router.dart';
import 'package:hubia/screens/screens_barril.dart';

GoRouter appRoutes() {
  return GoRouter(
    initialLocation: '/home',
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
        builder: (context, state) => const DetailScreen(),
      ),
    ],
  );
}
