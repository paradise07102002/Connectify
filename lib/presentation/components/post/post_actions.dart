import 'package:connectify/data/models/post/comment_model.dart';
import 'package:connectify/presentation/components/comment/comment_list.dart';
import 'package:flutter/material.dart';

class PostActions extends StatelessWidget {
  final List<CommentModel> comments;
  const PostActions({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {},
          child: Row(
            children: [
              Image.asset('assets/icons/heart.png', width: 32, height: 32),
              SizedBox(width: 5),
              Text('Like', style: TextStyle(fontSize: 16),),
            ],
          ),
        ),

        GestureDetector(
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  CommentList().showComment(context, comments);
                },
                child: Image.asset(
                  'assets/icons/comment.png',
                  width: 32,
                  height: 32,
                ),
              ),
              SizedBox(width: 5),
              Text('Comment', style: TextStyle(fontSize: 16),),
            ],
          ),
        ),

        GestureDetector(
          onTap: () {},
          child: Row(
            children: [
              Image.asset('assets/icons/share.png', width: 32, height: 32),
              SizedBox(width: 5),
              Text('Share', style: TextStyle(fontSize: 16),),
            ],
          ),
        ),
      ],
    );
  }
}
