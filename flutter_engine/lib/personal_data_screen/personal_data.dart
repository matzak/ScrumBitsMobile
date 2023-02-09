import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_engine/navigation/navigation_cubit.dart';
import 'package:flutter_engine/personal_data_screen/bloc/personal_data_bloc.dart';
import 'package:flutter_engine/repository/hive_counter.dart';
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

    TextEditingController controller = TextEditingController();
    return BlocBuilder<PersonalDataBloc, PersonalDataState>(
        builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.red.shade700,
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(title),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: BlocBuilder<PersonalDataBloc, PersonalDataState>(
          builder: (BuildContext context, PersonalDataState state) {
            if (state.activeAccount == true) {
              BlocProvider.of<NavigationCubit>(context).showMainScreen();
            }
            return Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  // Column is also a layout widget. It takes a list of children and
                  // arranges them vertically. By default, it sizes itself to fit its
                  // children horizontally, and tries to be as tall as its parent.
                  //
                  // Invoke "debug painting" (press "p" in the console, choose the
                  // "Toggle Debug Paint" action from the Flutter Inspector in Android
                  // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                  // to see the wireframe for each widget.
                  //
                  // Column has various properties to control how it sizes itself and
                  // how it positions its children. Here we use mainAxisAlignment to
                  // center the children vertically; the main axis here is the vertical
                  // axis because Columns are vertical (the cross axis would be
                  // horizontal).
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      decoration: const InputDecoration(
                          labelText: 'Please enter your namer',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.red),
                          filled: true,
                          fillColor: Colors.white),
                      onChanged: (String name) {
                        context
                            .read<PersonalDataBloc>()
                            .add(UpdateName(name: name));
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // InternationalPhoneNumberInput(
                    //   onInputChanged: (PhoneNumber number) {
                    //     print(number.phoneNumber);
                    //   },
                    //   onInputValidated: (bool value) {
                    //     print(value);
                    //   },
                    //   selectorConfig: SelectorConfig(
                    //     selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    //   ),
                    //   ignoreBlank: false,
                    //   autoValidateMode: AutovalidateMode.disabled,
                    //   selectorTextStyle: TextStyle(color: Colors.black),
                    //   //initialValue: number,
                    //   textFieldController: controller,
                    //   formatInput: true,
                    //   keyboardType: TextInputType.numberWithOptions(
                    //       signed: true, decimal: true),
                    //   inputBorder: OutlineInputBorder(),
                    //   onSaved: (PhoneNumber number) {
                    //     print('On Saved: $number');
                    //   },
                    // ),

                    // TextField(
                    //   decoration: const InputDecoration(
                    //       labelText: 'Please enter your phone number',
                    //       border: InputBorder.none,
                    //       hintStyle: TextStyle(color: Colors.red),
                    //       filled: true,
                    //       fillColor: Colors.white),
                    //   onChanged: (String phone) {
                    //     context
                    //         .read<PersonalDataBloc>()
                    //         .add(UpdatePhone(phone: phone));
                    //   },
                    //   keyboardType: TextInputType.phone,
                    // ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Please enter your E-mail',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.red),
                          filled: true,
                          fillColor: Colors.white),
                      onChanged: (String technologies) {
                        context.read<PersonalDataBloc>().add(
                            UpdateTechnologies(technologies: technologies));
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Please enter your password',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.red),
                          filled: true,
                          fillColor: Colors.white),
                      onChanged: (String experience) {
                        context.read<PersonalDataBloc>().add(UpdateExperience(
                            experience: int.parse(experience)));
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Please re-enter your password',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.red),
                          filled: true,
                          fillColor: Colors.white),
                      onChanged: (String experience) {
                        context.read<PersonalDataBloc>().add(UpdateExperience(
                            experience: int.parse(experience)));
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextButton(
                        style: TextButton.styleFrom(primary: Colors.white),
                        onPressed: () => context
                            .read<PersonalDataBloc>()
                            .add(ButtonPressed()),
                        child: const Text(
                          'Submit',
                          style: TextStyle(fontSize: 20),
                        )),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
