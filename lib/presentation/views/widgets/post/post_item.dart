import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../core/colors/colors.dart';
import '../../../../domain/entities/combination_post.dart';

class PostItemWidget extends StatelessWidget {
  const PostItemWidget({
    Key? key,
    required this.combinationPost,
  }) : super(key: key);

  final CombinationPost combinationPost;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(S.size.length_10),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: S.size.length_10Vertical,
          horizontal: S.size.length_10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PostTitleWidget(
              imagePath: combinationPost.user.imageUrl,
              username: combinationPost.user.username,
              createDate: DateFormat('dd/MM/yyyy, hh:mm').format(
                  DateTime.fromMillisecondsSinceEpoch(
                      int.parse(combinationPost.createDate))),
              onPressed: () {},
            ),
            SizedBox(
              height: S.size.length_20Vertical,
            ),
            Text(
              combinationPost.content,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: S.size.length_20Vertical,
            ),
            Container(
              height: 240,
              decoration: BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.all(
                  Radius.circular(S.size.length_10),
                ),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(combinationPost.imageUrl),
                ),
              ),
            ),
            const PostSpacing(),
          ],
        ),
      ),
    );
  }
}

class PostSpacing extends StatelessWidget {
  const PostSpacing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: S.size.length_4Vertical,
        ),
        const Divider(
          thickness: 1,
        ),
        SizedBox(
          height: S.size.length_4Vertical,
        ),
      ],
    );
  }
}

class PostTitleWidget extends StatelessWidget {
  const PostTitleWidget({
    Key? key,
    required this.imagePath,
    required this.username,
    required this.createDate,
    required this.onPressed,
  }) : super(key: key);
  final String imagePath;
  final VoidCallback onPressed;
  final String username;
  final String createDate;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 32.w,
            backgroundImage: NetworkImage(imagePath),
          ),
          SizedBox(
            width: S.size.length_10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: TextStyle(
                    fontFamily: 'Lato',
                    color: S.colors.orange,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: S.size.length_8,
                ),
                Text(
                  createDate,
                  style: TextStyle(
                    fontFamily: 'Lato',
                    color: S.colors.gray_3,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            child: const Icon(FontAwesomeIcons.ellipsisVertical),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
