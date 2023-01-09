import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

//! Clase del servicio del manejo de notificaciones con firebase cloud Messaging
class FireBaseServices {
//* Declaracion de variables
  final FirebaseMessaging _firebaseMenssaging = FirebaseMessaging.instance;

  static StreamController<String> _titleStream = StreamController.broadcast();
  static StreamController<String> _bodyStream = StreamController.broadcast();
  static StreamController<dynamic> _dataStream = StreamController.broadcast();

  static String? token;

  static Stream<String> get messageStream => _titleStream.stream;
  static Stream<String> get bodySteam => _bodyStream.stream;
  static Stream<dynamic> get dataStream => _dataStream.stream;

  static Future<void> initialApp() async {
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    log('TOKEN: $token');

    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
  }

  static Future<void> _backgroundHandler(RemoteMessage message) async {
    //log('message background ${message.messageId}');
    _titleStream.add(message.notification?.title ?? 'No tiene titulo');
    _bodyStream.add(message.notification?.body ?? 'No tiene body');
    _dataStream.add(message.data);
  }

  static Future<void> _onMessageHandler(RemoteMessage message) async {
    log('onMessage');
    _titleStream.add(message.notification?.title ?? 'No tiene titulo');
    _bodyStream.add(message.notification?.body ?? 'No tiene body');
    _dataStream.add(message.data);
  }

  static Future<void> _onMessageOpenApp(RemoteMessage message) async {
    log('onMessageOpenApp');
    _titleStream.add(message.notification?.title ?? 'No tiene cuerpo');
    _bodyStream.add(message.notification?.body ?? 'No tiene body');
    _dataStream.add(message.data);
  }

  static closeStreams() {
    _titleStream.close();
    _bodyStream.close();
    _dataStream.close();
  }
}
