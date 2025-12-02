import 'package:chat_app/src/core/utils/json.type.dart';

class User {
  final String id;
  final String name;
  final String? avatar;
  final String email;

  const User({
    required this.id,
    required this.name,
    this.avatar,
    required this.email,
  });

  factory User.fromJson(Json json) => switch (json) {
    {
      'id': String id,
      'name': String name,
      'avatar': String? avatar,
      'email': String email,
    } =>
      User(id: id, name: name, avatar: avatar, email: email),
    _ => throw FormatException('Invalid User JSON format'),
  };

  Json toJson() => {'id': id, 'name': name, 'avatar': avatar, 'email': email};
}
