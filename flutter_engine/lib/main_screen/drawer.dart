import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_engine/navigation/navigation_cubit.dart';
import 'package:flutter_engine/repository/global_repository.dart';
import 'package:flutter_engine/settings/bloc/settings_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

_displayContactDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return Expanded(
        child: SimpleDialog(
          title: Text(
            'Contact scrumbits',
            style: TextStyle(color: Colors.red.shade700),
          ),
          children: [
            SimpleDialogOption(
              onPressed: () {
                launchUrl(Uri(scheme: 'tel', path: '+48517439203'));
                Navigator.pop(context, "Call us");
              },
              child: const Text('Call us'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Uri uri = Uri(
                    scheme: 'mailto',
                    path: 'contact@scrumbits.com',
                    queryParameters: {'subject': 'MobileApp contact'});
                launchUrl(uri);
                Navigator.pop(context, "Send email");
              },
              child: const Text('Send email'),
            ),
          ],
          elevation: 10,
        ),
      );
    },
  );
}

Drawer mainDrawer(BuildContext context) {
  return Drawer(
    backgroundColor: Colors.red.shade700,
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const SizedBox(
          height: 80,
          child: DrawerHeader(
              child: SizedBox(
            height: 80,
          )),
        ),
        ListTile(
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            Navigator.pop(context, false);
            BlocProvider.of<SettingsBloc>(context).add(SettingsInit());
            BlocProvider.of<NavigationCubit>(context).showSettings();
          },
        ),
        ListTile(
          title: const Text(
            'Contact us',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            _displayContactDialog(context);
            Navigator.pop(context, false);
            BlocProvider.of<NavigationCubit>(context).showMainScreen();
          },
        ),
        ListTile(
          title: const Text(
            'Logout',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            GlobalRepository.cognitoUser!.signOut();
            BlocProvider.of<NavigationCubit>(context).logout();
          },
        ),
      ],
    ),
  );
}
