part of 'confirm_account_bloc.dart';

@immutable
class ConfirmAccountState extends Equatable {
  final String? code;
  final bool? activeAccount;
  final bool? processing;

  const ConfirmAccountState({
    this.code,
    this.activeAccount,
    this.processing,
  });

  @override
  List<Object?> get props => [code, activeAccount, processing];

  ConfirmAccountState copyState(
      {String? code, bool? activeAccount, bool? processing}) {
    return ConfirmAccountState(
      code: code ?? this.code,
      activeAccount: activeAccount ?? this.activeAccount,
      processing: processing ?? this.processing,
    );
  }
}
