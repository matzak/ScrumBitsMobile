part of 'confirm_account_bloc.dart';

@immutable
class ConfirmAccountState extends Equatable {
  final String? code;

  final bool? activeAccount;

  const ConfirmAccountState({this.code, this.activeAccount});

  @override
  List<Object?> get props => [code, activeAccount];

  ConfirmAccountState copyState({String? code, bool? activeAccount}) {
    return ConfirmAccountState(
        code: code ?? this.code,
        activeAccount: activeAccount ?? this.activeAccount);
  }
}
