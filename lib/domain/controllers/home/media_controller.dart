import 'package:connectify/data/models/media/get_media_model.dart';
import 'package:connectify/data/repositories/media_repository.dart';
import 'package:flutter/material.dart';

class MediaController extends ChangeNotifier {
  final MediaRepository mediaRepository = MediaRepository();

  bool isLoading = false;


  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  List<GetMediaModel> medias = [];
  Future<void> getMediaByPostId(String postId) async {
    setLoading(true);

    try {
      medias = await mediaRepository.getMediasByPostId(postId);
    } finally {
      setLoading(false);
    }
  }
}
