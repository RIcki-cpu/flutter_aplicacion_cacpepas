import 'dart:convert';
import 'package:capecpas_app/Domain/models/oficina_model.dart';
import 'package:capecpas_app/Domain/models/usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../Data/Cacpepas_api.dart';
import '../widgets/anwser_snackbar.dart';
import '../widgets/change_ustate_dialog.dart';
import '../widgets/resetuser_dialog.dart';

/*
Algorithm
1. Fetch Office. Use DataStorage Object
2. Parse JSON and Display Offices. Save List of Offices object(agenciasOb)
3. Iterate agenciasOb list and get the single current_office object
4. Get the office.secuencial within office object

5. Fetch Users with office.secuencial. Use Datastorage Object
   Note: Use SetState to set the flag isLoading to false: This will give flutter time to make the request before showing the code users
   Once the users are fetched We can set the flag to true again
6. Parse and Display code_users. Save List of Users object(usersOb)
7. Get the code of the user chosen by the user

/---SINCE All THE USER RETRIEVED ARE SET TO FALSE EstadoActive. We just need to activate the users
8.  Send the code and name of the user to the AlerDialogWidget   
9.  Prompt the user to accept and activate the user 
10. Update EstadoActivo of users usign updateUser method of DataStorage.
11. Reload Users
9   Close PopUp

 */

class UpdateResetUserScreen extends StatefulWidget {
  final int optionValue;
  const UpdateResetUserScreen({Key? key, required this.optionValue})
      : super(key: key);

  @override
  _UpdateResetUserScreenState createState() => _UpdateResetUserScreenState();
}

class _UpdateResetUserScreenState extends State<UpdateResetUserScreen> {
  bool isLoading = true;
  //names of offices and users to show in DropdownMenu
  List<String> agencias = [];
  List<String> usuarios = [];

  //List of agenciasOb and usuariosOb to iterate and look secuencial
  List<Office> agenciasOb = [];
  List<User> usuariosOb = [];
  //Object User to Active/Deactivate or Reset Password
  User _user = User(codigo: '0', nombre: '0');

  String? selectedAgencia; // Track the selected agencia
  String? selectedUsuario;

  final TextEditingController _typeAheadController = TextEditingController();

  late int optionValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    optionValue = widget.optionValue;
    fetchAgencias();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: Image.asset('assets/animation/loading.gif',
                  height: 200,
                  scale: 2.5,
                  // color: Color.fromARGB(255, 15, 147, 59),
                  opacity: const AlwaysStoppedAnimation<double>(0.5)),
            ) // Show a loading indicator while data is being fetched
          : Container(
              margin: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  optionValue == 1
                      ? Image.asset(
                          'assets/images/activate.png',
                        )
                      : Image.asset(
                          'assets/images/user.png',
                        ),
                  optionValue == 1
                      ? const Text("ACTIVACIÓN USUARIO",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Georgia'))
                      : const Text("RESETEO DE USUARIO",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Georgia')),
                  DropdownButtonFormField(
                      hint: const Text('Agencia:'),
                      value: selectedAgencia,
                      items: agencias
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: fetchUsers),
                  TypeAheadFormField<String>(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _typeAheadController,
                      decoration: const InputDecoration(
                        labelText: 'Codigo Usuario',
                        hintText: 'Escriba iniciales ',
                      ),
                    ),
                    suggestionsCallback: (pattern) {
                      // Return a list of suggestions based on the user's input pattern
                      return usuarios.where((user) =>
                          user.toLowerCase().contains(pattern.toLowerCase()));
                    },
                    itemBuilder: (context, suggestion) {
                      // Build the item widget for each suggestion
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      // Set the selected user when a suggestion is tapped
                      _typeAheadController.text = suggestion;
                      setUser(suggestion);
                    },
                    noItemsFoundBuilder: (context) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'No hay nada mijin, intenta otra vez :(',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      );
                    },
                  ),
                  // DropdownButtonFormField(
                  //     hint: Text("Usuario"),
                  //     value: selectedUsuario,
                  //     items:
                  //         usuarios.map<DropdownMenuItem<String>>((String value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value,
                  //         child: Text(value),
                  //       );
                  //     }).toList(),
                  //     onChanged: setUser),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
          if (_user.codigo != "0") {
            if (optionValue == 1) {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialogChageUserState(
                    codigo: _user.codigo, nombre: _user.nombre),
              );
            } else {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialogResetUser(
                    codigo: _user.codigo, nombre: _user.nombre),
              );
            }
          } else {
            // Handle the case when no user is selected
            // Show an error message, display a snackbar, or take any other appropriate action
            showSnackbar(context,
                'Por favor rellene los campos faltantes primero', true);
          }
        },
        label:
            optionValue == 1 ? const Text('Activar') : const Text('Resetear'),
        icon: optionValue == 1
            ? const Icon(Icons.check_circle)
            : const Icon(Icons.restart_alt),
        backgroundColor: optionValue == 1 ? Colors.green : Colors.blue,
      ),
    );
  }

  Future<void> fetchUsers(String? nameValue) async {
    final ds = DataStorage();

    //thi set state is necesary to give time flutter to load the users in the next field
    setState(() {
      isLoading = true; //flag to load screen
      selectedAgencia =
          nameValue; // set the choice of the first filed to chosen value
      //selectedUsuario = null;
      _typeAheadController.text = "";
      usuarios
          .clear(); // Update the isLoading state variable once the data is fetched
    });

    // Get secuencial of agencia based on name
    int secuencial = 1;

    for (Office office in agenciasOb) {
      if (office.nombre == nameValue) {
        secuencial = office.secuencial;
        break;
      }
    }
    //BUSCA USUARIOS
    String jsonUsers = await ds.fetchUsers(
        secuencial: secuencial, optionFetchUsers: optionValue);

    Map<String, dynamic> jsonData = jsonDecode(jsonUsers);
    List<dynamic> usersList = jsonData['Usuarios'];
    List<User> users =
        usersList.map((userJson) => User.fromJson(userJson)).toList();

    usuariosOb = users;

    setState(() {
      for (User user in users) {
        usuarios.add(user.codigo);
      }
      isLoading = false;
    });
  }

  Future<void> fetchAgencias() async {
    //Busca Agencias
    final ds = DataStorage();
    String json = await ds.fetchOficinas();

    Map<String, dynamic> jsonData = jsonDecode(json);
    List<dynamic> officeList = jsonData['Oficinas'];
    List<Office> offices =
        officeList.map((officeJson) => Office.fromJson(officeJson)).toList();

    // Now you have a list of Office objects
    // for (var office in offices) {
    //   print('Secuencial: ${office.secuencial}, Nombre: ${office.nombre}');
    // }
    agenciasOb = offices;
    for (Office agencia in offices) {
      agencias.add(agencia.nombre);
    }
    setState(() {
      isLoading =
          false; // Update the isLoading state variable once the data is fetched
    });
  }

  void setUser(String? codigoValue) {
    // Get user Object based on name

    for (User user in usuariosOb) {
      if (user.codigo == codigoValue) {
        //print(user.toString());
        _user = user;
        break;
      }
    }
  }

  // changeUserState() {
  //   AlertDialogChageUserState(currentUser: _user);
  //   print('Estado: ');
  //   print(_user.estadoActivo);
  // }
}
