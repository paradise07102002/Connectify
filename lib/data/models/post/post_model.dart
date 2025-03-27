import 'package:connectify/data/models/post/media_model.dart';
import 'package:connectify/data/models/post/share_model.dart';

class PostModel {
  final String id;
  final String? content;
  final int privacyLevel;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String userId;
  final String avatarUrl;
  final String fullName;
  final List<MediaModel> medias;
  final List<ShareModel> shares;

  PostModel({
    required this.id,
    required this.content,
    required this.privacyLevel,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.avatarUrl,
    required this.fullName,
    required this.medias,
    required this.shares,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      content: json['content'],
      privacyLevel: json['privacyLevel'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt:
          json['updateAt'] != null ? DateTime.tryParse(json['updateAt']) : null,
      userId: json['userId'],
      avatarUrl: json['avatarUrl'],
      fullName: json['fullName'],
      medias:
          (json['medias'] as List).map((e) => MediaModel.fromJson(e)).toList(),
      shares:
          (json['shares'] as List).map((e) => ShareModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'content': content,
    'privacyLevel': privacyLevel,
    'createdAt': createdAt.toIso8601String(),
    'updateAt': updatedAt?.toIso8601String(),
    'userId': userId,
    'avatarUrl': avatarUrl,
    'fullName': fullName,
    'medias': medias.map((e) => e.toJson()).toList(),
    'shares': shares.map((e) => e.toJson()).toList(),
  };
}