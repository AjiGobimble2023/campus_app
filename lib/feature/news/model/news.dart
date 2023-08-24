import 'dart:convert';

InformationModel informationModelFromJson(String str) =>
    InformationModel.fromJson(json.decode(str));

String informationModelToJson(InformationModel data) =>
    json.encode(data.toJson());

class InformationModel {
  final String id;
  final String title;
  final String imageUrl;
  final String content;
  final String createdAt;

  InformationModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.content,
    required this.createdAt,
  });

  factory InformationModel.fromJson(Map<String, dynamic> json) =>
      InformationModel(
        id: json["_id"],
        title: json["title"],
        imageUrl: json["image_url"],
        content: json["content"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "image_url": imageUrl,
        "content": content,
        "createdAt": createdAt,
      };
}
