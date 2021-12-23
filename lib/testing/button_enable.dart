import 'package:flutter/material.dart';
import 'dart:async';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int secondsRemaining = 30;
  bool enableResend = false;
  Timer? timer;

  @override
  initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          TextField(),
          const SizedBox(height: 10),
          FlatButton(
            child: Text('Submit'),
            color: Colors.blue,
            onPressed: () {
              //submission code here
            },
          ),
          const SizedBox(height: 30),
          FlatButton(
            child: Text('Resend Code'),
            onPressed: enableResend ? _resendCode : null,
          ),
          Text(
            'after $secondsRemaining seconds',
            style: TextStyle(color: Colors.black, fontSize: 10),
          ),
        ],
      ),
    );
  }

  void _resendCode() {
    //other code here
    setState((){
      secondsRemaining = 30;
      enableResend = false;
    });
  }

  @override
  dispose(){
    timer?.cancel();
    super.dispose();
  }

}