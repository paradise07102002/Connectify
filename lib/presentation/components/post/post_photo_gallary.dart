import 'package:connectify/data/models/media/get_media_model.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PostPhotoGallary extends StatefulWidget {
  final List<GetMediaModel> medias;
  final int initialIndex;

  const PostPhotoGallary({super.key, required this.medias, required this.initialIndex});

  @override
  State<PostPhotoGallary> createState() => _PostPhotoGallary();
}

class _PostPhotoGallary extends State<PostPhotoGallary> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PhotoViewGallery.builder(
            itemCount: widget.medias.length,
            pageController: _pageController,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(widget.medias[index].mediaUrl),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
              );
            },
            onPageChanged: (index) => setState(() => _currentIndex = index),
            backgroundDecoration: BoxDecoration(color: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "${_currentIndex + 1} / ${widget.medias.length}",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
