import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_engine/UI/sbinput.dart';
import 'package:flutter_engine/UI/sbpopup.dart';
import 'package:flutter_engine/navigation/navigation_cubit.dart';
import 'package:flutter_engine/personal_data_screen/bloc/personal_data_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

class PersonalData extends StatelessWidget {
  const PersonalData({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalDataBloc, PersonalDataState>(
        builder: (context, state) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(title),
            centerTitle: true,
          ),
          body: LoadingOverlay(
            child: _buildBloc(context),
            isLoading: state.processing ?? false,
          ));
    });
  }

  Widget _buildBloc(BuildContext context) {
    return BlocBuilder<PersonalDataBloc, PersonalDataState>(
      builder: (BuildContext context, PersonalDataState state) {
        if (state.proceedToMainScreen == true) {
          BlocProvider.of<PersonalDataBloc>(context).add(PersonalInit());
          BlocProvider.of<NavigationCubit>(context).showConfirmAccount();
        }
        if (state.errorString != null) {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            sbDisplayDialog(context,
                title: 'Login error',
                message: state.errorString,
                option1Text: 'OK', option1Action: () {
              context.read<PersonalDataBloc>().add(ClearError());
            });
          });
        }
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                    child: Text(
                      "Welcome to scrumbits!",
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          text:
                              'Please fill the following fields to register new account. Scrumbits will never send you any spam. By creating an account you are accepting our '),
                      TextSpan(
                          style: TextStyle(
                            color: Colors.red.shade700,
                            fontSize: 12,
                          ),
                          text: 'privacy policy.',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launchUrl(Uri(
                                  scheme: 'http', path: 'www.scrumbits.com'));
                            })
                    ])),
                  ),
                  sbInput(context,
                      description: 'Please enter your name:',
                      hint: 'Thomas Anderson', onChanged: (String name) {
                    context
                        .read<PersonalDataBloc>()
                        .add(UpdateName(name: name));
                  }),
                  sbInput(context,
                      description: 'Please enter your phone number:',
                      hint: '+01 123123123',
                      keyboardType: TextInputType.phone,
                      onChanged: (String phone) {
                    context
                        .read<PersonalDataBloc>()
                        .add(UpdatePhone(phone: phone));
                  }),
                  sbInput(context,
                      description: 'Please enter your e-mail address:',
                      hint: 'thomas.anderson@scrumbits.com',
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (String email) {
                    context
                        .read<PersonalDataBloc>()
                        .add(UpdateEmail(email: email));
                  }),
                  sbInput(context,
                      description: 'Please enter your password:',
                      hint: 'S3cur3Me!',
                      password: true,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (String password) {
                    context
                        .read<PersonalDataBloc>()
                        .add(UpdatePassword(password: password));
                  }),
                  sbInput(context,
                      description: 'Please re-enter your password:',
                      hint: 'S3cur3Me!',
                      password: true,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (String password) {
                    context.read<PersonalDataBloc>().add(
                        UpdateReenteredPassword(reenteredPassword: password));
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 100,
                    child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.red.shade700,
                        ),
                        onPressed: () => context
                            .read<PersonalDataBloc>()
                            .add(ButtonPressed()),
                        child: const Text(
                          'Submit',
                          style: TextStyle(fontSize: 20),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void logout() {}
}
