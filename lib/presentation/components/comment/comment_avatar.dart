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
    return Container(
      margin: EdgeInsets.only(left: 10),
      height: 64,
      width: 64,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: Image(image: NetworkImage(widget.urlAvatar)),
    );
  }
}
