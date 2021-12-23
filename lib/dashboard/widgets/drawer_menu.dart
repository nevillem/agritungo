import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPreferences();
  }
  @override
  Widget build(BuildContext context) {
    String userNamedetails =checkUserDetails();
    return Drawer(
      child: ListView(
        children: <Widget>[
         // (status == null)||,
      UserAccountsDrawerHeader(
            accountName:  Text(userNamedetails.toString(),
            style:const TextStyle(color:Colors.white,
              fontWeight: FontWeight.bold,
            ),),
            accountEmail: Text(userphone !=null? userphone:'',
              style:TextStyle(color:Colors.white,),
            ),
            //currentAccountPicture: CircleAvatar(
            currentAccountPicture: Stack(
                children: <Widget>[
                  Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image:
                      AssetImage('assets/icons/avatar.png'),

                    )
                ),
                // backgroundImage: AssetImage('assets/images/farmer.png'),
              ),
              ]
            ),
            decoration: BoxDecoration(color: Color(0xff73B41A)),
          ),
          ListTile(
            // onPressed: () {},
            leading: IconButton(
                icon: const Icon(FontAwesomeIcons.userCircle),
                onPressed: () {}),
            title: Text('Profile'),

          ),
          ListTile(
            leading: IconButton(
                icon: const Icon(FontAwesomeIcons.chartBar),
                onPressed: () {}),
            title: Text('Reports'),
          ),
          ListTile(
            leading: IconButton(
                icon: const Icon(
                    FontAwesomeIcons.commentDots),
                onPressed: () {}),
            title: Text('Chats'),

          ),

          ListTile(
            leading: IconButton(
                icon: const Icon(
                    FontAwesomeIcons.wallet),
                onPressed: () {}),

            title: Text('Wallet'),

          ),
          ListTile(
            leading: IconButton(
                icon: const Icon(
                    FontAwesomeIcons.gift),
                onPressed:(){}),
            title: Text('Orders'),

          ),
          ListTile(

            leading: IconButton(
                icon: Icon(FontAwesomeIcons.shoppingBasket),
                onPressed: (){}),
            title: Text('Cart'),
          )
          ,
          ListTile(
            leading: IconButton(
                icon: const Icon(
                    FontAwesomeIcons.cog),
                onPressed: () {}),
            title:Text('Settings'),

          ),
          ListTile(
            leading: IconButton(
                icon: Icon(FontAwesomeIcons.signOutAlt),
                onPressed: (){}),
            title: Text('Logout'),
          ),
        ],
      ),
    );
  }
  var user_fname;
  var user_lname;
  var userphone;

   getPreferences() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     setState(() {
       user_fname=prefs.getString('first_name');
       user_lname=prefs.getString('last_name');
       userphone=prefs.getString('phone');
     });

  }
  String checkUserDetails(){
     if((user_lname==null) ||(user_fname==null)){
       return "";
     }
     else{
       return user_fname +' '+ user_lname;
     }
  }
}
