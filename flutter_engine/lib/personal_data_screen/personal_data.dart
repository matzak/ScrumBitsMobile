import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_engine/UI/sbinput.dart';
import 'package:flutter_engine/navigation/navigation_cubit.dart';
import 'package:flutter_engine/personal_data_screen/bloc/personal_data_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

//import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PersonalData extends StatelessWidget {
  const PersonalData({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  //Phone

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return BlocBuilder<PersonalDataBloc, PersonalDataState>(
        builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(title),
          centerTitle: true,
        ),
        body: BlocBuilder<PersonalDataBloc, PersonalDataState>(
          builder: (BuildContext context, PersonalDataState state) {
            if (state.proceedToMainScreen == true) {
              BlocProvider.of<PersonalDataBloc>(context).add(PersonalInit());
              BlocProvider.of<NavigationCubit>(context).showConfirmAccount();
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
                                      scheme: 'http',
                                      path: 'www.scrumbits.com'));
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
                            UpdateReenteredPassword(
                                reenteredPassword: password));
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
        ),
      );
    });
  }

  void logout() {}
}
