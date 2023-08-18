import 'package:capecpas_app/Domain/models/models.dart';
import 'package:capecpas_app/Presentation/UpdateScheduleUser/controller_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../widgets/widgets.dart';

class UpdateScheduleUserScreen extends StatefulWidget {
  const UpdateScheduleUserScreen({Key? key}) : super(key: key);

  @override
  _UpdatescheduleuserScreenState createState() =>
      _UpdatescheduleuserScreenState();
}

class _UpdatescheduleuserScreenState extends State<UpdateScheduleUserScreen> {
  bool isLoading = true;
  late List<Office> officesOb;
  late List<User> usuariosOb;
  late List<UserWorkingDay> usuariosDiasOb;
  late UserWorkingHours userWorkingHoursOb;
  late AnswerRequestFormat ansrqstfrOb;

  //names of offices and users to show in DropdownMenu
  List<String> agencias = [];
  List<String> usuarios = [];
  List<String> dias = [
    "Lunes",
    "Martes",
    "Miércoles",
    "Jueves",
    "Viernes",
    "Sábado",
    "Domingo"
  ];
  String userworkingday = "";

  //Object User to Active/Deactivate or Reset Password
  User _user = User(codigo: '0', nombre: '0');
  UserWorkingDay _userWorkDay = UserWorkingDay(secuencial: 0, dia: '0');

  String? selectedAgencia; // Track the selected agencia
  String? selectedUsuario;
  String? selectedDay;

  final TextEditingController _typeAheadController = TextEditingController();
  @override
  void initState() {
    super.initState();
    fetchAgencias();
    //   fetchUsers();
    //   fetchWorkingDays();
    //   fetchWorkingHours();
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
                    Image.asset(
                      'assets/images/calendar.png',
                    ),
                    const Text(
                      "HORARIO FINANCIAL",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Georgia'),
                    ),
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
                        fetchWorkingDays(suggestion);
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
                    DropdownButtonFormField(
                        hint: const Text("Dias"),
                        value: selectedDay,
                        items:
                            dias.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: fetchWorkHourUser),
                    //Text(userworkingday),
                  ],
                ),
              ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (_user.codigo != "0" || selectedDay == "") {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => UpdateTimeDialog(
                    workihours: userWorkingHoursOb,
                    day: _userWorkDay,
                    usercode: _user.codigo),
              );
            } else {
              // Handle the case when no user is selected
              // Show an error message, display a snackbar, or take any other appropriate action
              showSnackbar(
                  context,
                  'Pero vea ponga primero el usuario y el dia no se pase',
                  true);
            }
          },
          //     },
          label: const Text(
            'ACTUALIZAR ',
            style: TextStyle(color: Colors.black),
          ),
          icon: const Icon(
            Icons.calendar_month_outlined,
            color: Colors.black,
          ),
          backgroundColor: Colors.yellow,
        )
        // floatingActionButton: ElevatedButton.icon(
        //     onPressed: () {
        //       if (_user.codigo != "0" || selectedDay == "") {
        //         showDialog<String>(
        //           context: context,
        //           builder: (BuildContext context) => UpdateTimeDialog(
        //               workihours: userWorkingHoursOb,
        //               day: _userWorkDay,
        //               usercode: _user.codigo),
        //         );
        //       } else {
        //         // Handle the case when no user is selected
        //         // Show an error message, display a snackbar, or take any other appropriate action
        //         showSnackbar(
        //             context,
        //             'Pero vea ponga primero el usuario y el dia no se pase',
        //             true);
        //       }
        //     },
        //     icon: const Icon(Icons.search),
        //     label: const Text('Buscar')),
        );
  }

  Future<void> fetchAgencias() async {
    officesOb = await UpdateUserController().fetchAgencia();
    for (Office agencia in officesOb) {
      agencias.add(agencia.nombre);
    }
    setState(() {
      isLoading =
          false; // Update the isLoading state variable once the data is fetched
    });
  }

  Future<void> fetchUsers(String? nameValue) async {
    selectedAgencia = nameValue; // set the field agencia to nameValue
    //clean all list and fields and se onLoading to true
    cleanScreenAndLoad();

    // Get secuencial of agencia based on name
    int secuencial = 1;

    for (Office office in officesOb) {
      if (office.nombre == nameValue) {
        secuencial = office.secuencial;
        break;
      }
    }

    //BUSCA USUARIOS
    usuariosOb = await UpdateUserController()
        .fetchUsers(optionFetchUsers: 2, secuencial: secuencial);

    setState(() {
      for (User user in usuariosOb) {
        usuarios.add(user.codigo);
      }
      isLoading = false;
    });
  }

  void cleanScreenAndLoad() {
    return setState(() {
      isLoading = true; //flag to load screen

      //Clean Fields--------------------------------------
      //Usuario
      usuarios.clear(); // List
      _typeAheadController.text = ""; // DropdownButton;

      //Day
      selectedDay = null;

      //AreaText
      userworkingday = "";
    });
  }

  Future<void> fetchWorkingDays(String? codigoValue) async {
    setState(() {
      isLoading = true;
      selectedDay = null;

      //AreaText
      userworkingday = "";
    });

    // Set current User
    for (User user in usuariosOb) {
      if (user.codigo == codigoValue) {
        //print(user.toString());
        _user = user;
        break;
      }
    }
    //BUSCA USUARIOS
    usuariosDiasOb =
        await UpdateUserController().fetchWorkingDays(codigo: codigoValue!);

    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchWorkHourUser(String? weekDay) async {
    if (_user.codigo == "0") {
      showSnackbar(context, 'No hay usuario', true);
      selectedDay = "";
    } else {
      selectedDay = weekDay;
      setState(() {
        isLoading = true;
        userworkingday = "";
      });

      // Set current Day
      for (UserWorkingDay dayOb in usuariosDiasOb) {
        if (dayOb.dia == weekDay) {
          //print(user.toString());
          _userWorkDay = dayOb;
          break;
        }
      }

      //Retrieve WorkignHours
      userWorkingHoursOb = await UpdateUserController()
          .fetchWorkingHours(userworkday: _userWorkDay);

      // Field Area
      userworkingday = userWorkingHoursOb.toString();

      setState(() {
        isLoading = false;
      });
    }
  }
}
