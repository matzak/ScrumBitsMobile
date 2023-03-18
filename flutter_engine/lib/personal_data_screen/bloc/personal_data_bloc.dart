import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter_engine/repository/global_repository.dart';
import 'package:libphonenumber/libphonenumber.dart';

part 'personal_data_event.dart';
part 'personal_data_state.dart';

class PersonalDataBloc extends Bloc<PersonalDataEvent, PersonalDataState> {
  PersonalDataBloc() : super(const PersonalDataState()) {
    on<ButtonPressed>((event, emit) async {
      final bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(state.email ?? '');

      if ((state.name ?? '').isEmpty) {
        emit(state.copyState(
            proceedToMainScreen: false,
            errorString: 'Please enter your name.'));
        return;
      }

      bool? isPhoneValid = await PhoneNumberUtil.isValidPhoneNumber(
          phoneNumber: state.phone ?? '', isoCode: 'US');

      if (isPhoneValid == false) {
        emit(state.copyState(
            proceedToMainScreen: false,
            errorString:
                'Invalid phone number. Please make sure that there is country code at the beggining.'));
        return;
      }

      if (emailValid == false) {
        emit(state.copyState(
            proceedToMainScreen: false, errorString: 'Invalid email address.'));
        return;
      }

      if (state.password != state.reenteredPassword) {
        emit(state.copyState(
            proceedToMainScreen: false, errorString: 'Password mismatch.'));
        return;
      }

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
        try {
          String message = (e as dynamic).message;
          emit(state.copyState(
              proceedToMainScreen: false, errorString: message));
        } catch (exception) {
          emit(state.copyState(
              proceedToMainScreen: false,
              errorString: 'Unknown error $exception'));
        }
      }
    });

    on<ClearError>((event, emit) async {
      emit(state.copyState(errorString: null));
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
      emit(state.copyState(reenteredPassword: event.reenteredPassword));
    });
  }
}
