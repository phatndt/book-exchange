import 'package:book_exchange/presentation/views/widgets/post/post_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/colors/colors.dart';

class MainPostScreen extends StatelessWidget {
  const MainPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: S.colors.white,
        body: Padding(
          padding: EdgeInsets.only(
            top: S.size.length_20Vertical,
            left: S.size.length_10,
            right: S.size.length_10,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/logo/logo.png',
                    scale: 2,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Icon(
                      FontAwesomeIcons.plus,
                      color: Colors.white,
                      size: S.size.length_20,
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      primary: S.colors.mainColor,
                      padding: EdgeInsets.all(S.size.length_8),
                    ),
                  ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       "Feeds",
                  //       style: TextStyle(
                  //         fontSize: 28.sp,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //     Text(
                  //       "Featured Post",
                  //       style: TextStyle(
                  //         fontSize: 20.sp,
                  //         fontWeight: FontWeight.w400,
                  //       ),
                  //     )
                  //   ],
                  // )
                ],
              ),
              SizedBox(
                height: S.size.length_10,
              ),
              const PostItemWidget()
            ],
          ),
        ),
      ),
    );
  }
}
