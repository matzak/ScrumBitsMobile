import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_engine/UI/sbinput.dart';
import 'package:flutter_engine/UI/sbpopup.dart';
import 'package:flutter_engine/login/bloc/login_bloc.dart';
import 'package:flutter_engine/navigation/navigation_cubit.dart';
import 'package:flutter_engine/repository/global_repository.dart';
import 'package:flutter_engine/settings/bloc/settings_bloc.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
        ),
        body: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (BuildContext context, SettingsState state) {
            if (state.accountRemoved == true) {
              BlocProvider.of<NavigationCubit>(context).logout();
            }
            if (state.messageString != null) {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                sbDisplayDialog(context,
                    title: 'Settings',
                    message: state.messageString,
                    option1Text: 'OK', option1Action: () {
                  context.read<SettingsBloc>().add(DialogOKPressed());
                });
              });
            } else if (state.deleteAccountDialog == true) {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                sbDisplayDialog(context,
                    title: 'Delete account',
                    message:
                        'Are you sure that you want to delete scrumbits account?',
                    option1Text: 'Yes',
                    option1Action: () {
                      context
                          .read<SettingsBloc>()
                          .add(DeleteAccountConfirmed());
                    },
                    option2Text: 'Cancel',
                    option2Action: () {
                      context.read<SettingsBloc>().add(DialogOKPressed());
                    });
              });
            }
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: SingleChildScrollView(
                    child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    sbInput(context,
                        description: 'Current password:',
                        hint: 'S3cur3Me!',
                        password: true,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (String password) {
                      context
                          .read<SettingsBloc>()
                          .add(UpdateCurrentPassword(password: password));
                    }),
                    sbInput(context,
                        description: 'New password:',
                        hint: 'S3cur3Me!',
                        password: true,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (String password) {
                      context
                          .read<SettingsBloc>()
                          .add(UpdateNewPassword(password: password));
                    }),
                    sbInput(context,
                        description: 'Re-enter new password:',
                        hint: 'S3cur3Me!',
                        password: true,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (String password) {
                      context
                          .read<SettingsBloc>()
                          .add(UpdateReenteredPassword(password: password));
                    }),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 180,
                      child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.red.shade700,
                          ),
                          onPressed: () => context
                              .read<SettingsBloc>()
                              .add(UpdatePasswordPressed()),
                          child: const Text(
                            'Change password',
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    sbInput(
                      context,
                      description: 'Phone number:',
                      hint: '+01 123123123',
                      keyboardType: TextInputType.phone,
                      onChanged: (String phone) {
                        context
                            .read<SettingsBloc>()
                            .add(UpdatePhone(phone: phone));
                      },
                      initalText: state.phone,
                    ),
                    SizedBox(
                      width: 180,
                      child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.red.shade700,
                          ),
                          onPressed: () => context
                              .read<SettingsBloc>()
                              .add(UpdatePhonePressed()),
                          child: const Text(
                            'Change number',
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          text:
                              'If you want to delete your scurmbits account please '),
                      TextSpan(
                          style: TextStyle(
                            color: Colors.red.shade700,
                            fontSize: 12,
                          ),
                          text: 'tap here.',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context
                                  .read<SettingsBloc>()
                                  .add(DeleteAccountPressed());
                            })
                    ])),
                  ],
                )),
              ),
            );
          },
        ),
      );
    });
  }
}
