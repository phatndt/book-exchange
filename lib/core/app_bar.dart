import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppBarImpl extends StatelessWidget {
  const AppBarImpl({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(FontAwesomeIcons.arrowLeft),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.settings,
            color: Colors.transparent,
          ),
          onPressed: () {},
        )
      ],
      title: Center(child: Text(title)),
    );
  }
}
