import 'package:connectify/data/models/post/comment_model.dart';
import 'package:connectify/data/models/post/like_model.dart';
import 'package:connectify/data/models/post/media_model.dart';
import 'package:connectify/data/models/post/share_model.dart';

class PostModel {
  final String id;
  final String content;
  final int privacyLevel;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String userId;
  final String avatarUrl;
  final String fullName;
  final List<MediaModel> medias;
  final List<CommentModel> comments;
  final List<LikeModel> likes;
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
    required this.comments,
    required this.likes,
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
      comments:
          (json['comments'] as List)
              .map((e) => CommentModel.fromJson(e))
              .toList(),
      likes: (json['likes'] as List).map((e) => LikeModel.fromJson(e)).toList(),
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
    'comments': comments.map((e) => e.toJson()).toList(),
    'likes': likes.map((e) => e.toJson()).toList(),
    'shares': shares.map((e) => e.toJson()).toList(),
  };
}
