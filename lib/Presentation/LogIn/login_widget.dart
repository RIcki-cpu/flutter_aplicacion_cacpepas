import 'package:capecpas_app/Presentation/Home/home_screen.dart';
import 'package:capecpas_app/Presentation/widgets/anwser_snackbar.dart';
import 'package:capecpas_app/Presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _textController = TextEditingController();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            'assets/images/cacpe_logo.png',
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: const Text(
              'DEPARTAMENTO DE TECNOLOGIAS DE LA INFORMACIÓN Y SISTEMAS DE LA CACPE PASTAZA PUYO - ECUADOR',
              //style: Theme.of(context).textTheme.bodyLarge
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Georgia'),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: _textController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Introducir contraseña',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.blue),
                    child: const Text('Ingresar'),
                    onPressed: () {
                      if (_textController.text == "contraseña") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                        );
                      } else {
                        showSnackbar(context, 'Contraseña Incorrecta', true);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
