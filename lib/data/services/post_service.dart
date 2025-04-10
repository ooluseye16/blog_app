import 'dart:convert';
import 'dart:developer';

import 'package:blog_app/data/models/post.dart';
import 'package:blog_app/data/providers/auth_provider.dart';
import 'package:blog_app/utils/urls.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class PostService {
  Ref ref;
  PostService(this.ref);

  Future<List<Post>> getPosts() async {
    try {
      final response = await http.get(Uri.parse(Urls.posts));
     // log(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> posts = data['data'];
        return posts.map((post) => Post.fromJson(post)).toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      log('Error: $e');
      rethrow;
    }
  }

  //get user's posts
  Future<List<Post>> getUsersPosts() async {
    try {
      final token = await ref.read(authRepositoryProvider).getToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await http.get(
        Uri.parse(Urls.getUserPosts),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      //log(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> posts = data['data'];
        return posts.map((post) => Post.fromJson(post)).toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      log('Error: $e');
      rethrow;
    }
  }

  Future<(bool, String?)> createPost(String title, String content,
      {XFile? image}) async {
    try {
      final token = await ref.read(authRepositoryProvider).getToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final request = http.MultipartRequest(
        'POST',
        Uri.parse(Urls.posts),
      );

      final headers = {
        'Authorization': 'Bearer $token',
      };

      request.headers.addAll(headers);
      request.fields.addAll({
        'title': title,
        'content': content,
      });

      if (image != null) {
        final bytes = await image.readAsBytes();
        final filename = image.path.split('/').last;

        request.files.add(
          http.MultipartFile.fromBytes(
            'image',
            bytes,
            filename: filename,
          ),
        );
      }

      final response = await request.send();

      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        return (true, null);
      } else {
        return (false, responseBody);
      }
    } catch (e) {
      log('Error: $e');
      return (false, 'Error: $e');
    }
  }

  //get post by id
  Future<Post> getPostById(String id) async {
    try {
      final response = await http.get(Uri.parse('${Urls.posts}/$id'));
     // log(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Post.fromJson(data['data']);
      } else {
        throw Exception('Failed to load post');
      }
    } catch (e) {
      log('Error: $e');
      rethrow;
    }
  }
}
