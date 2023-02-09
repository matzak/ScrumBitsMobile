import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_engine/navigation/app_navigator.dart';
import 'package:flutter_engine/repository/hive_counter.dart';
import 'package:flutter_engine/welcome_screen/bloc/welcome_bloc.dart';
import 'package:flutter_engine/welcome_screen/welcome.dart';
import 'package:flutter_engine/personal_data_screen/bloc/personal_data_bloc.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'main_screen/bloc/main_bloc.dart';
import 'navigation/navigation_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb == false) {
    await Hive.initFlutter();
  }

  Hive.registerAdapter(HiveCounterAdapter());

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
          return PersonalDataBloc()..add(InitBloc());
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
    final Map<int, Color> _red700Map = {
      50: Color(Colors.red.shade700.value),
      100: Colors.red[100]!,
      200: Colors.red[200]!,
      300: Colors.red[300]!,
      400: Colors.red[400]!,
      500: Colors.red[500]!,
      600: Colors.red[600]!,
      700: Colors.red[800]!,
      800: Colors.red[900]!,
      900: Colors.red[700]!,
    };

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
        primarySwatch: MaterialColor(Colors.red.shade700.value, _red700Map),
      ),
      home: AppNavigator(),
    );
  }
}
