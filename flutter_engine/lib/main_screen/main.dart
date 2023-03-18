import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_engine/main_screen/bloc/main_bloc.dart';
import 'package:flutter_engine/main_screen/drawer.dart';
import 'package:flutter_engine/navigation/navigation_cubit.dart';
import 'package:flutter_engine/navigation/navigation_state.dart';
import 'package:flutter_engine/welcome_screen/bloc/welcome_bloc.dart';
import 'package:flutter_svg/svg.dart';

class Main extends StatelessWidget {
  const Main({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WelcomeBloc, WelcomeState>(builder: (context, state) {
      return Scaffold(
        drawer: mainDrawer(context),
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('scrumbits'),
          centerTitle: true,
        ),
        body: BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Looking for new challanges in IT industry?',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        Text('Press '),
                        Text(
                          'BIG RED BUTTON',
                          style: TextStyle(
                              color: Colors.red.shade700,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: const [
                        Text('below to '),
                        Text(
                          'ACTIVATE',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(' scrumbits'),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 250,
                    width: 250,
                    child: FloatingActionButton.extended(
                      icon: SvgPicture.asset(
                        'lib/assets/logo_notext.svg',
                        height: 150,
                        color: state.scrumbitsActivated
                            ? Colors.black
                            : Colors.white,
                      ),
                      onPressed: () {
                        context.read<MainBloc>().add(ScrumbitsPressed());
                      },
                      label: const Text(
                        '',
                      ),
                      backgroundColor: Colors.red.shade700,
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      state.scrumbitsActivated
                          ? 'Current status: ACTIVATED'
                          : 'Current status: NOT ACTIVE',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(state.scrumbitsActivated
                      ? 'We will contact you soon!'
                      : ''),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
