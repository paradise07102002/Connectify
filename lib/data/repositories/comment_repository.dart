import 'dart:convert';
import 'package:connectify/data/models/comment/create_comment_request.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CommentRepository {
  final baseUrl = 'http://10.0.2.2:5151/api';

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<bool> createComment(
    String postId,
    CreateCommentRequest createComment,
  ) async {
    final accessToken = await secureStorage.read(key: 'access_token');

    final response = await http.post(
      Uri.parse('$baseUrl/posts/$postId/comments'),
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(createComment.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }
}
