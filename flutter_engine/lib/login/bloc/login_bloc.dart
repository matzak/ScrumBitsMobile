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
      GlobalRepository.cognitoUser =
          CognitoUser(state.email, GlobalRepository.userPool);
      final authDetails = AuthenticationDetails(
        username: state.email,
        password: state.password,
      );

      try {
        GlobalRepository.cognitoSession =
            await GlobalRepository.cognitoUser!.authenticateUser(authDetails);
        bool activated = true;
        if (GlobalRepository.cognitoSession != null) {
          List<CognitoUserAttribute>? attributes =
              await GlobalRepository.cognitoUser!.getUserAttributes();
          if (attributes != null) {
            attributes.firstWhere((attribute) {
              return attribute.name == 'nickname' &&
                  attribute.value == 'ACTIVATED';
            }, orElse: () {
              activated = false;
              return CognitoUserAttribute(name: '', value: '');
            });
          }

          emit(state.copyState(activeAccount: true, activated: activated));
        }
      } on CognitoUserNewPasswordRequiredException catch (e) {
        print('KURWA1 $e');
      } on CognitoUserMfaRequiredException catch (e) {
        print('KURWA2 $e');
      } on CognitoUserSelectMfaTypeException catch (e) {
        print('KURWA3 $e');
      } on CognitoUserMfaSetupException catch (e) {
        print('KURWA4 $e');
      } on CognitoUserTotpRequiredException catch (e) {
        print('KURWA5 $e');
      } on CognitoUserCustomChallengeException catch (e) {
        print('KURWA6 $e');
      } on CognitoUserConfirmationNecessaryException catch (e) {
        print('KURWA7 $e');
      } on CognitoClientException catch (e) {
        print('KURWA8 $e');
      } catch (e) {
        print('KURWAXXX $e');
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
