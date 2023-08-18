class UserWorkingHours {
  final bool esError;
  final String? mensaje;
  final int secuencial;
  int horaInicio;
  final String? dia;
  int minutoInicio;
  int horasValidez;
  int minutosValidez;

  UserWorkingHours({
    required this.esError,
    this.mensaje,
    required this.secuencial,
    required this.horaInicio,
    this.dia,
    required this.minutoInicio,
    required this.horasValidez,
    required this.minutosValidez,
  });

  void updateHoraInicio({required int horaInicio}) {
    this.horaInicio = horaInicio;
  }

  void updateHoraSalida({required int horaSalida}) {
    horasValidez = horaSalida;
  }

  factory UserWorkingHours.fromJson(Map<String, dynamic> json) {
    return UserWorkingHours(
      esError: json['EsError'] ?? false,
      mensaje: json['Mensaje'] ?? 'Not found',
      secuencial: json['Secuencial'],
      horaInicio: json['HoraInicio'],
      dia: json['Dia'] ?? '0',
      minutoInicio: json['MinutoInicio'],
      horasValidez: json['HorasValidez'],
      minutosValidez: json['MinutosValidez'],
    );
  }

  @override
  String toString() {
    if (esError) {
      return 'Mensaje: No hay horario mano';
    }
    return 'HORARIO :\n'
        '  Inicio: $horaInicio:$minutoInicio\n'
        '  Final: $horasValidez:$minutosValidez\n'
        '';
  }

  // @override
  // String toString() {
  //   return 'UserWorkingHours{esError: $esError, mensaje: $mensaje, secuencial: $secuencial, horaInicio: $horaInicio, dia: $dia, minutoInicio: $minutoInicio, horasValidez: $horasValidez, minutosValidez: $minutosValidez}';
  // }
}
