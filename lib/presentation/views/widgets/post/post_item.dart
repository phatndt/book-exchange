import 'package:book_exchange/presentation/views/widgets/post/post_comment.dart';
import 'package:book_exchange/presentation/views/widgets/post/post_reaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/colors/colors.dart';

class PostItemWidget extends StatelessWidget {
  const PostItemWidget({Key? key}) : super(key: key);

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
              imagePath:
                  "https://lumiere-a.akamaihd.net/v1/images/p_avatar_de27b20f.jpeg",
              username: "thanhphat219",
              createDate: "at 21/09/2001",
              onPressed: () {},
            ),
            SizedBox(
              height: S.size.length_20Vertical,
            ),
            Text(
              "Day la mot quyen sach rat la hay toi muon chia se voi moi nguoi",
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
                image: const DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      "https://www.cgv.vn/media/catalog/product/cache/1/image/1800x/71252117777b696995f01934522c402d/a/v/avatar-1615695904-2089-1615696022.jpg"),
                ),
              ),
            ),
            const PostSpacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PostReaction(
                  icon: FontAwesomeIcons.thumbsUp,
                  count: "10",
                  onPressed: () {},
                ),
                PostComment(
                  icon: FontAwesomeIcons.comment,
                  count: "10",
                  onPressed: () {},
                ),
              ],
            )
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
