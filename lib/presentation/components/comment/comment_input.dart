import 'package:connectify/domain/controllers/home/comment_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CommentInput extends StatefulWidget {
  final String postId;
  const CommentInput({super.key, required this.postId});

  @override
  State<CommentInput> createState() => _CommentInput();
}

class _CommentInput extends State<CommentInput> {
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final commentController = Provider.of<CommentController>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: contentController,
              decoration: InputDecoration(
                hintText: "Enter comment content...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.blue),
            onPressed: () async {
              await commentController.createComment(
                postId: widget.postId,
                content: contentController.text,
                onError: () {
                  Fluttertoast.showToast(
                    msg: "Error",
                    backgroundColor: Colors.red,
                  );
                },
                onSuccess: () {
                  Fluttertoast.showToast(
                    msg: "Your comment has been submitted.",
                    backgroundColor: Colors.green,
                  );
                },
              );
              contentController.clear();
              commentController.getComments(widget.postId);
            },
          ),
        ],
      ),
    );
  }
}
