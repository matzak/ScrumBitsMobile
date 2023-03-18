import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter_engine/repository/global_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<PersonalDataEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<ButtonPressed>((event, emit) async {
      try {
        bool activated =
            await GlobalRepository.login(state.email, state.password);
        if (GlobalRepository.cognitoSession != null) {
          if (GlobalRepository.attributes != null) {
            GlobalRepository.attributes?.firstWhere((attribute) {
              return attribute.name == 'nickname' &&
                  attribute.value == 'ACTIVATED';
            }, orElse: () {
              activated = false;
              return CognitoUserAttribute(name: '', value: '');
            });
          }

          emit(state.copyState(activeAccount: true, activated: activated));
        }
      } catch (e) {
        try {
          emit(state.copyState(errorString: (e as dynamic).message));
        } catch (_) {
          emit(state.copyState(errorString: 'Unknown error.'));
        }
      }
    });

    on<LoginInit>((event, emit) async {
      emit(const LoginState(activeAccount: false));
    });

    on<UpdateEmail>((event, emit) async {
      emit(state.copyState(email: event.email));
    });

    on<UpdatePassword>((event, emit) async {
      emit(state.copyState(password: event.password));
    });
  }
}
