import 'dart:convert';
import 'dart:developer';

import 'package:blog_app/data/models/user.dart';
import 'package:blog_app/data/providers/auth_provider.dart';
import 'package:blog_app/utils/urls.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class UserService {
  final Ref ref;

  UserService({required this.ref});

  Future<User?> getCurrentUser() async {
    try {
      final token = await ref.read(authRepositoryProvider).getToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await http.get(
        Uri.parse(Urls.getUser),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

     // log(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final dynamic user = data['data'];
        return User.fromJson(user);
      } else if (response.statusCode == 401) {
        // Token expired or invalid
        await ref.read(authRepositoryProvider).logout();
        return null;
      } else {
        throw Exception('Failed to get user data');
      }
    } catch (e) {
      log('Error getting user data: $e');
      return null;
    }
  }

  //get user by id
  Future<User?> getUserById(String id) async {
    try {
      final response = await http.get(
        Uri.parse('${Urls.baseUrl}/users/$id'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

     // log(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final dynamic user = data['data'];
        return User.fromJson(user);
      } else if (response.statusCode == 401) {
        // Token expired or invalid
        await ref.read(authRepositoryProvider).logout();
        return null;
      } else {
        throw Exception('Failed to get user data');
      }
    } catch (e) {
      log('Error getting user data: $e');
      return null;
    }
  }

  // Future<bool> updateProfile({
  //   String? username,
  //   String? email,
  //   String? bio,
  // }) async {
  //   try {
  //     final token = await _authService.getToken();
  //     if (token == null) {
  //       throw Exception('No authentication token found');
  //     }

  //     final Map<String, String> updateData = {
  //       if (username != null) 'username': username,
  //       if (email != null) 'email': email,
  //       if (bio != null) 'bio': bio,
  //     };

  //     final response = await http.patch(
  //       Uri.parse(Urls.updateProfile),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //       body: jsonEncode(updateData),
  //     );

  //     if (response.statusCode == 200) {
  //       return true;
  //     } else if (response.statusCode == 401) {
  //       await _authService.logout();
  //       return false;
  //     } else {
  //       throw Exception('Failed to update profile');
  //     }
  //   } catch (e) {
  //     log('Error updating profile: $e');
  //     return false;
  //   }
  // }

  // Future<bool> deleteAccount() async {
  //   try {
  //     final token = await _authService.getToken();
  //     if (token == null) {
  //       throw Exception('No authentication token found');
  //     }

  //     final response = await http.delete(
  //       Uri.parse(Urls.deleteAccount),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       await _authService.logout();
  //       return true;
  //     } else {
  //       throw Exception('Failed to delete account');
  //     }
  //   } catch (e) {
  //     log('Error deleting account: $e');
  //     return false;
  //   }
  // }
}
