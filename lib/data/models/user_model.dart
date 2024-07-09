import 'package:ecom_mvvm/domain/entities/user_entities.dart';

class UserModel extends UserEntities {
  const UserModel({
    required super.id,
    // required super.address,
    required super.email,
    required super.username,
    required super.password,
    // required super.name,
    required super.v,
  });

  Map<String, dynamic> toMap() {
    return {
      // 'address': address,
      'id': id,
      'email': email,
      'username': username,
      'password': password,
      // 'name': name,
      'v': v,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      // address: map['address'],
      id: map['id'],
      email: map['email'],
      username: map['username'],
      password: map['password'],
      // name: map['name'],
      v: map['v'],
    );
  }
}
