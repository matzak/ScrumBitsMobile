part of 'personal_data_bloc.dart';

@immutable
class PersonalDataState extends Equatable {
  final String? name;
  final String? phone;
  final String? email;
  final String? password;
  final String? reenteredPassword;

  final bool? proceedToMainScreen;

  const PersonalDataState(
      {this.name,
      this.phone,
      this.email,
      this.password,
      this.reenteredPassword,
      this.proceedToMainScreen});

  @override
  List<Object?> get props =>
      [name, phone, email, password, reenteredPassword, proceedToMainScreen];

  PersonalDataState copyState(
      {String? name,
      String? phone,
      String? email,
      String? password,
      String? reenteredPassword,
      bool? proceedToMainScreen}) {
    return PersonalDataState(
        name: name ?? this.name,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        password: password ?? this.password,
        reenteredPassword: reenteredPassword ?? this.reenteredPassword,
        proceedToMainScreen: proceedToMainScreen ?? this.proceedToMainScreen);
  }
}
