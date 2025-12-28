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

  User copyWith({String? id, String? name, String? avatar, String? email}) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      email: email ?? this.email,
    );
  }
}
