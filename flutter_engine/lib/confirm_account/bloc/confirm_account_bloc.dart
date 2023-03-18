import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_engine/repository/global_repository.dart';

part 'confirm_account_event.dart';
part 'confirm_account_state.dart';

class ConfirmAccountBloc
    extends Bloc<ConfirmAccountEvent, ConfirmAccountState> {
  ConfirmAccountBloc() : super(const ConfirmAccountState()) {
    on<ButtonPressed>((event, emit) async {
      try {
        print('JA JEBIE $GlobalRepository.cognitoUser');
        print('CODE ${state.code}');
        if (state.code != null && GlobalRepository.cognitoUser != null) {
          bool confirmed = await GlobalRepository.cognitoUser!
              .confirmRegistration(state.code ?? '');
          if (confirmed) {
            GlobalRepository.login(
                GlobalRepository.email, GlobalRepository.password);
            emit(state.copyState(activeAccount: true));
          }
        } else {
          print('BLADY CHUJ!');
        }
      } catch (e) {
        print('KURWA $e');
      }
    });

    on<ConfirmAccountInit>((event, emit) async {
      emit(const ConfirmAccountState(activeAccount: false));
    });

    on<UpdateVerificationCode>((event, emit) async {
      emit(state.copyState(code: event.code));
    });

    on<ResendButtonPressed>((event, emit) async {
      await GlobalRepository.cognitoUser!.resendConfirmationCode();
    });
  }
}
