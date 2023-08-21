class NewUserDto {
  late String _email;
  late String _username;
  late String _password;
  late String _passwordAgain;
  late String _firstName;
  late String _lastName;

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get username => _username;

  set username(String value) {
    _username = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get passwordAgain => _passwordAgain;

  set passwordAgain(String value) {
    _passwordAgain = value;
  }

  String get firstName => _firstName;

  set firstName(String value) {
    _firstName = value;
  }

  String get lastName => _lastName;

  set lastName(String value) {
    _lastName = value;
  }
}
