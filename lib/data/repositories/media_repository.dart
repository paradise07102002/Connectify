import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectify/data/models/media/get_media_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MediaRepository {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  final baseUrl = 'http://10.0.2.2:5151/api/posts';

  Future<List<GetMediaModel>> getMediasByPostId(String postId) async {
    final accessToken = await secureStorage.read(key: 'access_token');
    final response = await http.get(
      Uri.parse('$baseUrl/$postId/medias'),
      headers: {'accept': '*/*', 'Authorization': 'Bearer $accessToken'},
    );

    try {
      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);

        return jsonData.map((e) => GetMediaModel.fromJson(e)).toList();
      } else {
        throw Exception("Error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
