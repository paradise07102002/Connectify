import 'package:connectify/domain/controllers/home/comment_controller.dart';
import 'package:connectify/presentation/components/comment/comment_input.dart';
import 'package:connectify/presentation/components/comment/comment_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentList {
  void showComment(BuildContext context, String postId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) {
        return ChangeNotifierProvider(
          create: (_) => CommentController()..getComments(postId),
          child: Consumer<CommentController>(
            builder: (context, commentController, child) {
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
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 15),
                          Expanded(
                            child:
                                commentController.isLoading
                                    ? Center(child: CircularProgressIndicator())
                                    : ListView.builder(
                                      itemCount:
                                          commentController.comments.length,
                                      itemBuilder: (context, index) {
                                        return CommentItem(
                                          comment:
                                              commentController.comments[index],
                                        );
                                      },
                                    ),
                          ),
                          Divider(),
                          CommentInput(postId: postId),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
