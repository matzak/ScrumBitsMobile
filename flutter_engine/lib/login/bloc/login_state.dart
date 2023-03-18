part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {
  final String? email;
  final String? password;

  final bool? activeAccount;
  final bool? activated;
  final String? errorString;

  final bool? processing;

  const LoginState({
    this.email,
    this.password,
    this.activeAccount,
    this.activated,
    this.errorString,
    this.processing,
  });

  @override
  List<Object?> get props =>
      [email, password, activeAccount, activated, errorString, processing];

  LoginState copyState(
      {String? email,
      String? password,
      bool? activeAccount,
      bool? activated,
      String? errorString,
      bool? processing}) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      activeAccount: activeAccount ?? this.activeAccount,
      activated: activated ?? this.activated,
      errorString: errorString,
      processing: processing ?? this.processing,
    );
  }
}
