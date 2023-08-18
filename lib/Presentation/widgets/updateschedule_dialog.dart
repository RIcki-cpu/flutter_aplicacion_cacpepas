import 'package:capecpas_app/Presentation/UpdateScheduleUser/controller_screen.dart';
import 'package:capecpas_app/Presentation/widgets/anwser_snackbar.dart';
import 'package:flutter/material.dart';
import '../../Domain/models/models.dart';
import '../Home/home_screen.dart';

class UpdateTimeDialog extends StatefulWidget {
  const UpdateTimeDialog(
      {super.key,
      required this.workihours,
      required this.day,
      required this.usercode});

  @override
  _UpdateTimeDialogState createState() => _UpdateTimeDialogState();

  final UserWorkingHours workihours;
  final UserWorkingDay day;
  final String usercode;
}

class _UpdateTimeDialogState extends State<UpdateTimeDialog> {
  late String selectedCheckInHour;
  late String selectedCheckInMinute;
  late String selectedCheckOutHour;
  late String selectedCheckOutMinute;

  late UserWorkingDay userDay;
  late String userCode;

  List<String> hoursList = List.generate(24, (index) => index.toString());
  List<String> minutesList = List.generate(60, (index) => index.toString());

  @override
  void initState() {
    super.initState();

    selectedCheckInHour = widget.workihours.horaInicio.toString();
    selectedCheckInMinute = widget.workihours.minutoInicio.toString();
    selectedCheckOutHour = widget.workihours.horasValidez.toString();
    selectedCheckOutMinute = widget.workihours.minutosValidez.toString();

    userDay = widget.day;
    userCode = widget.usercode;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Actualizar horario'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Entrada:',
            style: TextStyle(fontSize: 20),
          ),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: selectedCheckInHour,
                  items: hoursList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedCheckInHour = value!;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Horas'),
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: selectedCheckInMinute,
                  items: minutesList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedCheckInMinute = value!;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Minutos'),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Salida:',
            style: TextStyle(fontSize: 20),
          ),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: selectedCheckOutHour,
                  items: hoursList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedCheckOutHour = value!;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Horas'),
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: selectedCheckOutMinute,
                  items: minutesList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedCheckOutMinute = value!;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Minutos'),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            // Perform the update with the selected values
            // String checkInHour = selectedCheckInHour;
            // String checkInMinute = selectedCheckInMinute;
            // String checkOutHour = selectedCheckOutHour;
            // String checkOutMinute = selectedCheckOutMinute;

            // Validate and handle the selected values as needed

            final answer = await UpdateUserController().updateWorkingHours(
                userCode: userCode,
                usrwkhrs: UserWorkingHours(
                    esError: false,
                    secuencial: 0,
                    horaInicio: int.parse(selectedCheckInHour),
                    minutoInicio: int.parse(selectedCheckInMinute),
                    horasValidez: int.parse(selectedCheckOutHour),
                    minutosValidez: int.parse(selectedCheckOutMinute)),
                usrDay: userDay);

            showSnackbar(context, answer.mensaje, answer.esError);

            // Close the dialog
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
          child: Text('Update'),
        ),
        ElevatedButton(
          onPressed: () {
            // Close the dialog
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
