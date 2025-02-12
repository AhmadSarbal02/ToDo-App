class UserModel {
  final int id;
  final String email;
  final String password;
  final String name;

  UserModel(
      {required this.id,
      required this.email,
      required this.password,
      required this.name});

  factory UserModel.fromJson({required Map json}) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      name: json['name'],
    );
  }
}
