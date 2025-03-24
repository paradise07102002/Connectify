import 'package:connectify/data/models/post/post_model.dart';
import 'package:connectify/data/repositories/post_repository.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  final PostRepository _postRepository = PostRepository();

  bool isLoading = true;

  String? errorMessage;

  List<PostModel> posts = [];

  HomeController() {
    getAllPost();
  }

  Future<void> getAllPost() async {
  try {
    posts = await _postRepository.getAllPost();
  } catch (e) {
    errorMessage = e.toString();
  } finally {
    isLoading = false;
    notifyListeners();
  }
}
}