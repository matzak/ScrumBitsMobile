import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeState()) {
    // on<ButtonPressed>((event, emit) async {

    // });

    on<WelcomeInit>((event, emit) async {
      //final counter = await repository.loadCounter();
      emit(state.copyState());
    });
  }
}
