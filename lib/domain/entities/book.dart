class Book {
  final String id;
  final String name;
  final String author;
  final String description;
  final double rate;
  final String imageURL;
  final String userId;
  final bool isDelete;

  Book({
    required this.id,
    required this.name,
    required this.author,
    required this.description,
    required this.rate,
    required this.imageURL,
    required this.userId,
    required this.isDelete,
  });
}
