import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  // final String title;
  // final String description;

  Slide({
    required this.imageUrl,
    // required this.title,
    // required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: 'assets/images/slider1.png',
    //title: 'A Cool Way to Get Start',
    //description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec dapibus tincidunt bibendum. Maecenas eu viverra orci. Duis diam leo, porta at justo vitae, euismod aliquam nulla.',
  ),
  Slide(
    imageUrl: 'assets/images/slider2.png',
    ),
  Slide(
    imageUrl: 'assets/images/slider3.png',
   ),
  Slide(
    imageUrl: 'assets/images/slider4.png',
   ),
];
