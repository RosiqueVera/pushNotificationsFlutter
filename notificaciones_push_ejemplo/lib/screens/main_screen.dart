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
    final FireBaseServices fireservices = FireBaseServices();
    fireservices.setNotification();
    fireservices.streamCtlr.stream.listen(_changeData);
    fireservices.bodyCtlr.stream.listen(_changeBody);
    fireservices.titleCtlr.stream.listen(_changeTitle);
  }

  _changeData(String msg) => setState(
        () => bodydata = msg,
      );
  _changeBody(String msg) => setState(
        () => bodyNotification = msg,
      );
  _changeTitle(String msg) => setState(
        () => titleNotification = msg,
      );

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
