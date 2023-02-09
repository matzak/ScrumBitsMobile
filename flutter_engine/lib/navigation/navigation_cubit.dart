import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_engine/navigation/navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit()
      : super(const NavigationState(
            welcomeScreenVisisted: false, showMainScreen: false));

  void showPersonalData() {
    emit(state.copyState(welcomeScreenVisisted: true));
  }

  void showMainScreen() {
    emit(state.copyState(showMainScreen: true));
  }

  void popToWelcome() {
    emit(state.copyState(welcomeScreenVisisted: false));
  }
}
