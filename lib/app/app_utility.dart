
import 'const.dart';

class AppUtility {
  static bool validateBDPhoneNumber(String value) {
    return AppConstants.bdPhoneNoValidationRegex.hasMatch(value);
  }

  static bool validateEmail(String email) {
    return AppConstants.emailValidationRegex.hasMatch(email);
  }
}