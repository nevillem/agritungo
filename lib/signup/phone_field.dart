import 'package:flutter/material.dart';
class CountryList extends StatefulWidget {
  const CountryList({Key? key}) : super(key: key);

  @override
  _CountryListState createState() => _CountryListState();

}
class ListItem{
  int value;
  String image,name;

  ListItem(this.value, this.image, this.name);
}
class _CountryListState extends State<CountryList> {
  List<String> _animals = ["Dog", "Cat", "Crocodile", "Dragon"];

  String? _selectedColor;
  int _value = 1;
  List<ListItem> _dropdownItems = [
    ListItem(1, "assets/images/flagug.png","Uganda" ),
    ListItem(2, "assets/images/flagug.png","Kenya" ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Kindacode.com'),
    ),
    body: Container(
    padding: EdgeInsets.all(20),
    child:DropdownButton(
    value: _value,
    items: _dropdownItems.map((ListItem item) {
    return DropdownMenuItem<int>(
    child: Row(
      children: [
        Image.asset(
        item.image,
        width: 25,),
        Container(margin:EdgeInsets.only(left:5 ),
            child: Text(item.name,
                style: TextStyle(fontSize: 15)))
      ],
    ),
    value: item.value,
    );
    }).toList(),
    onChanged: (value) {
    setState(() {
    _value = value as int;
    });
    },
    ),
    ) );
  }
}

