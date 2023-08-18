class User {
  final String codigo;
  final String nombre;

  User({required this.codigo, required this.nombre});

  factory User.fromJson(Map<String, dynamic> json) => User(
        codigo: json["Codigo"],
        nombre: json["Nombre"],
      );

  @override
  String toString() {
    return 'User(codigo: $codigo, nombre: $nombre)';
  }
}
