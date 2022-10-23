import 'package:book_exchange/data/base/base_mapper.dart';
import 'package:book_exchange/data/entities/user_dto.dart';
import 'package:book_exchange/domain/entities/user.dart';

class UserMapper extends BaseMapper<UserDTO, User> {
  @override
  User transfer(UserDTO d) {
    return User(
      d.id,
      d.username,
      d.password,
      d.email,
      d.address,
      d.verifiedCode,
      d.image,
      d.isEnabled,
    );
  }
}
