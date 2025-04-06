class Post {
 

  final String id;
  final String title;
  final String content;
  final String author;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.createdAt,
  });

  //fromJson method to convert a JSON object to a Post object
  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'],
        author = json['author'],
        createdAt = DateTime.parse(json['createdAt']);
}