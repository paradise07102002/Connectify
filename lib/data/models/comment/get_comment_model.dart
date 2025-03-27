class GetCommentModel {
  final String id;
  final String content;
  final DateTime createdAt;
  final String postId;
  final String userId;
  final String avatarUrl;
  final String fullName;

  GetCommentModel({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.postId,
    required this.userId,
    required this.avatarUrl,
    required this.fullName
  });

  factory GetCommentModel.fromJson(Map<String, dynamic> json) => GetCommentModel(
    id: json['id'],
    content: json['content'],
    createdAt: DateTime.parse(json['createdAt']),
    postId: json['postId'],
    userId: json['userId'],
    avatarUrl: json['avatarUrl'],
    fullName: json['fullName']
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'content': content,
    'createdAt': createdAt.toIso8601String(),
    'postId': postId,
    'userId': userId,
    'avatarUrl': avatarUrl,
    'fullName': fullName
  };
}
