class BookDTO {
  final String id;
  final String name;
  final String author;
  final String description;
  final double rate;
  final String imageURL;
  final String userId;
  final bool isDelete;

  BookDTO({
    required this.id,
    required this.name,
    required this.author,
    required this.description,
    required this.rate,
    required this.imageURL,
    required this.userId,
    required this.isDelete,
  });

  Map<dynamic, dynamic> toMap() {
    return {
      'id ': id,
      'name': name,
      'author': author,
      'description': description,
      'rate': rate,
      'imageUrl': imageURL,
      'userId': userId,
      'isDelete': isDelete,
    };
  }

  factory BookDTO.fromMap(Map<dynamic, dynamic> map) {
    return BookDTO(
      id: map['id'],
      name: map['name'],
      author: map['author'],
      description: map['description'],
      rate: map['rate'],
      imageURL: map['imageUrl'],
      userId: map['userId'],
      isDelete: map['delete'],
    );
  }
}
