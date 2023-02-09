import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState()) {
    // on<ButtonPressed>((event, emit) async {

    // });

    on<MainInit>((event, emit) async {
      //final counter = await repository.loadCounter();
      emit(state.copyState());
    });
  }
}
