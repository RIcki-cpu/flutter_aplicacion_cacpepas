import 'dart:convert';

import 'package:capecpas_app/Data/Cacpepas_api.dart';
import 'package:capecpas_app/Presentation/Home/home_screen.dart';
import 'package:flutter/material.dart';

import '../../Domain/models/updateuser_model.dart';
import 'anwser_snackbar.dart';

class AlertDialogResetUser extends StatefulWidget {
  const AlertDialogResetUser({
    super.key,
    required this.codigo,
    required this.nombre,
  });

  final String codigo;
  final String nombre;

  @override
  State<AlertDialogResetUser> createState() => _AlertDialogResetUserState();
}

class _AlertDialogResetUserState extends State<AlertDialogResetUser> {
  late String codigo, nombre;
  @override
  Widget build(BuildContext context) {
    codigo = widget.codigo;
    nombre = widget.nombre;

    return AlertDialog(
      title: const Center(child: Text('Resetear Usuario')),
      content: Container(
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('Usuario:'),
            Text(nombre),
          ],
        ),
      ),
      actions: <Widget>[
        Align(
          alignment: Alignment.center,
          child: IconButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Set the background color to green
            ),
            onPressed: () => resetUser(),
            icon: const Icon(Icons.restore_outlined),
            //child: const Text('Activar'),
          ),
        ),
      ],
    );
  }

  void resetUser() async {
    //Reset user and make http put request
    final ds = DataStorage();
    String json = await ds.resetUser(codigo: codigo, nombre: nombre);

    //If sucessful then close pop ans show message
    Map<String, dynamic> jsonData = jsonDecode(json);
    final answerRequestUpdateUser = AnswerRequestFormat.fromJson(jsonData);

    // show snackbar and close popup
    showsnackbar(
        mensaje: answerRequestUpdateUser.mensaje,
        esError: answerRequestUpdateUser.esError);
  }

  void showsnackbar({required String mensaje, required bool esError}) {
    showSnackbar(context, mensaje, esError);

    if (!esError) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      Navigator.pop(context);
    }
  }
}
