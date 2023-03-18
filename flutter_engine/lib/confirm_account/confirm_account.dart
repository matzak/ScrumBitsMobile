import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_engine/UI/sbinput.dart';

import 'package:flutter_engine/navigation/navigation_cubit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'bloc/confirm_account_bloc.dart';

class ConfirmAccount extends StatelessWidget {
  const ConfirmAccount({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfirmAccountBloc, ConfirmAccountState>(
        builder: (context, state) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(title),
            centerTitle: true,
          ),
          body: LoadingOverlay(
            child: _buildBlock(context),
            isLoading: state.processing ?? false,
          ));
    });
  }

  Widget _buildBlock(BuildContext context) {
    return BlocBuilder<ConfirmAccountBloc, ConfirmAccountState>(
      builder: (BuildContext context, ConfirmAccountState state) {
        if (state.activeAccount == true) {
          context.read<ConfirmAccountBloc>().add(ConfirmAccountInit());
          BlocProvider.of<NavigationCubit>(context).showMainScreen();
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
                    "Almost there!",
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const Text(
                  'This is the last step of registration process. Please check your your email (including SPAM folder) for a message with verification code.',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                  softWrap: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                sbInput(context,
                    description: 'Please enter your verifcation code:',
                    hint: '012345',
                    keyboardType: TextInputType.number,
                    onChanged: (String code) {
                  context
                      .read<ConfirmAccountBloc>()
                      .add(UpdateVerificationCode(code: code));
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
                      onPressed: () => context
                          .read<ConfirmAccountBloc>()
                          .add(ButtonPressed()),
                      child: const Text(
                        'Confirm',
                        style: TextStyle(fontSize: 20),
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontSize: 12,
                      ),
                      text: 'Tap here ',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context
                              .read<ConfirmAccountBloc>()
                              .add(ResendButtonPressed());
                        }),
                  const TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                      text: 'to resend your verification code.'),
                ])),
              ],
            )),
          ),
        );
      },
    );
  }
}
