import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter_engine/repository/global_repository.dart';
import 'package:libphonenumber/libphonenumber.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<UpdatePasswordPressed>((event, emit) async {
      bool passwordChanged = false;
      emit(state.copyState(processing: true));
      try {
        passwordChanged = await GlobalRepository.cognitoUser!.changePassword(
          state.currentPassword!,
          state.newPassword!,
        );

        if (passwordChanged) {
          emit(state.copyState(
              messageString: 'Password updated', processing: false));
          print('PASSWORD CHANGED!');
        }
      } catch (e) {
        emit(state.copyState(
            messageString: "Password change failed!", processing: false));
      }
    });

    on<UpdatePhonePressed>((event, emit) async {
      bool? isPhoneValid = await PhoneNumberUtil.isValidPhoneNumber(
          phoneNumber: state.phone ?? '', isoCode: 'US');

      if (isPhoneValid == false) {
        emit(state.copyState(
            messageString:
                'Invalid phone number. Please make sure that there is country code at the beggining.'));
        return;
      }

      emit(state.copyState(processing: true));

      final List<CognitoUserAttribute> attributes = [];
      attributes
          .add(CognitoUserAttribute(name: 'phone_number', value: state.phone));

      try {
        await GlobalRepository.cognitoUser!.updateAttributes(attributes);
        emit(state.copyState(
            messageString: 'Phone number updated', processing: false));
        GlobalRepository.setPhoneNumber(state.phone);
        print('PHONE UPDATED');
      } catch (e) {
        emit(state.copyState(processing: false));
        print(e);
      }
    });

    on<DeleteAccountConfirmed>((event, emit) async {
      emit(state.copyState(processing: true));
      bool userDeleted = false;
      try {
        userDeleted = await GlobalRepository.cognitoUser!.deleteUser();
        emit(state.copyState(accountRemoved: true, processing: false));
      } catch (e) {
        emit(state.copyState(processing: false));
        print(e);
      }
      print(userDeleted);
    });

    on<DeleteAccountPressed>((event, emit) async {
      emit(state.copyState(deleteAccountDialog: true));
    });

    on<SettingsInit>((event, emit) async {
      emit(SettingsState(
          accountRemoved: false, phone: GlobalRepository.getPhoneNumber()));
    });

    on<UpdateCurrentPassword>((event, emit) async {
      emit(state.copyState(currentPassword: event.password));
    });

    on<UpdateNewPassword>((event, emit) async {
      emit(state.copyState(newPassword: event.password));
    });

    on<UpdateReenteredPassword>((event, emit) async {
      emit(state.copyState(reenteredPassword: event.password));
    });

    on<UpdatePhone>((event, emit) async {
      emit(state.copyState(phone: event.phone));
    });

    on<DialogOKPressed>((event, emit) async {
      emit(state.copyState(messageString: null));
    });
  }
}
