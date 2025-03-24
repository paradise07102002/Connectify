class CommentModel {
  final String id;
  final String content;
  final DateTime createdAt;
  final String postId;
  final String userId;
  final String avatarUrl;
  final String fullName;

  CommentModel({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.postId,
    required this.userId,
    required this.avatarUrl,
    required this.fullName
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
    id: json['id'],
    content: json['content'],
    createdAt: DateTime.parse(json['createAt']),
    postId: json['postId'],
    userId: json['userId'],
    avatarUrl: json['avatarUrl'],
    fullName: json['fullName']
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'content': content,
    'createAt': createdAt.toIso8601String(),
    'postId': postId,
    'userId': userId,
    'avatarUrl': avatarUrl,
    'fullName': fullName
  };
}
