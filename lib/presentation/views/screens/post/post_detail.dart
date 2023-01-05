import 'package:flutter/material.dart';

import '../../../../domain/entities/combination_post.dart';

class PostDetail extends StatelessWidget {
  const PostDetail({
    Key? key,
    required this.combinationPost,
  }) : super(key: key);
  
  final CombinationPost combinationPost;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [],
        ),
      ),
    );
  }
}
