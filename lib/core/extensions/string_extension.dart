// ignore_for_file: unnecessary_this

import '../constants/regex_constants.dart';

extension StringLocalization on String {
  String? get isValidEmail =>
      this.contains(RegExp(RegexConstants.instance!.emailRegex))
          ? null
          : "Email not valid";

  String? get isValidPassword {
    return RegExp(RegexConstants.instance!.passwordRegex).hasMatch(this)
        ? null
        : "The value has a minimum of six characters.";
  }
}

extension ImageExtension on String {
  String get imagePNG => "assets/image/$this.png";
}
