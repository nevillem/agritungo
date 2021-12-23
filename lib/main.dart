import 'package:agritungo/catalog/manage_stall/manage_stall_main.dart';
import 'package:agritungo/dashboard/widgets/bottom_nav.dart';
import 'package:agritungo/myfarm/livestock_farm/milk_palour/CollectMilk.dart';
import 'package:agritungo/signup/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
/// This is the custom implementation of [ImageCache] where we can override
/// the logic.
// class MyImageCache extends ImageCache {
//   @override
//   void clear() {
//     print('Clearing cache!');
//     super.clear();
//   }
// }
//
// class MyWidgetsBinding extends WidgetsFlutterBinding {
//   @override
//   ImageCache createImageCache() => MyImageCache();
// }
void main() {
  //MyWidgetsBinding();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Agritungo(),
  ));
}

class Agritungo extends StatefulWidget {
  const Agritungo({Key? key}) : super(key: key);
  @override
  _AgritungoState createState() => _AgritungoState();
}
var accessToken;
var refreshToken;
var sessionId;
var status;
class _AgritungoState extends State<Agritungo> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/images/logo.png"), context);
    precacheImage(AssetImage("assets/images/analysis.png"), context);
    precacheImage(AssetImage("assets/images/products.png"), context);
    precacheImage(AssetImage("assets/images/investment.png"), context);
    precacheImage(AssetImage("assets/images/farmer.png"), context);
    precacheImage(AssetImage("assets/images/crop.png"), context);
    precacheImage(AssetImage("assets/images/livestock.png"), context);
    precacheImage(AssetImage("assets/images/slider1.png"), context);
    precacheImage(AssetImage("assets/images/slider2.png"), context);
    precacheImage(AssetImage("assets/images/slider3.png"), context);
    precacheImage(AssetImage("assets/images/slider4.png"), context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins', textSelectionColor: Colors.grey,
            primaryColor: Colors.white,
            textTheme: Theme.of(context).textTheme.apply(
            )
        ),
     home: ((status == null)||(status=='inactive')||(accessToken==null)) ? Register() : CollectMilk(),
      routes: {
        '/manage_stall_main': (context) => ManageStallMain(),
      },
      // routes: <String, WidgetBuilder>{
      //   '/register': (BuildContext context) => new Register(),
      //   '/dashboard': (BuildContext context) => new MyHomePage(),
      //   '/profile_form': (BuildContext context) => new UserProfile(),
      //   // '/complete_profile': (BuildContext context) => new CompleteProfile(fnames: '', lnames: '', gender: '',
      //   //     ninumber: '', dateOfbirth: '', landsize: '', familyPopulation: ''),
      // },

    );
  }
  getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken= prefs.getString('access_token');
      refreshToken= prefs.getString('refresh_token');
      sessionId= prefs.getInt('session_id');
      status=prefs.getString('status');
      print(accessToken);
      print(status);
    });
  }
}

