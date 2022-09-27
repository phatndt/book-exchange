class UserModel {
  final String id;
  final String? name;
  final String email;
  final String? password;
  final String? address;
  final String? imageUrl;

  //==============================
  // final DateTime? createDate;
  // final String? lastUpdateDate;
  // final bool? isActived;
  // final bool? isEmailVerified;

  UserModel({
    required this.id,
    required this.email,
    this.name,
    this.password,
    this.address,
    this.imageUrl,
    //==============================
    // this.createDate,
    // this.lastUpdateDate,
    // this.isActived,
    // this.isEmailVerified,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name ?? '',
      'password': password ?? '',
      'address': address ?? '',
      'imageUrl': imageUrl ?? '',
      // 'createDate': createDate ?? '',
      // 'lastUpdateDate': lastUpdateDate ?? '',
      // 'isActived': isActived ?? '',
      // 'isEmailVerified': isEmailVerified ?? '',
    }..removeWhere((key, value) => value == null);
  }

  factory UserModel.fromMap(Map<String, dynamic> map, String documentId) {
    return UserModel(
      id: documentId,
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      imageUrl: map['imageUrl'] ?? "",
      // createDate: map['createDate'] != ""
      //     ? DateFormat("dd-MM-yyyy HH:mm:ss").parse(map['createDate'])
      //     : DateTime.now(),
      // lastUpdateDate: map['lastUpdateDate'] != "" ? map['createDate'] : '',
      // isActived: map['isActived'] ?? '',
      // isEmailVerified: map['isEmailVerified'] ?? '',
    );
  }
}
