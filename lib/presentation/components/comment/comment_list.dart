import 'package:connectify/data/models/post/comment_model.dart';
import 'package:connectify/presentation/components/comment/comment_input.dart';
import 'package:connectify/presentation/components/comment/comment_item.dart';
import 'package:flutter/material.dart';

class CommentList {
  void showComment(BuildContext context, List<CommentModel> comments) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.7,
            minChildSize: 0.3,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Expanded(
                      child: ListView.builder(
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          return CommentItem(comment: comments[index]);
                        },
                      ),
                    ),
                    Divider(),
                    CommentInput(),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
