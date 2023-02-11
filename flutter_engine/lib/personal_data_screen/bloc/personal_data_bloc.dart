import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter_engine/repository/global_repository.dart';

part 'personal_data_event.dart';
part 'personal_data_state.dart';

class PersonalDataBloc extends Bloc<PersonalDataEvent, PersonalDataState> {
  PersonalDataBloc() : super(const PersonalDataState()) {
    on<ButtonPressed>((event, emit) async {
      final userAttributes = [
        AttributeArg(name: 'name', value: state.name),
        AttributeArg(name: 'phone_number', value: state.phone),
        AttributeArg(name: 'email', value: state.email),
      ];

      try {
        await GlobalRepository.userPool.signUp(
          state.email!,
          state.password!,
          userAttributes: userAttributes,
        );

        GlobalRepository.cognitoUser =
            CognitoUser(state.email, GlobalRepository.userPool);

        emit(state.copyState(proceedToMainScreen: true));
      } catch (e) {
        print("KURWA $e");
        emit(state.copyState(proceedToMainScreen: false));
      }
    });

    on<PersonalInit>((event, emit) async {
      emit(const PersonalDataState());
    });

    on<UpdateName>((event, emit) async {
      emit(state.copyState(name: event.name));
    });

    on<UpdatePhone>((event, emit) async {
      emit(state.copyState(phone: event.phone));
    });

    on<UpdateEmail>((event, emit) async {
      emit(state.copyState(email: event.email));
    });

    on<UpdatePassword>((event, emit) async {
      emit(state.copyState(password: event.password));
    });

    on<UpdateReenteredPassword>((event, emit) async {
      emit(state.copyState(password: event.reenteredPassword));
    });
  }
}
