import 'package:capecpas_app/Data/Cacpepas_api.dart';
import 'package:capecpas_app/Presentation/LogIn/login_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[800],

        // Define the default font family.
        fontFamily: 'Georgia',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 15.0, fontStyle: FontStyle.italic),
          bodyMedium: TextStyle(fontSize: 10.0, fontFamily: 'Hind'),
        ),
      ),
      home: const LoginWidget(),
    );
  }

  // Future<void> pruebas() async {
  //   final ss = DataStorage();
  //   print(ss.fetchUsuarios());
  // }
}
