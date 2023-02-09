part of 'counter_bloc.dart';

@immutable
abstract class CounterEvent {}

class ButtonPressed extends CounterEvent {}

class InitBloc extends CounterEvent {}
