part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class UpdatePasswordPressed extends SettingsEvent {}

class UpdatePhonePressed extends SettingsEvent {}

class RemovePopup extends SettingsEvent {}

class DeleteAccountPressed extends SettingsEvent {}

class SettingsInit extends SettingsEvent {}

class UpdateCurrentPassword extends SettingsEvent {
  final String password;

  UpdateCurrentPassword({required this.password});
}

class UpdateNewPassword extends SettingsEvent {
  final String password;

  UpdateNewPassword({required this.password});
}

class UpdateReenteredPassword extends SettingsEvent {
  final String password;

  UpdateReenteredPassword({required this.password});
}

class UpdatePhone extends SettingsEvent {
  final String phone;

  UpdatePhone({required this.phone});
}
