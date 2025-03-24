class LikeModel {
  final String userId;
  final String postId;

  LikeModel({required this.userId, required this.postId});

  factory LikeModel.fromJson(Map<String, dynamic> json) =>
      LikeModel(userId: json['userId'], postId: json['postId']);

  Map<String, dynamic> toJson() => {'userId': userId, 'postId': postId};
}