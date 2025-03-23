import 'dart:convert';

import 'package:connectify/data/models/post/comment_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class CommentRepository {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final baseUrl = 'http://192.168.1.27:5151/api/Comments';

  Future<List<CommentModel>> getCommentByPostId(String postId) async {
    final accessToken = await secureStorage.read(key: 'access_token');
    final response = await http.get(
      Uri.parse('$baseUrl/$postId'),
      headers: {'accept': '*/*', 'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);

      return jsonData.map((e) => CommentModel.fromJson(e)).toList();
    } else {
      throw Exception('Error: ${response.statusCode}');
    }
  }
}
