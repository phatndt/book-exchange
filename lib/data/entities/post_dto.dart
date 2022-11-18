class PostDTO {
  final String id;
  final String content;
  final String createDate;
  final int nLikes;
  final int nComments;
  final String userId;
  final String imageUrl;
  final bool isDeleted;

  PostDTO({
    required this.id,
    required this.content,
    required this.createDate,
    required this.nLikes,
    required this.nComments,
    required this.userId,
    required this.imageUrl,
    required this.isDeleted,
  });

  Map<dynamic, dynamic> toMap() {
    return {
      'id ': id,
      'content': content,
      'createDate': createDate,
      'nLikes': nLikes,
      'nComments': nComments,
      'userId': userId,
      'imageUrl': imageUrl,
      'isDeleted': isDeleted,
    };
  }

  factory PostDTO.fromMap(Map<dynamic, dynamic> map) {
    return PostDTO(
      id: map['id'],
      content: map['content'],
      createDate: map['createDate'],
      nLikes: map['nlikes'],
      nComments: map['ncomments'],
      userId: map['userId'],
      imageUrl: map['imageUrl'],
      isDeleted: map['deleted'],
    );
  }
}
