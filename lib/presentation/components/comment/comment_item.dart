import 'package:connectify/data/models/post/comment_model.dart';
import 'package:connectify/presentation/components/comment/comment_actions.dart';
import 'package:connectify/presentation/components/comment/comment_avatar.dart';
import 'package:connectify/presentation/components/comment/comment_content.dart';
import 'package:flutter/material.dart';

class CommentItem extends StatefulWidget {
  final CommentModel comment;
  const CommentItem({super.key, required this.comment});

  @override
  State<CommentItem> createState() => _CommentItem();
}

class _CommentItem extends State<CommentItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 10),
        CommentAvatar(urlAvatar: widget.comment.avatarUrl),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommentContent(
                content: widget.comment.content,
                fullName: widget.comment.fullName,
              ),
              CommentActions(createdAt: widget.comment.createdAt,),
            ],
          ),
        ),
      ],
    );
  }
}

