import 'package:flutter/material.dart';

class CustomButtton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const CustomButtton(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPressed,
      required this.color});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.0,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(1.0, 2.0),
                  blurRadius: 8.0,
                  spreadRadius: 2.0)
            ]),
        child: Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    width: 48.0,
                    height: 48.0,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Icon(icon),
                    )),
                Expanded(
                    child: Center(
                  child: Text(title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Colors.black)),
                )),
              ],
            ),
            SizedBox.expand(
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(onTap: onPressed),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
