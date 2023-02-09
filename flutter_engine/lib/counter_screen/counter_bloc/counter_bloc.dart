import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_engine/repository/hive_repository.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  final repository = HiveRepository();

  CounterBloc() : super(CounterState(counter: 0)) {
    on<ButtonPressed>((event, emit) async {
      final int newValue = state.counter + 1;
      await repository.saveCounter(newValue);
      emit(state.copyState(newValue));
    });

    on<InitBloc>((event, emit) async {
      final counter = await repository.loadCounter();
      emit(state.copyState(counter));
    });
  }
}
