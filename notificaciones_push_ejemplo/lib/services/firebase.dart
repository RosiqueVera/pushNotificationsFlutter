import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

//! Clase del servicio del manejo de notificaciones con firebase cloud Messaging
class FireBaseServices {
//* Declaracion de variables
  final FirebaseMessaging _firebaseMenssaging = FirebaseMessaging.instance;

  static StreamController<String> _messageStream = StreamController.broadcast();

  static String? token;

  static Stream<String> get messageStream => _messageStream.stream;

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
    _messageStream.add(message.notification?.title ?? 'No tiene titulo');
  }

  static Future<void> _onMessageHandler(RemoteMessage message) async {
    log('onMessage');
    _messageStream.add(message.notification?.title ?? 'No tiene titulo');
  }

  static Future<void> _onMessageOpenApp(RemoteMessage message) async {
    log('onMessageOpenApp');
    _messageStream.add(message.notification?.title ?? 'No tiene titulo');
  }

  static closeStreams() {
    _messageStream.close();
  }
}
