import 'package:ai_app/views/dir/profile_page.dart';
import 'package:ai_app/views/home_page.dart';
import 'package:ai_app/views/log_in.dart';
import 'package:ai_app/views/sign_up.dart';
import 'package:ai_app/views/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'app_router_constants.dart';

class Router {
  GoRouter router = GoRouter(
    initialLocation: AppRouteConstants.splashScreen,
    routes: [
      GoRoute(
        name: AppRouteConstants.splashScreen,
        path: '/',
        pageBuilder: (context, state) {
          return MaterialPage(child: SplashScreen());
        },
      ),
      GoRoute(
        name: AppRouteConstants.homePage,
        path: '/home',
        pageBuilder: (context, state) {
          return MaterialPage(child: HomePage());
        },
      ),
      GoRoute(
        name: AppRouteConstants.profile,
        path: '/profile',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: ProfilePage(),
          );
        },
      ),
      GoRoute(
        name: AppRouteConstants.login,
        path: '/login',
        pageBuilder: (context, state) {
          return MaterialPage(child: LogInPage());
        },
      ),
      GoRoute(
        name: AppRouteConstants.signUp,
        path: '/signup',
        pageBuilder: (context, state) {
          return MaterialPage(child: SignUpPage());
        },
      )
    ],
  );
}
