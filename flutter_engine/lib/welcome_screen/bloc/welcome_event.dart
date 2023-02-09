part of 'welcome_bloc.dart';

@immutable
abstract class WelcomeEvent {}

class ButtonPressed extends WelcomeEvent {}

class WelcomeInit extends WelcomeEvent {}
