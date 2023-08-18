import 'package:http/http.dart' as http;
import 'dart:convert';

class DataStorage {
  //Fetch oficinas
  Future<String> fetchOficinas() async {
    var url = Uri.http('186.3.44.171:2002', 'Operador/RecuperaOficinas');
    var response = await http.put(url);

    if (response.statusCode == 200) {
      // Request was successful
      return response.body;
      // Process the response data here
    } else {
      // Request failed
      print('Request failed with status: ${response.statusCode}');
      throw Exception();
    }
    //print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');
  }

  //Fetch users based in optionFetchUsers
  //1 = inactive Users
  //2 = All users
  Future<String> fetchUsers(
      {required int secuencial, required int optionFetchUsers}) async {
    String requestType;
    if (optionFetchUsers == 1) {
      requestType = 'Operador/RecuperaUsuariosPorOficina';
    } else if (optionFetchUsers == 2) {
      requestType = 'Operador/RecuperaUsuariosPorOficinaParaReseteo';
    } else {
      throw Exception();
    }
    print(requestType);
    var url = Uri.http('186.3.44.171:2002', requestType);
    var headers = {'Content-Type': 'application/json'};
    var response = await http.put(url,
        body: jsonEncode(
          secuencial,
        ),
        headers: headers);
    if (response.statusCode == 200) {
      // Request was successful
      //print('Response body: ${response.body}');
      return response.body;
      // Process the response data here
    } else {
      // Request failed
      print('Request failed with status: ${response.statusCode}');
      throw Exception();
    }
  }

  Future<String> updateUsuario(
      {required String codigo, required String nombre}) async {
    var url = Uri.http('186.3.44.171:2002', 'Operador/ActualizaUsuario');
    var headers = {'Content-Type': 'application/json'};
    var response = await http.put(url,
        body: jsonEncode({
          'Codigo': codigo,
          'Nombre': nombre,
          'EstaActivo': true,
        }),
        headers: headers);
    if (response.statusCode == 200) {
      // Request was successful
      //print('Response body: ${response.body}');
      return response.body;
      // Process the response data here
    } else {
      // Request failed
      print('Failed to update user. Status code: ${response.statusCode}');
      throw Exception();
    }
  }

  Future<String> resetUser(
      {required String codigo, required String nombre}) async {
    var url = Uri.http('186.3.44.171:2002', 'Operador/ReseteaUsuario');
    var headers = {'Content-Type': 'application/json'};
    var response = await http.put(url,
        body: jsonEncode({
          'CodigoUsuario': codigo,
          'Nombre': nombre,
        }),
        headers: headers);
    if (response.statusCode == 200) {
      // Request was successful
      //print('Response body: ${response.body}');
      return response.body;
      // Process the response data here
    } else {
      // Request failed
      print('Failed to update user. Status code: ${response.statusCode}');
      throw Exception();
    }
  }

  Future<String> fetchWorkingDaysUser({required String codigo}) async {
    var url = Uri.http('186.3.44.171:2002', 'Operador/RecuperaDiasHorario');
    var headers = {'Content-Type': 'application/json'};
    var response = await http.put(url,
        body: jsonEncode(
          codigo,
        ),
        headers: headers);
    if (response.statusCode == 200) {
      // Request was successful
      //print('Response body: ${response.body}');
      return response.body;
      // Process the response data here
    } else {
      // Request failed
      //print('Failed to update user. Status code: ${response.statusCode}');
      throw Exception();
    }
  }

  Future<String> fetchWorkingHoursUser(
      {required int secuencial, required String dia}) async {
    var url = Uri.http('186.3.44.171:2002', 'Operador/RecuperaHorario');
    var headers = {'Content-Type': 'application/json'};
    var response = await http.put(url,
        body: jsonEncode({
          'Secuencial': secuencial,
          'Dia': dia,
        }),
        headers: headers);
    if (response.statusCode == 200) {
      // Request was successful
      //print('Response body: ${response.body}');
      return response.body;
      // Process the response data here
    } else {
      // Request failed
      print('Failed to update user. Status code: ${response.statusCode}');
      throw Exception();
    }
  }

  Future<String> updateWorkingHoursUser({
    required int secuencial,
    required String codigoUsuario,
    required String dia,
    required int horaInicio,
    required int minutosInicio,
    required int horasValidez,
    required int minutosValidez,
  }) async {
    var url = Uri.http('186.3.44.171:2002', 'Operador/ActualizaHorario');
    var headers = {'Content-Type': 'application/json'};
    var response = await http.put(url,
        body: jsonEncode({
          "Secuencial": secuencial,
          "CodigoUsuario": codigoUsuario,
          "Dia": dia,
          "HoraInicio": horaInicio,
          "MinutoInicio": minutosInicio,
          "HorasValidez": horasValidez,
          "MinutosValidez": minutosValidez
        }),
        headers: headers);
    if (response.statusCode == 200) {
      // Request was successful
      //print('Response body: ${response.body}');
      return response.body;
      // Process the response data here
    } else {
      // Request failed
      print('Failed to update user. Status code: ${response.statusCode}');
      throw Exception();
    }
  }

  // Future<String> fetchInactiveUsers(int secuencial) async {
  //   var url =
  //       Uri.http('186.3.44.171:2002', 'Operador/RecuperaUsuariosPorOficina');
  //   var headers = {'Content-Type': 'application/json'};
  //   var response = await http.put(url,
  //       body: jsonEncode(
  //         secuencial,
  //       ),
  //       headers: headers);
  //   if (response.statusCode == 200) {
  //     // Request was successful
  //     //print('Response body: ${response.body}');
  //     return response.body;
  //     // Process the response data here
  //   } else {
  //     // Request failed
  //     print('Request failed with status: ${response.statusCode}');
  //     throw Exception();
  //   }
  // }
}
