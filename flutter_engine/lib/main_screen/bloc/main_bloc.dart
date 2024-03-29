import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_engine/repository/global_repository.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainState()) {
    on<ScrumbitsPressed>((event, emit) async {
      bool newState = !state.scrumbitsActivated;
      final List<CognitoUserAttribute> attributes = [];
      attributes.add(CognitoUserAttribute(
          name: 'nickname', value: newState ? 'ACTIVATED' : ''));

      try {
        await GlobalRepository.cognitoUser!.updateAttributes(attributes);
        emit(state.copyState(scrumbitsActivated: newState, processing: false));
      } catch (e) {
        emit(state.copyState(processing: false));
        print(e);
      }
    });

    on<MainInit>((event, emit) async {
      emit(state.copyState(scrumbitsActivated: event.activated));
    });

    on<ShowProcessing>((event, emit) async {
      emit(state.copyState(processing: true));
    });
  }
}
