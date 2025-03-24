  import 'dart:convert';
  import 'package:http/http.dart' as http;
  import 'package:connectify/data/models/post/post_model.dart';
  import 'package:flutter_secure_storage/flutter_secure_storage.dart';

  class PostRepository {
    final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

    final baseUrl = 'http://10.0.2.2:5151/api/Post';

    Future<List<PostModel>> getAllPost() async {
      final accessToken = await secureStorage.read(key: 'access_token');

      final response = await http.get(
        Uri.parse('$baseUrl/get-all-post'),
        headers: {'accept': '*/*', 'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((e) => PostModel.fromJson(e)).toList();
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    }
  }