part of 'personal_data_bloc.dart';

@immutable
abstract class PersonalDataEvent {}

class ButtonPressed extends PersonalDataEvent {}

class PersonalInit extends PersonalDataEvent {}

class ClearError extends PersonalDataEvent {}

class UpdateName extends PersonalDataEvent {
  final String name;

  UpdateName({required this.name});
}

class UpdatePhone extends PersonalDataEvent {
  final String phone;

  UpdatePhone({required this.phone});
}

class UpdateEmail extends PersonalDataEvent {
  final String email;

  UpdateEmail({required this.email});
}

class UpdatePassword extends PersonalDataEvent {
  final String password;

  UpdatePassword({required this.password});
}

class UpdateReenteredPassword extends PersonalDataEvent {
  final String reenteredPassword;

  UpdateReenteredPassword({required this.reenteredPassword});
}
