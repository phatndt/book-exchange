class UserDTO {
  final String id;
  final String username;
  final String password;
  final String email;
  final String address;
  final String verifiedCode;
  final String image;
  final bool isEnabled;

  UserDTO({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.address,
    required this.verifiedCode,
    required this.image,
    required this.isEnabled,
  });

  Map<dynamic, dynamic> toMap() {
    return {
      'id ': id,
      'username': username,
      'password': password,
      'email': email,
      'address': address,
      'verifiedCode': verifiedCode,
      'image': image,
      'isEnabled': isEnabled,
    };
  }

  factory UserDTO.fromMap(Map<dynamic, dynamic> map) {
    return UserDTO(
      id: map['id'],
      username: map['username'],
      password: map['password'],
      email: map['email'],
      address: map['address'],
      verifiedCode: map['verifiedCode'],
      image: map['imageUrl'],
      isEnabled: map['enabled'],
    );
  }
}
