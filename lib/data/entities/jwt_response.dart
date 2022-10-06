import 'user.dart';

class JwtResponse {
  final String token;
  final User user;

  JwtResponse({
    required this.token,
    required this.user,
  });

  Map<dynamic, dynamic> toMap() {
    return {
      'token': token,
      'user': user,
    };
  }

  factory JwtResponse.fromMap(Map<dynamic, dynamic> map) {
    return JwtResponse(
      token: map['token'],
      user: User.fromMap(map['user']),
    );
  }
}
