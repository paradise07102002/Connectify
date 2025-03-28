
class PostModel {
  final String id;
  final String? content;
  final int privacyLevel;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String userId;
  final String avatarUrl;
  final String fullName;

  PostModel({
    required this.id,
    required this.content,
    required this.privacyLevel,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.avatarUrl,
    required this.fullName,
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
  };
}