import 'package:chat_app/src/core/utils/type.dart';
import 'package:chat_app/src/shared/domain/entities/user.entity.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    super.avatar,
    required super.email,
  });

  static UserModel fromEntity(User user) => UserModel(
    id: user.id,
    name: user.name,
    avatar: user.avatar,
    email: user.email,
  );

  static List<UserModel> fromEntityList(Iterable<User> users) =>
      users.map(UserModel.fromEntity).toList();

  User toEntity() => User(id: id, name: name, avatar: avatar, email: email);

  factory UserModel.fromJson(Json json) => switch (json) {
    {
      'id': String id,
      'name': String name,
      'avatar': String? avatar,
      'email': String email,
    } =>
      UserModel(id: id, name: name, avatar: avatar, email: email),
    _ => throw FormatException('Invalid User JSON format'),
  };

  Json toJson() => {'id': id, 'name': name, 'avatar': avatar, 'email': email};

  static List<UserModel> fromJsonList(JsonList jsonList) =>
      jsonList.map((json) => UserModel.fromJson(json)).toList();

  static List<User> toEntityList(Iterable<UserModel> models) =>
      models.map((model) => model.toEntity()).toList();
}
