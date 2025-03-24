import 'package:connectify/domain/controllers/home/home_controller.dart';
import 'package:connectify/presentation/components/post/post_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeController()..getAllPost(),
      child: Scaffold(
        body: Consumer<HomeController>(
          builder: (context, controller, child) {
            if (controller.isLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (controller.errorMessage != null) {
              return Center(child: Text('Error: ${controller.errorMessage ?? "Unknown error"}'));
            } else if (controller.posts.isEmpty) {
              return Center(child: Text('No posts'));
            }

            return PostList(posts: controller.posts);
          },
        ),
      ),
    );
  }
}
