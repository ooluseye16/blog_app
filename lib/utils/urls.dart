class Urls {
  static const baseUrl = 'https://blog-api-production-d876.up.railway.app';
  static const posts = '$baseUrl/posts';

  static const login = '$baseUrl/auth/login';
  static const signUp = '$baseUrl/auth/register';

  static const String getUser = '$baseUrl/user';
  static const String getUserPosts = '$baseUrl/user/posts';
  
  // static const String updateProfile = '$baseUrl/api/users/update';
  // static const String deleteAccount = '$baseUrl/api/users/delete';
}
