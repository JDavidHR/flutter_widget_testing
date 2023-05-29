import 'package:flutter/material.dart';
import 'custom_bottom_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<IconData> icons = [
    Icons.home,
    Icons.search,
    Icons.notifications,
    Icons.settings,
    Icons.person,
    Icons.email,
    Icons.camera,
    Icons.favorite,
    Icons.music_note,
    Icons.movie,
  ];

  final List<String> labels = [
    "home",
    "search",
    "bottun",
    "settings",
    "person",
    "email",
    "camera",
    "favorite",
    "music_note",
    "movie,"
  ];

  final List<void Function()> actions = [
    () {
      // Acción para el botón Home
      print('Home button pressed');
    },
    () {
      // Acción para el botón Search
      print('Search button pressed');
    },
    () {
      // Acción para el botón Notifications
      print('Notifications button pressed');
    },
    () {
      // Acción para el botón Profile
      print('Profile button pressed');
    },
    () {
      // Acción para el botón Profile
      print('Profile button pressed');
    },
    () {
      // Acción para el botón Profile
      print('Profile button pressed');
    },
    () {
      // Acción para el botón Profile
      print('Profile button pressed');
    },
    () {
      // Acción para el botón Profile
      print('Profile button pressed');
    },
    () {
      // Acción para el botón Profile
      print('Profile button pressed');
    },
    () {
      // Acción para el botón Profile
      print('Profile button pressed');
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Bottom Bar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Custom Bottom Bar Example'),
        ),
        body: Container(),
        bottomNavigationBar: CustomBottomBar(
          icons: icons,
          labels: labels,
          actions: actions,
        ),
      ),
    );
  }
}
