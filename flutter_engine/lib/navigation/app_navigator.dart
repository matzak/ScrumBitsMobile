import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_engine/confirm_account/confirm_account.dart';
import 'package:flutter_engine/login/login.dart';
import 'package:flutter_engine/main_screen/main.dart';
import 'package:flutter_engine/navigation/navigation_cubit.dart';
import 'package:flutter_engine/navigation/navigation_state.dart';
import 'package:flutter_engine/personal_data_screen/personal_data.dart';
import 'package:flutter_engine/welcome_screen/welcome.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({Key? key}) : super(key: key);

  List<MaterialPage> _getPages(NavigationState state, BuildContext context) {
    switch (state.showScreen) {
      case Screens.welcome:
        return [const MaterialPage(child: Welcome(title: ''))];
      case Screens.signup:
        return [
          const MaterialPage(child: Welcome(title: '')),
          const MaterialPage(child: PersonalData(title: 'Create account'))
        ];
      case Screens.confirm:
        return [
          const MaterialPage(
              child: ConfirmAccount(
            title: 'Confirm account',
          ))
        ];
      case Screens.login:
        return [
          const MaterialPage(child: Welcome(title: '')),
          const MaterialPage(child: Login(title: 'Login'))
        ];
      case Screens.main:
        return [const MaterialPage(child: Main(title: 'scrumbits'))];
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return Navigator(
          pages: _getPages(state, context),
          onPopPage: (route, result) {
            BlocProvider.of<NavigationCubit>(context).logout();
            return route.didPop(result);
          },
        );
      },
    );
  }
}
