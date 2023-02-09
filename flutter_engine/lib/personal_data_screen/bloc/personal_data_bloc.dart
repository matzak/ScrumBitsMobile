import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';

part 'personal_data_event.dart';
part 'personal_data_state.dart';

final userPool =
    CognitoUserPool('us-east-1_DmkrZk78n', '1btgkkbip3fdjm47kdapngvl68');

class PersonalDataBloc extends Bloc<PersonalDataEvent, PersonalDataState> {
  PersonalDataBloc() : super(PersonalDataState()) {
    on<ButtonPressed>((event, emit) async {
      final userAttributes = [
        AttributeArg(name: 'given_name', value: state.name),
        AttributeArg(name: 'phone_number', value: state.phone),
      ];

      // try {
      //   await userPool.signUp(
      //     state.phone!,
      //     state.email!,
      //     userAttributes: userAttributes,
      //   );

      //   emit(state.copyState(activeAccount: true));
      // } catch (e) {
      //   print("KURWA $e");
      //   emit(state.copyState(activeAccount: false));
      // }

      emit(state.copyState(activeAccount: true));
    });

    on<InitBloc>((event, emit) async {
      emit(state);
    });

    on<UpdateName>((event, emit) async {
      emit(state.copyState(name: event.name));
    });

    on<UpdatePhone>((event, emit) async {
      emit(state.copyState(phone: event.phone));
    });

    on<UpdateTechnologies>((event, emit) async {
      emit(state.copyState(email: event.technologies));
    });

    on<UpdateExperience>((event, emit) async {
      emit(state.copyState(experience: event.experience));
    });
  }
}
