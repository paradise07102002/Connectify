import 'package:flutter/material.dart';

class CommentAvatar extends StatefulWidget {
  final String urlAvatar;
  const CommentAvatar({super.key, required this.urlAvatar});

  @override
  State<CommentAvatar> createState() => _CommentAvatar();
}

class _CommentAvatar extends State<CommentAvatar> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Colors.grey,
      backgroundImage: NetworkImage(widget.urlAvatar),
    );
  }
}
