class User {
  final String username;
  final String password;
  final String phone;
  final String email;
  final String? address;
  final String accountType;

  User({
    required this.username,
    required this.password,
    required this.phone,
    required this.email,
    this.address,
    required this.accountType,
  });
}

List<User> users = [];
