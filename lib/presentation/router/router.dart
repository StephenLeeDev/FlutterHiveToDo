import 'package:go_router/go_router.dart';
import 'package:todo_hive/presentation/view/screen/main_navigation/main_navigation_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: "/home",
  routes: <RouteBase>[
    GoRoute(
      path: "/:tab(home|movie)",
      name: MainNavigationScreen.routeName,
      builder: (context, state) {
        final tab = state.params["tab"]!;
        return MainNavigationScreen(tab: tab);
      },
    ),
  ],
);