class FormValidator {
  //email validator
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email';
    }
    // Check if the email address is at least 6 characters long.
    if (!RegExp(r'^.{6,}$').hasMatch(value)) {
      return 'Email address must be at least 6 characters long';
    }
    // Check if the email address does not contain any spaces.
    if (value.contains(' ')) {
      return 'Email address cannot contain any spaces.';
    }
    // Check if the email address contains an @ symbol.
    if (!value.contains('@')) {
      return 'Email address must contain an @ symbol.';
    }
    // Check if the email address contains a domain name.
    final atIndex = value.indexOf('@');
    final domain = value.substring(atIndex + 1);
    if (!domain.contains('.')) {
      return 'Email address must contain a domain name.';
    }
    // Check if the domain name is a valid top-level domain (TLD).
    // final tlds = <String>['com', 'org', 'net', 'edu', 'gov'];
    // if (!tlds.contains(domain.substring(domain.lastIndexOf('.') + 1))) {
    //   return 'emailTopLevelDomainCheck';
    // }
    return null;
  }

  //name validator
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

//name validator
  static String? validateCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  //name address
  static String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  //otp validator
  static String? validateOtp(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the otp.';
    }
    return null;
  }

  //mobile number validator
  static String? validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter mobile number.';
    }

    // Check if the mobile number starts with a 0,1.
    if (!value.startsWith('01')) {
      return 'Mobile number must start with 0 and 1.';
    }

    // Check if the mobile number is 10 digits long.
    if (value.length != 11) {
      return 'Mobile number must be 11 digits long.';
    }

    // Check if the mobile number is a valid number.
    try {
      int.parse(value);
    } catch (e) {
      return 'Mobile number must be a valid number.';
    }
    return null;
  }

  //password validator signup
  static String? validPasswordSignUp(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password.';
    }

    // Minimum length validation
    if (value.length < 8) {
      return 'Password must be at least 8 characters long.';
    }

    // Uppercase and lowercase letters validation
    // if (!value.contains(RegExp('[a-z]')) ||
    //     !value.contains(RegExp('[A-Z]'),)) {
    //   return 'passUpperAndLower';
    // }

    // Numbers validation
    // if (!value.contains(RegExp(r'[0-9]'))) {
    //   return 'passMustHaveNumeric' ;
    // }
    //
    // // Special characters validation
    // if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    //   return 'passMustHaveSpecialCharacter' ;
    // }

    // Password is valid
    return null;
  }

  //valid passLogin
  static String? validPasswordLogin(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password.';
    }
    // You can add more specific password validation here if needed.
    return null;
  }
}