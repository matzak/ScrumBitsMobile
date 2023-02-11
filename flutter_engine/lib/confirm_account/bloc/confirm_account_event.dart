part of 'confirm_account_bloc.dart';

@immutable
abstract class ConfirmAccountEvent {}

class ButtonPressed extends ConfirmAccountEvent {}

class ResendButtonPressed extends ConfirmAccountEvent {}

class ConfirmAccountInit extends ConfirmAccountEvent {}

class UpdateVerificationCode extends ConfirmAccountEvent {
  final String code;

  UpdateVerificationCode({required this.code});
}
