import 'dart:convert';

import 'package:capecpas_app/Data/Cacpepas_api.dart';
import 'package:capecpas_app/Presentation/Home/home_screen.dart';
import 'package:flutter/material.dart';

import '../../Domain/models/updateuser_model.dart';
import 'anwser_snackbar.dart';

class AlertDialogChageUserState extends StatefulWidget {
  const AlertDialogChageUserState({
    super.key,
    required this.codigo,
    required this.nombre,
  });

  final String codigo;
  final String nombre;

  @override
  State<AlertDialogChageUserState> createState() =>
      _AlertDialogChageUserStateState();
}

class _AlertDialogChageUserStateState extends State<AlertDialogChageUserState> {
  late String codigo, nombre;
  @override
  Widget build(BuildContext context) {
    codigo = widget.codigo;
    nombre = widget.nombre;

    return AlertDialog(
      title: const Center(child: Text('Activar Usuario')),
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

      // content: ElevatedButton(
      //   style: ElevatedButton.styleFrom(
      //     backgroundColor:
      //         userState ? Colors.red : Colors.teal, // This is what you need!
      //   ),
      //   onPressed: () => setState(() => userState = !userState),
      //   child: Text(userState ? 'Desactivado' : 'Activado'),
      // ),
      actions: <Widget>[
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  Colors.green, // Set the background color to green
            ),
            onPressed: () => updateUserState(),
            child: const Text('Activar'),
          ),
        ),
      ],
    );
  }

  void updateUserState() async {
    //Update user and make http put request
    final ds = DataStorage();
    String json = await ds.updateUsuario(codigo: codigo, nombre: nombre);

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
