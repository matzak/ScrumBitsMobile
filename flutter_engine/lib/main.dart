import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_engine/UI/SBColors.dart';
import 'package:flutter_engine/navigation/app_navigator.dart';
import 'package:flutter_engine/welcome_screen/bloc/welcome_bloc.dart';
import 'package:flutter_engine/personal_data_screen/bloc/personal_data_bloc.dart';
import 'confirm_account/bloc/confirm_account_bloc.dart';
import 'login/bloc/login_bloc.dart';
import 'main_screen/bloc/main_bloc.dart';
import 'navigation/navigation_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => NavigationCubit()),
      BlocProvider(
        lazy: false,
        create: (BuildContext context) {
          return WelcomeBloc()..add(WelcomeInit());
        },
        child: const MyApp(),
      ),
      BlocProvider(
        lazy: false,
        create: (BuildContext context) {
          return PersonalDataBloc()..add(PersonalInit());
        },
        child: const MyApp(),
      ),
      BlocProvider(
        lazy: false,
        create: (BuildContext context) {
          return ConfirmAccountBloc()..add(ConfirmAccountInit());
        },
        child: const MyApp(),
      ),
      BlocProvider(
        lazy: false,
        create: (BuildContext context) {
          return MainBloc()..add(MainInit());
        },
        child: const MyApp(),
      ),
      BlocProvider(
        lazy: false,
        create: (BuildContext context) {
          return LoginBloc()..add(LoginInit());
        },
        child: const MyApp(),
      ),
    ],
    child: BlocProvider(
      lazy: false,
      create: (BuildContext context) {
        return WelcomeBloc()..add(WelcomeInit());
      },
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scrumbits',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: SBColors.sbRed,
      ),
      home: AppNavigator(),
    );
  }
}
