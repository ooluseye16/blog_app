import 'package:blog_app/data/models/user.dart';
import 'package:blog_app/data/services/user_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@Riverpod(keepAlive: true)
UserService userRepository(Ref ref) {
  return UserService(ref: ref);
}

@Riverpod(keepAlive: true)
Future<User?> user(Ref ref) {
  final userService = ref.read(userRepositoryProvider);
  return userService.getCurrentUser();
}

@Riverpod(keepAlive: true)
Future<User?> userById(Ref ref, String id) {
  final userService = ref.read(userRepositoryProvider);
  return userService.getUserById(id);
}
