import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:connectify/data/models/media/get_media_model.dart';
import 'package:connectify/domain/controllers/home/media_controller.dart';
import 'package:connectify/presentation/components/post/post_photo_gallary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class PostContent extends StatelessWidget {
  final String content;
  // final List<MediaModel> medias;
  final String postId;

  const PostContent({super.key, required this.content, required this.postId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MediaController()..getMediaByPostId(postId),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedReadMoreText(content, maxLines: 2),
          SizedBox(height: 10),
          Consumer<MediaController>(
            builder: (context, mediaController, child) {
              if (mediaController.isLoading) {
                return CircularProgressIndicator();
              }

              if (mediaController.medias.isNotEmpty) {
                return _buildMediaGrid(context, mediaController.medias);
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMediaGrid(BuildContext context, List<GetMediaModel> medias) {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: List.generate(medias.length, (index) {
        return StaggeredGridTile.fit(
          crossAxisCellCount: index == 0 && medias.length > 1 ? 2 : 1,
          child: GestureDetector(
            onTap: () => _openGallery(context, medias, index),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(medias[index].mediaUrl, fit: BoxFit.cover),
            ),
          ),
        );
      }),
    );
  }

  void _openGallery(
    BuildContext context,
    List<GetMediaModel> medias,
    int initialIndex,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => PostPhotoGallary(medias: medias, initialIndex: initialIndex),
      ),
    );
  }
}
