import 'package:flutter/material.dart';
import 'package:flutter_app/firebase_messaging.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:Center(
          child: FlatButton(
            height: 70.0,
            color: Colors.amber,
            child: Text(
                'Allow Notifications',
            style: TextStyle(
              fontSize: 40.0,
              color: Colors.black45,
            ),
            ),
            onPressed: ()async{
              final _messaging = FBMessaging.instance;
              print(_messaging);
              await _messaging.init();
              _messaging.requestPermission().then((_) async {
                final _token = await _messaging.getToken();
                print('Token: $_token');
              });
            },
          ) ,
        ),
      ),
    );
  }
}


