import 'package:go_router/go_router.dart';
import 'package:todo_hive/presentation/view/screen/main_navigation/main_navigation_screen.dart';
import 'package:todo_hive/presentation/view/screen/sign_in/sign_in_screen.dart';

import '../view/screen/upload_image/upload_image_screen.dart';

final GoRouter router = GoRouter(
  // initialLocation: "/home",
  // initialLocation: "/signIn",
  initialLocation: "/upload",

  // redirect: (context, state) {
  //   final isLoggedIn = context.read(authRepo).isLoggedIn;
  //   if (!isLoggedIn) {
  //     if (state.subloc != SignUpScreen.routeURL &&
  //         state.subloc != LoginScreen.routeURL) {
  //       return SignUpScreen.routeURL;
  //     }
  //   }
  //   return null;
  // },
  routes: <RouteBase>[
    GoRoute(
      path: "/:tab(home|movie|chat)",
      name: MainNavigationScreen.routeName,
      builder: (context, state) {
        final tab = state.params["tab"] ?? "home";
        return MainNavigationScreen(tab: tab);
      },
    ),
    GoRoute(
      name: SignInScreen.routeName,
      path: SignInScreen.routeURL,
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      name: UploadImageScreen.routeName,
      path: UploadImageScreen.routeURL,
      builder: (context, state) => const UploadImageScreen(),
    ),
  ],
);
