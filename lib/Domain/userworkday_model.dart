class UserWorkingDay {
  final int secuencial;
  final String dia;

  UserWorkingDay({
    required this.secuencial,
    required this.dia,
  });

  factory UserWorkingDay.fromJson(Map<String, dynamic> json) {
    return UserWorkingDay(
      secuencial: json['Secuencial'],
      dia: json['Dia'],
    );
  }
  @override
  String toString() {
    return 'DiasLaborales{secuencial: $secuencial, dia: $dia}';
  }
}
