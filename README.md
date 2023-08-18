#  Aplicación de Usuario Reseteo/ Activación Financial
***
***
Aplicación para reseteo, activación de cuenta de usuarios Financial de la Cacpe Pastaza
Made by Richi

![Image text](./assets/images/cacpe_logo.png)

## Empezando

Este proyecto esta desarrollado en flutter un SDK de Google.
Utiliza el lenguaje Dart que esta basado en Java

Las versiones de Android o IOS estan listas para ser compiladas

Para probar este proyecto seguir los siguientes pasos

0. Instalar Flutter y una pequeña introducción
A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

1. git clone https://github.com/RIcki-cpu/flutter_apliacion_cacpepas.git
2. cd project_directory
3. flutter pub get. Instala las dependencias
4. Conecta un dispositvo Android o Apple si esta desde Xcode en Mac. ptda: tambien funcióna desde el browser
5. flutter run. Ejecuta el proyecto o f5 si esta desde vs code

## Cambiar API 
Para actualizar las consultas HTTP GET/POST ir al directorio
 
**cacpepas_app -> lib -> Data -> cacpepas_api.dart**
Nota: Desde aqui se pueden actualizar las consultas HTTP

## Algo sobre como esta construido

* El proyecto esta utilizando arquitectura clean code 
* En el directorio presentación esta los widgets que contienen los elementos graficos
Cada una de las carpetas es una pantalla o screen. Excepto la carpeta widget que son elementos
graficos reutilizables.
* En el directorio Dominio estan todas las clases y modelos de datos de los datos
* En el directorio Data este el codigo que recupera la información de la API


* Aqui esta la estructura de carpetas

´´´
    ├── Data
│   └── Cacpepas_api.dart
├── Domain
│   ├── models
│   │   ├── models.dart
│   │   ├── oficina_model.dart
│   │   ├── updateuser_model.dart
│   │   ├── userworkhours_model.dart
│   │   └── usuario_model.dart
│   └── userworkday_model.dart
├── main.dart
└── Presentation
    ├── Home
    │   └── home_screen.dart
    ├── LogIn
    │   └── login_widget.dart
    ├── UpdateResetUser
    │   └── updrstuser_screen.dart
    ├── UpdateScheduleUser
    │   ├── controller_screen.dart
    │   └── updatescheduleuser_screen.dart
    └── widgets
        ├── anwser_snackbar.dart
        ├── change_ustate_dialog.dart
        ├── custom_button2.dart
        ├── custom_button.dart
        ├── resetuser_dialog.dart
        ├── updateschedule_dialog.dart
        └── widgets.dart

9 directories, 20 files
´´´
*Gracias por tu tiempo 😁*

## FAQs
***

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


