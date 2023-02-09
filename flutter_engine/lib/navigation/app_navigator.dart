import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_engine/counter_screen/counter_bloc/counter_bloc.dart';
import 'package:flutter_engine/main_screen/main.dart';
import 'package:flutter_engine/navigation/navigation_cubit.dart';
import 'package:flutter_engine/navigation/navigation_state.dart';
import 'package:flutter_engine/personal_data_screen/personal_data.dart';
import 'package:flutter_engine/welcome_screen/welcome.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            const MaterialPage(
                child: Welcome(
              title: '',
            )),
            if (state.welcomeScreenVisisted)
              const MaterialPage(child: PersonalData(title: 'Your profile')),
            if (state.showMainScreen)
              const MaterialPage(child: Main(title: 'Scrumbits'))
          ],
          onPopPage: (route, result) {
            BlocProvider.of<NavigationCubit>(context).popToWelcome();
            return route.didPop(result);
          },
        );
      },
    );
  }
}
