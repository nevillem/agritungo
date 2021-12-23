import 'package:agritungo/dashboard/slider_model/slider_model.dart';
import 'package:flutter/material.dart';

class SlideItem extends StatelessWidget {
  final int index;
  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.symmetric(
       //  horizontal:5.0,
       // vertical:10,
      ),
      // height: screenHeight * 0.15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
       color: Colors.white,
        image: DecorationImage(
          image: AssetImage(slideList[index].imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
