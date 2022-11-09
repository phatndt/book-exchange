import 'package:book_exchange/core/app_route.dart';
import 'package:book_exchange/core/route_paths.dart';
import 'package:book_exchange/presentation/di/app_provider.dart';
import 'package:book_exchange/presentation/views/screens/home/club.dart';
import 'package:book_exchange/presentation/views/screens/home/home.dart';
import 'package:book_exchange/presentation/views/screens/post/main_post_screen.dart';
import 'package:book_exchange/presentation/views/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/colors/colors.dart';
import 'views/screens/home/library/collection.dart';
import 'views/screens/home/library/share.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({Key? key}) : super(key: key);

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int _currentIndex = 0;

//   final tabs = [
//     const CollectionScreen(),
//     const ShareScreen(),
//     const MainPostScreen(),
//     const ProfileScreen(),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       body: Navigator(
//         initialRoute: _currentIndex == 0 ? RoutePaths.home : RoutePaths.profile,
//         onGenerateRoute: AppRouter.generateRoute,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.shifting,
//         currentIndex: _currentIndex,
//         onTap: (index) => setState(() {
//           _currentIndex = index;
//         }),
//         selectedItemColor: S.colors.orange,
//         //backgroundColor: S.colors.white,
//         unselectedItemColor: S.colors.grey,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(FontAwesomeIcons.book),
//             label: 'Collection',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(FontAwesomeIcons.binoculars),
//             label: 'Share',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(FontAwesomeIcons.peopleGroup),
//             label: 'Clubs',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(FontAwesomeIcons.ellipsis),
//             label: 'More',
//           ),
//         ],
//       ),
//     ));
//   }
// }

class MainScreen extends ConsumerWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: ref.watch(mainAppNotifierProvider).navigation,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          currentIndex: ref.watch(mainAppNotifierProvider).currentIndex,
          onTap: (index) {
            ref.watch(mainAppNotifierProvider.notifier).setCurrentIndext(index);
          },
          selectedItemColor: S.colors.orange,
          //backgroundColor: S.colors.white,
          unselectedItemColor: S.colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.book),
              label: 'Collection',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.binoculars),
              label: 'Share',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.peopleGroup),
              label: 'Clubs',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.ellipsis),
              label: 'More',
            ),
          ],
        ),
      ),
    );
  }
}
