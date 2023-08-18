import 'dart:convert';
import 'package:capecpas_app/Data/Cacpepas_api.dart';
import '../../Domain/models/models.dart';

class UpdateUserController {
  Future<dynamic> fetchAgencia() async {
    final ds = DataStorage();
    String json = await ds.fetchOficinas();

    Map<String, dynamic> jsonData = jsonDecode(json);
    List<dynamic> officeList = jsonData['Oficinas'];
    return officeList.map((officeJson) => Office.fromJson(officeJson)).toList();
  }

  Future<List<User>> fetchUsers(
      {required int secuencial, required int optionFetchUsers}) async {
    final ds = DataStorage();
    String jsonUsers = await ds.fetchUsers(
        secuencial: secuencial, optionFetchUsers: optionFetchUsers);

    Map<String, dynamic> jsonData = jsonDecode(jsonUsers);
    List<dynamic> usersList = jsonData['Usuarios'];
    return usersList.map((userJson) => User.fromJson(userJson)).toList();
  }

  Future<List<UserWorkingDay>> fetchWorkingDays(
      {required String codigo}) async {
    final ds = DataStorage();
    String json = await ds.fetchWorkingDaysUser(codigo: codigo);

    Map<String, dynamic> jsonData = jsonDecode(json);
    List<dynamic> daysList = jsonData['UsuariosHorarioIngreso'];
    return daysList
        .map((userJson) => UserWorkingDay.fromJson(userJson))
        .toList();
  }

  Future<UserWorkingHours> fetchWorkingHours(
      {required UserWorkingDay userworkday}) async {
    final ds = DataStorage();

    String json = await ds.fetchWorkingHoursUser(
        secuencial: userworkday.secuencial, dia: userworkday.dia);

    Map<String, dynamic> jsonMap = {
      'esError': true,
      'mensaje': '',
      'secuencial': 0,
      'horaInicio': 0,
      'dia': '',
      'minutoInicio': 0,
      'horasValidez': 0,
      'minutosValidez': 0
    };

    try {
      jsonMap = jsonDecode(json);
    } catch (e) {
      print('Error parsing UserWorkingHours: $e');
    }
    return UserWorkingHours.fromJson(jsonMap);
  }

  Future<AnswerRequestFormat> updateWorkingHours(
      {required String userCode,
      required UserWorkingHours usrwkhrs,
      required UserWorkingDay usrDay}) async {
    final ds = DataStorage();

    String json = await ds.updateWorkingHoursUser(
        secuencial: usrDay.secuencial,
        codigoUsuario: userCode,
        dia: usrDay.dia,
        horaInicio: usrwkhrs.horaInicio,
        minutosInicio: usrwkhrs.minutoInicio,
        horasValidez: usrwkhrs.horasValidez,
        minutosValidez: usrwkhrs.minutosValidez);

    Map<String, dynamic> jsonMap = jsonDecode(json);
    return AnswerRequestFormat.fromJson(jsonMap);
  }
}
