final String tableBooks = 'books';

class BookFields {
  static final List<String> values = [
    id,
    title,
    createdTime,
    description,
    coverUrl,
  ];

  static final String id = '_id';
  static final String title = 'title';
  static final String createdTime = 'createdTime';
  static final String description = 'description';
  static final String coverUrl = 'coverUrl';
}

class Book {
  final int? id;
  final String title;
  final DateTime createdTime;
  final String description;
  final String coverUrl;

  const Book({
    this.id,
    required this.title,
    required this.createdTime,
    required this.description,
    required this.coverUrl,
  });

  Map<String, Object?> toJson() => {
    BookFields.id : id,
    BookFields.title : title,
    BookFields.createdTime : createdTime.toIso8601String(),
    BookFields.description : description,
    BookFields.coverUrl : coverUrl,
  };

  static Book fromJson(Map<String, Object?> json) => Book(
    id: json[BookFields.id] as int?,
    title: json[BookFields.title] as String,
    createdTime: DateTime.parse(json[BookFields.createdTime] as String),
    description: json[BookFields.description] as String,
    coverUrl: json[BookFields.coverUrl] as String,
  );

  Book copy({
    int? id,
    String? title,
    DateTime? createdTime,
    String? description,
    String? coverUrl,
  }) => Book(
    id: id ?? this.id,
    title: title ?? this.title,
    createdTime: createdTime ?? this.createdTime,
    description: description ?? this.description,
    coverUrl: coverUrl ?? this.coverUrl,
  );
}