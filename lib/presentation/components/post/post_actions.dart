import 'package:connectify/data/models/post/comment_model.dart';
import 'package:connectify/presentation/components/comment/comment_list.dart';
import 'package:flutter/material.dart';

class PostActions extends StatelessWidget {
  final List<CommentModel> comments;
  const PostActions({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            Stack(
              children: [
                Icon(Icons.favorite, color: Colors.black, size: 35),
                Positioned.fill(
                  child: Icon(Icons.favorite, color: Colors.white, size: 32),
                ),
              ],
            ),
            Text('3.999'),
          ],
        ),

        Row(
          children: [
            GestureDetector(
              onTap: () {
                CommentList().showComment(context, comments);
              },
              child: Stack(
                children: [
                  Icon(Icons.comment, color: Colors.black, size: 35),
                  Positioned.fill(
                    child: Icon(Icons.comment, color: Colors.white, size: 32),
                  ),
                ],
              ),
            ),
            Text('10'),
          ],
        ),

        Row(
          children: [
            Stack(
              children: [
                Icon(Icons.share, color: Colors.black, size: 35),
                Positioned.fill(
                  child: Icon(Icons.share, color: Colors.white, size: 32),
                ),
              ],
            ),
            Text('2'),
          ],
        ),
      ],
    );
  }
}
