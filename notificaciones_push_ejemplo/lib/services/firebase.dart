import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

//! Clase del servicio del manejo de notificaciones con firebase cloud Messaging
class FireBaseServices{

//* Declaracion de variables
  final FirebaseMessaging _firebaseMenssaging = FirebaseMessaging.instance;
  final StreamController<String> streamCtlr = StreamController<String>.broadcast();
  final StreamController<String> bodyCtlr = StreamController<String>.broadcast();
  final StreamController<String> titleCtlr = StreamController<String>.broadcast();
//? Metodo para crear un handler de las notificaciones para cuando la aplicacion este en segundo plano
  Future<void> backgroundHandler(RemoteMessage message) async {
    
    await Firebase.initializeApp();
    log('Se inicializo el handler del mensaje  ${message.messageId}');

    if (message.data.containsKey('data')){

      final data = message.data['data'];

    }

    if(message.data.containsKey('notification')){

      final notification = message.data['notification'];
 
    }

  } 
//? Metodo que recibe las notificaciones
  void setNotification(){

    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    FirebaseMessaging.onMessage.listen((message) async {

      if(message.data.containsKey('data')){
        streamCtlr.sink.add(message.data['data']);
      } else if(message.data.containsKey('notification')){
        streamCtlr.sink.add(message.data['notification']);
      }

      titleCtlr.sink.add(message.notification!.title!);
      bodyCtlr.sink.add(message.notification!.body!);
        

     });

     final token = _firebaseMenssaging.getToken().then((value) => log(value.toString()));

  }
  
//? Metodo que cierra los controladores
  void dispose(){
    streamCtlr.close();
    titleCtlr.close();
    bodyCtlr.close();
  }

}