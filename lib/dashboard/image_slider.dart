
import 'dart:async';

import 'package:agritungo/dashboard/slider_model/slider_model.dart';
import 'package:agritungo/dashboard/widgets/slider_dots.dart';
import 'package:agritungo/dashboard/widgets/slider_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GettingStartedScreen extends StatefulWidget {
  @override
  _GettingStartedScreenState createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen> {

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child:  Wrap(
          alignment: WrapAlignment.start,
          spacing: 4,
          direction: Axis.horizontal,
          runSpacing: 10,
          children: [
            _otpTextField(context, true),
            _otpTextField(context, false),
            _otpTextField(context, false),
            _otpTextField(context, false),
            _otpTextField(context, false),
            _otpTextField(context, false),
          ],
        ),
      ),
    );
  }

  Widget _otpTextField(BuildContext context, bool autoFocus) {
    return  Container(
      height: MediaQuery.of(context).size.shortestSide * 0.13,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        shape: BoxShape.rectangle,
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: TextField(
          autofocus: autoFocus,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: TextStyle(),
          maxLines: 1,
          onChanged: (value) {
            if(value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
        ),
      ),
    );
  }
}
