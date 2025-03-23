import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostHeader extends StatelessWidget {
  final String? urlAvatar;
  final String fullname;
  final DateTime createdAt;

  const PostHeader({
    super.key,
    required this.urlAvatar,
    required this.fullname,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.grey,
          backgroundImage: NetworkImage(urlAvatar ?? ''),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fullname,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            Text(
              DateFormat('dd/MM/yyyy HH:mm').format(createdAt),
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
        Spacer(),
        Icon(Icons.more_vert),
        Icon(Icons.close),
      ],
    );
  }
}
