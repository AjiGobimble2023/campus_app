// ignore: file_names
import 'package:equatable/equatable.dart';

class EventModel extends Equatable {
  final String id;
  final String title;
  final String date;
  final String? location;
  final String? description;
  final String? imageurl;

  const EventModel({
    required this.id,
    required this.title,
    required this.date,
    this.location,
    this.description,
    this.imageurl,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        date,
        location,
        description,
        imageurl,
      ];

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
        id: json['_id'],
        title: json['title'],
        date: json['date'],
        location: json['location'],
        description: json['description'],
        imageurl: json['image_url']);
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'date': date,
      'location': location,
      'description': description,
      'image_url': imageurl
    };
  }
}
