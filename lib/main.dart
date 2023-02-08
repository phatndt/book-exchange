import 'dart:developer';

import 'package:book_exchange/core/app_route.dart';
import 'package:book_exchange/core/route_paths.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/colors/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log("message");
    return ScreenUtilInit(
        designSize: const Size(392.72727272727275, 781.0909090909091),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: S.colors.orange,
                secondary: S.colors.orange,
              ),
              scaffoldBackgroundColor: S.colors.background,
            ),
            onGenerateRoute: AppRouter.generateRoute,
            initialRoute: RoutePaths.splash,
          );
        }
        // child: MaterialApp(
        //   debugShowCheckedModeBanner: false,
        //   theme: ThemeData(
        //     colorScheme: ColorScheme.fromSwatch().copyWith(
        //       primary: S.colors.orange,
        //       secondary: S.colors.orange,
        //     ),
        //     scaffoldBackgroundColor: S.colors.background,
        //   ),
        //   onGenerateRoute: AppRouter.generateRoute,
        //   initialRoute: RoutePaths.main,
        // ),
        );
  }
}
