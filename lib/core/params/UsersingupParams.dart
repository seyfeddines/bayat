

class UsersignupParams {
  final String email;
  final String code;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String password;

  UsersignupParams({
    required this.email,
    required this.code,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.password,
  });


}


class EmailOtpParams{
  final String email;
  EmailOtpParams({required this.email});
}

class UserLoginParams{
  final String email;
  final String password;
  UserLoginParams({required this.email,required this.password});
}