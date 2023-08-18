import 'package:capecpas_app/Presentation/UpdateResetUser/updrstuser_screen.dart';
import 'package:capecpas_app/Presentation/UpdateScheduleUser/updatescheduleuser_screen.dart';
import 'package:capecpas_app/Presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: null,
      //   backgroundColor: Colors.transparent,
      //   elevation: 0, // Set the title to null
      //   leading: Row(
      //     children: [
      //       Expanded(
      //         child: Container(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Align(
      //             alignment: Alignment.center,
      //             child: Image.asset(
      //                 'assets/images/cacpe.png'), // Your custom logo image
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 150),
            Container(
              margin: const EdgeInsets.only(left: 40),
              child: Image.asset(
                'assets/images/it_department.png',
              ),
            ),
            const SizedBox(height: 120),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: CustomButtton(
                  color: Colors.green,
                  title: 'Activar Usuario',
                  icon: Icons.person,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const UpdateResetUserScreen(optionValue: 1)),
                    );
                  }),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: CustomButtton(
                  color: Colors.blue,
                  title: 'Resetear Usuario',
                  icon: Icons.restore_sharp,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const UpdateResetUserScreen(optionValue: 2)),
                    );
                  }),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: CustomButtton(
                  color: Colors.yellow,
                  title: 'Horario Usuarios',
                  icon: Icons.calendar_month,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const UpdateScheduleUserScreen()),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
