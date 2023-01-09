import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:notificaciones_push_ejemplo/services/firebase.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String titleNotification = 'Sin titulo';
  String bodyNotification = 'Sin body';
  String bodydata = 'Sin data';

  @override
  void initState() {
    super.initState();
    FireBaseServices.messageStream.listen(
      (msg) {
        log('Message: $msg');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Text>[
            Text(
              'Titulo: $titleNotification',
            ),
            Text(
              'body: $bodyNotification',
            ),
            Text(
              'data: $bodydata',
            ),
          ],
        ),
      ),
    );
  }
}
