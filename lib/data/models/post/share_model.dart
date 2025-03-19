class ShareModel {
  final String userId;
  final String postId;

  ShareModel({required this.userId, required this.postId});

  factory ShareModel.fromJson(Map<String, dynamic> json) =>
      ShareModel(userId: json['userId'], postId: json['postId']);

  Map<String, dynamic> toJson() => {'userId': userId, 'postId': postId};
}
