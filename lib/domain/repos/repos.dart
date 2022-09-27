// import 'package:flutter/material.dart';

// import '../../presentation/models/user_model.dart';

// class UserRepo {
//   String? uid;
//   UserModel? userModel;

//   Future<bool> updateUserProfileToFireStore(
//     UserModel userData,
//     String email,
//     String phoneNumber,
//     String userName,
//   ) async {
//     bool check = false;
//     await FirebaseFirestore.instance
//         .collection("users")
//         .doc(userData.id)
//         .set(
//           {
//             'userName': userName,
//             'email': email,
//             'isActived': true,
//             'isEmailVerified': false,
//             'phone': phoneNumber,
//             'firstName': "",
//             'lastName': "",
//             'birthday': "",
//             'gender': "",
//             'address': "",
//             'imageUrl': "",
//             'createDate': DateTime.now(),
//             'lastUpdateDate': "",
//           },
//         )
//         .then((value) => check = !check)
//         .catchError((onError) {
//           Fluttertoast.showToast(msg: onError);
//           return check;
//         });
//     return check;
//   }
// }
