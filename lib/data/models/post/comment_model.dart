class CommentModel {
  final String id;
  final String content;
  final DateTime createdAt;
  final String postId;
  final String userId;

  final String fullName;
  final String avatarUrl;

  CommentModel({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.postId,
    required this.userId,
    required this.fullName,
    required this.avatarUrl
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
    id: json['id'],
    content: json['content'],
    createdAt: DateTime.parse(json['createAt']),
    postId: json['postId'],
    userId: json['userId'],
    fullName: json['fullName'],
    avatarUrl: json['avatarUrl']
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'content': content,
    'createAt': createdAt.toIso8601String(),
    'postId': postId,
    'userId': userId,
    'fullName': fullName,
    'avatarUrl': avatarUrl,
  };
}
