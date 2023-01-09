import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notificaciones_push_ejemplo/screens/main_screen.dart';
import 'package:notificaciones_push_ejemplo/services/firebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FireBaseServices.initialApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MainScreen());
  }
}
