import 'package:chat_app/src/core/types/json.dart';

class User {
  final String id;
  final String name;
  final String? avatar;
  const User({required this.id, required this.name, this.avatar});

  factory User.fromJson(Json json) => switch (json) {
    {'id': String id, 'name': String name, 'avatar': String? avatar} => User(
      id: id,
      name: name,
      avatar: avatar,
    ),
    _ => throw FormatException('Invalid User JSON format'),
  };

  Json toJson() => {'id': id, 'name': name, 'avatar': avatar};
}
