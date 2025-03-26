class CreateCommentRequest {
  final String content;

  CreateCommentRequest({required this.content});

  factory CreateCommentRequest.fromJson(Map<String, dynamic> json) =>
      CreateCommentRequest(content: json['content']);

  Map<String, dynamic> toJson() => {'content': content};
}
