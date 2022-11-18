import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppBarImpl extends StatelessWidget {
  const AppBarImpl({
    Key? key,
    required this.title,
    this.backgroundColor = const Color(0xFFF1654B),
    this.actions,
  }) : super(key: key);

  final String title;
  final Color backgroundColor;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 1,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(FontAwesomeIcons.arrowLeft),
      ),
      actions: actions ??
          <Widget>[
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.transparent,
              ),
              onPressed: () {},
            )
          ],
      title: Center(
        child: Text(title),
      ),
    );
  }
}
