import 'package:book_exchange/core/route_paths.dart';
import 'package:book_exchange/presentation/main_screen.dart';
import 'package:book_exchange/presentation/views/screens/home/library/add_book.dart';
import 'package:book_exchange/presentation/views/screens/pre_home/forgot_password.dart';
import 'package:book_exchange/presentation/views/screens/pre_home/login.dart';
import 'package:book_exchange/presentation/views/screens/pre_home/signup.dart';
import 'package:book_exchange/presentation/views/screens/pre_home/welcome.dart';
import 'package:book_exchange/presentation/views/screens/profile/change_password_screen.dart';
import 'package:book_exchange/presentation/views/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.welcome:
        return MaterialPageRoute(
          builder: (_) => const WelcomeScreen(),
          settings: settings,
        );
      case RoutePaths.logIn:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );
      case RoutePaths.signUp:
        return MaterialPageRoute(
          builder: (_) => const SignUpScreen(),
          settings: settings,
        );
      case RoutePaths.forgot:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordScreen(),
          settings: settings,
        );
      case RoutePaths.main:
        return MaterialPageRoute(
          builder: (_) => const MainScreen(),
          settings: settings,
        );
      case RoutePaths.profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
          settings: settings,
        );
      case RoutePaths.changePassword:
        return MaterialPageRoute(
          builder: (_) => const ChangePasswordScreen(),
          settings: settings,
        );
      case RoutePaths.addBook:
        return MaterialPageRoute(
          builder: (_) => const AddBookScreen(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const WelcomeScreen(),
          settings: settings,
        );
    }
  }
}
