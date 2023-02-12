import 'package:equatable/equatable.dart';

enum Screens { welcome, signup, confirm, login, main, settings }

class NavigationState extends Equatable {
  final Screens showScreen;

  const NavigationState({required this.showScreen});

  @override
  List<Object?> get props => [showScreen];

  NavigationState copyState({required Screens showScreen}) {
    return NavigationState(showScreen: showScreen);
  }
}
