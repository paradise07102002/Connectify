import 'package:connectify/data/models/post/post_model.dart';
import 'package:connectify/presentation/components/post/post_actions.dart';
import 'package:connectify/presentation/components/post/post_content.dart';
import 'package:connectify/presentation/components/post/post_header.dart';
import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  final PostModel post;

  const PostItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostHeader(urlAvatar: post.avatarUrl, fullname: post.fullName, createdAt: post.createdAt),
          SizedBox(height: 10),
          PostContent(content: post.content ?? '', medias: post.medias),
          PostActions(comments: post.comments,)
        ],
      ),
    );
  }
}