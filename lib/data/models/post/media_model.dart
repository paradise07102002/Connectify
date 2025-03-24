class MediaModel {
  final String id;
  final String mediaUrl;
  final int type;
  final String postId;

  MediaModel({
    required this.id,
    required this.mediaUrl,
    required this.type,
    required this.postId,
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) => MediaModel(
    id: json['id'],
    mediaUrl: json['mediaUrl'],
    type: json['type'],
    postId: json['postId'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'mediaUrl': mediaUrl,
    'type': type,
    'postId': postId,
  };
}