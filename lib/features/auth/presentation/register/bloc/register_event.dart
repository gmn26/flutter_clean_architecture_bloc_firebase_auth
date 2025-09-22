abstract class RegisterEvent {}

class EmailChanged extends RegisterEvent {
  final String value;
  EmailChanged(this.value);
}

class PasswordChanged extends RegisterEvent {
  final String value;
  PasswordChanged(this.value);
}

class RegisterSubmitted extends RegisterEvent {}