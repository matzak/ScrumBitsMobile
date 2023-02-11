part of 'login_bloc.dart';

@immutable
abstract class PersonalDataEvent {}

class ButtonPressed extends PersonalDataEvent {}

class LoginInit extends PersonalDataEvent {}

class UpdateEmail extends PersonalDataEvent {
  final String email;

  UpdateEmail({required this.email});
}

class UpdatePassword extends PersonalDataEvent {
  final String password;

  UpdatePassword({required this.password});
}
