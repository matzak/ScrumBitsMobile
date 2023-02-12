import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_engine/navigation/navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(showScreen: Screens.welcome));

  void showPersonalData() {
    emit(state.copyState(showScreen: Screens.signup));
  }

  void showConfirmAccount() {
    emit(state.copyState(showScreen: Screens.confirm));
  }

  void showMainScreen() {
    emit(state.copyState(showScreen: Screens.main));
  }

  void showLogin() {
    emit(state.copyState(showScreen: Screens.login));
  }

  void logout() {
    emit(state.copyState(showScreen: Screens.welcome));
  }

  void showSettings() {
    emit(state.copyState(showScreen: Screens.settings));
  }
}
