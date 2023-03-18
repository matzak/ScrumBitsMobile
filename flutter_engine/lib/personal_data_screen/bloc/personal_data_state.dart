part of 'personal_data_bloc.dart';

@immutable
class PersonalDataState extends Equatable {
  final String? name;
  final String? phone;
  final String? email;
  final String? password;
  final String? reenteredPassword;
  final String? errorString;

  final bool? proceedToMainScreen;
  final bool? processing;

  const PersonalDataState({
    this.name,
    this.phone,
    this.email,
    this.password,
    this.reenteredPassword,
    this.proceedToMainScreen,
    this.errorString,
    this.processing,
  });

  @override
  List<Object?> get props => [
        name,
        phone,
        email,
        password,
        reenteredPassword,
        proceedToMainScreen,
        errorString,
        processing
      ];

  PersonalDataState copyState({
    String? name,
    String? phone,
    String? email,
    String? password,
    String? reenteredPassword,
    bool? proceedToMainScreen,
    String? errorString,
    bool? processing,
  }) {
    return PersonalDataState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      reenteredPassword: reenteredPassword ?? this.reenteredPassword,
      proceedToMainScreen: proceedToMainScreen ?? this.proceedToMainScreen,
      errorString: errorString,
      processing: processing ?? this.processing,
    );
  }
}
