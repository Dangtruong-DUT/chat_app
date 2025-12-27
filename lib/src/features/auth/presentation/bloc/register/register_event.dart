sealed class RegisterEvent {
  const RegisterEvent();
}

class RegisterSubmitted extends RegisterEvent {
  final String email;
  final String name;
  final String password;

  const RegisterSubmitted({
    required this.email,
    required this.name,
    required this.password,
  });
}
