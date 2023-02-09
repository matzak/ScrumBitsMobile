import 'package:equatable/equatable.dart';

class NavigationState extends Equatable {
  final bool welcomeScreenVisisted;
  final bool showMainScreen;

  const NavigationState(
      {required this.welcomeScreenVisisted, required this.showMainScreen});

  @override
  List<Object?> get props => [welcomeScreenVisisted, showMainScreen];

  NavigationState copyState(
      {bool? welcomeScreenVisisted, bool? showMainScreen}) {
    return NavigationState(
        welcomeScreenVisisted:
            welcomeScreenVisisted ?? this.welcomeScreenVisisted,
        showMainScreen: showMainScreen ?? this.showMainScreen);
  }
}
