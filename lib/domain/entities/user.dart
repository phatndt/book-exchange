class User {
  String _id;
  String _username;
  String _password;
  String _email;
  String _address;
  String _verifiedCode;
  String _image;
  bool _isEnabled;

  User(
    this._id,
    this._username,
    this._password,
    this._email,
    this._address,
    this._verifiedCode,
    this._image,
    this._isEnabled,
  );

  String get id => _id;
  String get username => _username;
  String get password => _password;
  String get email => _email;
  String get address => _address;
  String get verifiedCode => _verifiedCode;
  String get image => _image;
  bool get enable => _isEnabled;

  set id(id) => _id = id;
  set username(username) => _username = username;
  set password(password) => _password = password;
  set email(id) => _email = email;
  set address(id) => _address = address;
  set verifiedCode(id) => _verifiedCode = verifiedCode;
  set image(id) => _image = image;
  set enable(id) => _isEnabled = enable;

  @override
  String toString() {
    return _id +
        _username +
        _password +
        _email +
        _address +
        _verifiedCode +
        _image +
        _isEnabled.toString();
  }
}
