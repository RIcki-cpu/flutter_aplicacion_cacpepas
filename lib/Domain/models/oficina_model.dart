class Office {
  final int secuencial;
  final String nombre;

  Office({
    required this.secuencial,
    required this.nombre,
  });

  factory Office.fromJson(Map<String, dynamic> json) {
    return Office(
      secuencial: json['Secuencial'],
      nombre: json['Nombre'],
    );
  }
  @override
  String toString() {
    return 'Office{secuencial: $secuencial, nombre: $nombre}';
  }
}
