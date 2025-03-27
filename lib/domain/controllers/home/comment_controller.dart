import 'package:connectify/data/models/comment/create_comment_request.dart';
import 'package:connectify/data/repositories/comment_repository.dart';
import 'package:flutter/material.dart';

class CommentController extends ChangeNotifier {
  final CommentRepository commentRepository = CommentRepository();

  bool isLoading = false;

  String? contentIsEmpty;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> createComment({
    required String postId,
    required String content,
    required Function() onError,
    required Function() onSuccess,
  }) async {
    contentIsEmpty =
        content.trim().isEmpty ? "Please enter comment content" : null;

    if (contentIsEmpty != null) {
      notifyListeners();
      return;
    }

    setLoading(true);

    try {
      final createComment = CreateCommentRequest(content: content.trim());

      final response = await commentRepository.comment(postId, createComment);

      if (response) {
        onSuccess();
      } else {
        onError();
      }
    } finally {
      setLoading(false);
    }
  }
}
