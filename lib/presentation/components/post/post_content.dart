import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:connectify/data/models/post/media_model.dart';
import 'package:flutter/material.dart';

class PostContent extends StatelessWidget {
  final String content;
  final List<MediaModel> medias;
  const PostContent({super.key, required this.content, required this.medias});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedReadMoreText(content, maxLines: 2),
        SizedBox(height: 10),
        if (medias.isNotEmpty) Image.network(medias.first.mediaUrl),
      ],
    );
  }
}
