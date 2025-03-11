class ReviewModel {
  final String avatarUrl;
  final String author;
  final double rating;
  final DateTime date;
  final String comment;

  const ReviewModel({
    required this.avatarUrl,
    required this.author,
    required this.rating,
    required this.date,
    required this.comment,
  });

  // Convert from JSON
  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      avatarUrl: json['avatarUrl'] as String,
      author: json['name'] as String,
      rating: json['rating'].toDouble(),
      date: DateTime.parse(json['date'] as String),
      comment: json['message'] as String,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() => {
        'avatarUrl': avatarUrl,
        'name': author,
        'rating': rating,
        'date': date.toIso8601String(),
        'message': comment,
      };

  // Copy with method
  ReviewModel copyWith({
    String? avatarUrl,
    String? author,
    double? rating,
    DateTime? date,
    String? comment,
  }) {
    return ReviewModel(
      avatarUrl: avatarUrl ?? this.avatarUrl,
      author: author ?? this.author,
      rating: rating ?? this.rating,
      date: date ?? this.date,
      comment: comment ?? this.comment,
    );
  }
}
