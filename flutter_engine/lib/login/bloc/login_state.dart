part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {
  final String? email;
  final String? password;

  final bool? activeAccount;
  final bool? activated;
  final String? errorString;

  const LoginState(
      {this.email,
      this.password,
      this.activeAccount,
      this.activated,
      this.errorString});

  @override
  List<Object?> get props =>
      [email, password, activeAccount, activated, errorString];

  LoginState copyState(
      {String? email,
      String? password,
      bool? activeAccount,
      bool? activated,
      String? errorString}) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      activeAccount: activeAccount ?? this.activeAccount,
      activated: activated ?? this.activated,
      errorString: errorString,
    );
  }
}
