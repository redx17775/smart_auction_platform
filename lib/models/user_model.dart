class UserModel {
  final String id;
  final String email;
  final String password;
  final String? name;
  final String? phoneNumber;

  UserModel({
    required this.id,
    required this.email,
    required this.password,
    this.name,
    this.phoneNumber,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toString() ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      name: map['name'],
      phoneNumber: map['phoneNumber'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'phoneNumber': phoneNumber,
    };
  }
}
