import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../colors/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: S.colors.white,
        body: SingleChildScrollView(
            child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: AlignmentDirectional.topCenter,
              fit: StackFit.loose,
              children: [
                Container(
                  color: S.colors.white,
                  child: ClipPath(
                    clipper: CustomShape(),
                    child: Container(
                      height: 150,
                      color: S.colors.grey,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -S.size.length_20,
                  right: S.size.length_20,
                  left: S.size.length_20,
                  child: ProfileWidget(
                    imagePath:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTTePuOPXGxeejH4JuEO25wUWo-2jSefa3JUOCkwZKcfzi5rw7Z0XgR6-3OON8yrCOIlg&usqp=CAU',
                    onPressed: () {
                      log("1");
                    },
                    username: "thanhphat219",
                    email: "phatndt2109@gmail.com",
                  ),
                ),
              ],
            ),
            SizedBox(
              height: S.size.length_40,
            ),
            InkWell(
              onTap: () {},
              child: Text("Change information"),
            ),
            InkWell(
              child: Text("Change information"),
            )
          ],
        )),
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    Key? key,
    required this.imagePath,
    required this.onPressed,
    required this.username,
    required this.email,
  }) : super(key: key);
  final String imagePath;
  final VoidCallback onPressed;
  final String username;
  final String email;

  @override
  Widget build(BuildContext context) {
    final image = NetworkImage(imagePath);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(S.size.length_10),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(S.size.length_10),
        child: Row(
          children: [
            SizedBox(
              width: S.size.length_10,
            ),
            ClipOval(
              child: Material(
                color: Colors.transparent,
                child: Ink.image(
                  image: image,
                  width: S.size.length_64,
                  height: S.size.length_64,
                  child: GestureDetector(
                    onTap: onPressed,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: S.size.length_20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "thanhphat219",
                  style: TextStyle(
                    fontFamily: 'Lato',
                    color: S.colors.orange,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: S.size.length_10,
                ),
                Text(
                  "phatndt2109@gmail.com",
                  style: TextStyle(
                    fontFamily: 'Lato',
                    color: S.colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height + 50;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width / 2, height, width, height - 100);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
