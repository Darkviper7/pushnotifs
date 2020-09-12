import 'dart:async';
import 'package:firebase/firebase.dart' as firebase;
import 'package:firebase_messaging/firebase_messaging.dart';

class FBMessaging {
  FBMessaging._();
  static FBMessaging _instance = FBMessaging._();
  static FBMessaging get instance => _instance;
  firebase.Messaging _mc;
  String _token;

  final _controller = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get stream => _controller.stream;

  void close() {
    _controller?.close();
  }

  Future<void> init() async {
    // firebase.initializeApp(
    //     apiKey: "AIzaSyCweMMCzHsNkbbGwi_pB1_BIshB6V_vNa8",
    //     authDomain: "yolo-ebd7f.firebaseapp.com",
    //     databaseURL: "https://yolo-ebd7f.firebaseio.com",
    //     projectId: "yolo-ebd7f",
    //     storageBucket: "yolo-ebd7f.appspot.com",
    //     messagingSenderId: "388523766928",
    //     appId: "1:388523766928:web:f7f6189383dc32bc58d415",
    //     measurementId: "G-3CT6N8999Q"
    // );
    _mc = firebase.messaging();
    print("Hello");
    _mc.usePublicVapidKey("AAAAWnXSNJA:APA91bF-CbU3sTyMBuOgYsMmk90fHGIalF2lIZhqPTlJYJzbHQGfFAxMys30KSh-NtSc9Du1VXjq8-WxxVpXbOWIy1Tcw0rUxtvOg5erBRDe1zZkRFj-AB1wgxTgajum43PermjPCb5w");
    _mc.onMessage.listen((event) {
      _controller.add(event?.data);
    });
  }

  Future requestPermission(){
    return _mc.requestPermission();
  }

  Future<String> getToken([bool force = false]) async {
    if (force || _token == null) {
      await requestPermission();
      _token = await _mc.getToken();
    }
    return _token;
  }
}