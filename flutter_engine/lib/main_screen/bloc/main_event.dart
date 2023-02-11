part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class MainInit extends MainEvent {
  final bool? activated;

  MainInit({this.activated});
}

class ScrumbitsPressed extends MainEvent {}
