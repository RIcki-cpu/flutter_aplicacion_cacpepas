//This class is both for update EstadoActivo and ResetUser
class AnswerRequestFormat {
  final bool esError;
  final String mensaje;

  AnswerRequestFormat({required this.esError, required this.mensaje});

  factory AnswerRequestFormat.fromJson(Map<String, dynamic> json) =>
      AnswerRequestFormat(
        esError: json["EsError"],
        mensaje: json["Mensaje"],
      );

  @override
  String toString() {
    return 'Respuesta Petición(esError: $esError, mensaje: $mensaje)';
  }
}
