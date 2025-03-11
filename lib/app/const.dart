enum UserRole { plotOwner, tenant, flatOwner, corporate }

String getRoleNameFromEnum(UserRole role) {
  String name = '';
  switch(role) {
    case UserRole.plotOwner:
      name = 'Plot Owner';
    case UserRole.tenant:
      name = 'Tenant';
    case UserRole.flatOwner:
      name = 'Flat Owner';
    case UserRole.corporate:
      name = 'Corporate office tenant';
  }
  return name;
}

UserRole getRoleFromName(String name) {
  UserRole role = UserRole.plotOwner;
  switch(name) {
    case 'Plot Owner':
      role = UserRole.plotOwner;
    case 'Tenant':
      role = UserRole.tenant;
    case 'Flat Owner':
      role = UserRole.flatOwner;
    case 'Corporate office tenant':
      role = UserRole.corporate;
  }
  return role;
}

class AppConstants {
  static const String takaSign = '৳';
  static const int maxLengthOfPhoneNo = 11;
  static const int otpLength = 6;
  static const int otpResendWaitTime = 1 * 5;
  static RegExp bdPhoneNoValidationRegex = RegExp(r'^01[3-9]\d{8}$');
  static RegExp emailValidationRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
}