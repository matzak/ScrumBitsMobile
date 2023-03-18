import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_engine/UI/sbinput.dart';
import 'package:flutter_engine/UI/sbpopup.dart';
import 'package:flutter_engine/login/bloc/login_bloc.dart';
import 'package:flutter_engine/main_screen/bloc/main_bloc.dart';
import 'package:flutter_engine/navigation/navigation_cubit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatelessWidget {
  const Login({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
        ),
        body: LoadingOverlay(
          child: _buildBloc(context),
          isLoading: state.processing ?? false,
        ),
      );
    });
  }

  Widget _buildBloc(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (BuildContext context, LoginState state) {
        if (state.activeAccount == true) {
          context.read<LoginBloc>().add(LoginInit());
          if (state.activated == true) {
            BlocProvider.of<MainBloc>(context).add(MainInit(activated: true));
          }
          BlocProvider.of<NavigationCubit>(context).showMainScreen();
        }
        if (state.errorString != null) {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            sbDisplayDialog(context,
                title: 'Login error',
                message: state.errorString,
                option1Text: 'OK');
          });
        }
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Text(
                    "Welcome back!",
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const Text(
                  'Please fill the following fields to login to your account.',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                sbInput(context,
                    description: 'Please enter your e-mail address:',
                    hint: 'thomas.anderson@scrumbits.com',
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (String email) {
                  context.read<LoginBloc>().add(UpdateEmail(email: email));
                }),
                sbInput(context,
                    description: 'Please enter your password:',
                    hint: 'S3cur3Me!',
                    password: true,
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (String password) {
                  context
                      .read<LoginBloc>()
                      .add(UpdatePassword(password: password));
                }),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 100,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.red.shade700,
                      ),
                      onPressed: () =>
                          context.read<LoginBloc>().add(ButtonPressed()),
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 20),
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
                RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                      text: 'If you don\'t remeber your password please '),
                  TextSpan(
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontSize: 12,
                      ),
                      text: 'tap here ',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchUrl(
                              Uri(scheme: 'http', path: 'www.scrumbits.com'));
                        }),
                  const TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                      text: 'and check your email.'),
                ])),
              ],
            )),
          ),
        );
      },
    );
  }
}
