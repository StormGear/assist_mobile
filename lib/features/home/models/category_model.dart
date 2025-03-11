import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final String id;
  final String title;
  final String imageUrl;
  final String feed;

  const CategoryModel({
    required this.id,
    required this.title,
    this.imageUrl = '',
    this.feed = '',
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      feed: json['feed'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': title,
      'imageUrl': imageUrl,
      'feed': feed,
    };
  }

  @override
  List<Object?> get props => [id, title, imageUrl];

  CategoryModel copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
