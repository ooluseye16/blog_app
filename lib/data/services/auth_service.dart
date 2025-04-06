import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:blog_app/utils/urls.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  
  final _storage = getSecureStorage;
  static const _tokenKey = 'jwt_token';

  AuthService();

  Future<(bool, String?)> login(
      {required String email, required String password}) async {
    try {
      final response = await http.post(
        Uri.parse(Urls.login),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      log(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await _storage.write(key: _tokenKey, value: data['token']);
        return (true, null);
      } else {
        return (false, 'Failed to login');
      }
    } catch (e) {
      log('Error: $e');
      return (false, e.toString());
    }
  }

  Future<(bool, String?)> signup(
      {required String email,
      required String password,
      required String username}) async {
    try {
      final response = await http.post(
        Uri.parse(Urls.signUp),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
          'username': username,
        }),
      );
//final data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        // Auto login after successful signup
        return login(email: email, password: password);
      } else {
        log(response.body);
        return (false, 'Failed to signup');
      }
    } catch (e) {
      log('Error: $e');
      return (false, e.toString());
    }
  }

  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  Future<void> logout() async {
    await _storage.delete(key: _tokenKey);
  }

  static FlutterSecureStorage get getSecureStorage {
    if (kIsWeb) {
      return FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
        iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
        webOptions: WebOptions(
            dbName: "secure_store", publicKey: 'FlutterSecureStorage'),
      );
    } else if (Platform.isMacOS) {
      return FlutterSecureStorage(
        iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
      );
    } else {
      return FlutterSecureStorage();
    }
  }
}
