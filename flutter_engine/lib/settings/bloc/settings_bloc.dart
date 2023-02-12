import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter_engine/repository/global_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<UpdatePasswordPressed>((event, emit) async {
      bool passwordChanged = false;
      try {
        passwordChanged = await GlobalRepository.cognitoUser!.changePassword(
          state.currentPassword!,
          state.newPassword!,
        );

        if (passwordChanged) {
          emit(state.copyState(messageString: 'Password updated'));
          print('PASSWORD CHANGED!');
        }
      } catch (e) {
        print(e);
      }
    });

    on<UpdatePhonePressed>((event, emit) async {
      final List<CognitoUserAttribute> attributes = [];
      attributes
          .add(CognitoUserAttribute(name: 'phone_number', value: state.phone));

      try {
        await GlobalRepository.cognitoUser!.updateAttributes(attributes);
        emit(state.copyState(messageString: 'Phone number updated'));
        print('PHONE UPDATED');
      } catch (e) {
        print(e);
      }
    });

    on<DeleteAccountPressed>((event, emit) async {
      bool userDeleted = false;
      try {
        userDeleted = await GlobalRepository.cognitoUser!.deleteUser();
        emit(state.copyState(accountRemoved: true));
      } catch (e) {
        print(e);
      }
      print(userDeleted);
    });

    on<SettingsInit>((event, emit) async {
      emit(const SettingsState(accountRemoved: false));
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
  }
}
