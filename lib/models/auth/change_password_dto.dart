class ChangePasswordDto {
  String? _oldPassword;
  String? _newPassword;
  String? _newPasswordAgain;

  String? get oldPassword => this._oldPassword;

  set oldPassword(String? value) => this._oldPassword = value;

  get newPassword => this._newPassword;

  set newPassword(value) => this._newPassword = value;

  get newPasswordAgain => this._newPasswordAgain;

  set newPasswordAgain(value) => this._newPasswordAgain = value;
}
