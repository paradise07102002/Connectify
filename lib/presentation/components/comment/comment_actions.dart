import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentActions extends StatefulWidget {
  final DateTime createdAt;
  const CommentActions({super.key, required this.createdAt});

  @override
  State<CommentActions> createState() => _CommentActions();
}

class _CommentActions extends State<CommentActions> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 25, bottom: 15),
      child: Row(
        children: [
          Text(
            timeago.format(widget.createdAt, locale: 'vi_short'),
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(width: 10),
          Text(
            'Thích',
            style: TextStyle(
              color: Colors.black45,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(width: 10),
          Text(
            'Trả lời',
            style: TextStyle(
              color: Colors.black45,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
