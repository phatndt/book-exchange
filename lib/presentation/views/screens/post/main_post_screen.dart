import 'package:book_exchange/presentation/views/widgets/post/post_item.dart';
import 'package:flutter/material.dart';

class MainPostScreen extends StatelessWidget {
  const MainPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: const [PostItemWidget()],
        ),
      ),
    );
  }
}
