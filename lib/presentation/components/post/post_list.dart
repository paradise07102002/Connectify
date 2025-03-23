import 'package:connectify/data/models/post/post_model.dart';
import 'package:connectify/presentation/components/post/post_item.dart';
import 'package:flutter/material.dart';

class PostList extends StatefulWidget {
  final List<PostModel> posts;

  const PostList({super.key, required this.posts});

  @override
  State<PostList> createState() => _PostList();
}

class _PostList extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder:
          (context, index) => Container(height: 10, color: Colors.blueGrey),
      itemCount: widget.posts.length,
      itemBuilder: (context, index) {
        return PostItem(post: widget.posts[index]);
      },
    );
  }
}
