class DiscussionTopicModel {
  final String title;
  final Map<String, dynamic> author;
  final String imageUrl;
  final String content;

  DiscussionTopicModel({
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.content
  });

  factory DiscussionTopicModel.fromJson(Map<String, dynamic> json) {
    return DiscussionTopicModel(
      title: json['title'],
      author: json['author'],
      imageUrl: json['image_url'],
      content: json['content']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'image_url': imageUrl,
      'content' : content
    };
  }
}
