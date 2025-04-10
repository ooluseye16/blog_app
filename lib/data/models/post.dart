class Post {
  final String id;
  final String title;
  final String content;
  final String author;
  final String image;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.createdAt,
    this.image = '',
  });

  //fromJson method to convert a JSON object to a Post object
  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'],
        author = json['author'],
 
       image = json['image'] ?? '',
        createdAt = DateTime.parse(json['createdAt'], 
        
        );
}