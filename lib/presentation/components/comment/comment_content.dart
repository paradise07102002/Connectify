import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:flutter/material.dart';

class CommentContent extends StatefulWidget {
  const CommentContent({super.key});

  @override
  State<CommentContent> createState() => _CommentContent();
}

class _CommentContent extends State<CommentContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Phạm Đình Khôi',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          AnimatedReadMoreText(
            'dfsdgdfgdgdgdfgfdggggggggggggggggggggggggggggggggggggggggggggggg',
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
