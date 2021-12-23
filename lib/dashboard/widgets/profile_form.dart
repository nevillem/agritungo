import 'package:agritungo/dashboard/dashboard.dart';
import 'package:agritungo/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'bottom_nav.dart';
import 'complete_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

 GlobalKey<FormState> _ProfileFormKey = GlobalKey<FormState>();

TextEditingController _firstname = TextEditingController();
TextEditingController _lastname = TextEditingController();
TextEditingController _telphone = TextEditingController();
TextEditingController _nin = TextEditingController();
TextEditingController _dob = TextEditingController();
TextEditingController _landsize = TextEditingController();
TextEditingController _familypop = TextEditingController();
String? _myselect;
List<Map> _selectGender = [{"gender":"Male"}, {"gender":"Female"}];

class _UserProfileState extends State<UserProfile> {
  @override
  void initState() {
    super.initState();
    _dob.text = "";
    _getPhone();
    _telphone.text=userphone;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
          title: Text('Edit Profile'),
          titleTextStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 20,),
          elevation:8,
          leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed:(){
              //Navigator.pop(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => BoottonNav()));
            },
          )
      ),
    body: SingleChildScrollView(
      physics: ClampingScrollPhysics(),
    child: _userProfile(screenHeight, screenwidth)
    ),

    );
  }

 Form _userProfile(double screenHeight, double screenwidth) {
   return Form(
    key: _ProfileFormKey,
     child: Container(
       margin: EdgeInsets.only(left:20, right: 20, top: 5),
     child: PhysicalModel(
       borderRadius: BorderRadius.circular(8),
       color: Colors.white,
       elevation:10,
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [

           Container(
             margin: EdgeInsets.only(left: 15, top: 10, right: 10,),
             child: Text(
               'First Name *',
               style: TextStyle(fontWeight:FontWeight.normal, fontSize: 14,
                 color: Color(0xFF737373),),
             ),
           ),
           SizedBox(
             height:4,
           ),
           Container(
             margin: EdgeInsets.only(left: 10, top: 10, right: 10,),
             child: TextFormField(
               validator: (value) {
                 if (value!.isEmpty) {
                   return "required";
                 } else
                   return null;
               },
               controller: _firstname,
               keyboardType: TextInputType.text,
               decoration: InputDecoration(
                 // errorText: 'required',
                 contentPadding: EdgeInsets.all(5),
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(3),
                   borderSide: BorderSide(color: Colors.black12, width: 0),
                 ),
                 enabledBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(3),
                   borderSide: BorderSide(color: Colors.black12),
                 ),
                 focusedBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(3),
                   borderSide: BorderSide(color: Colors.black12,),
                 ),
                 errorBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(3),
                   borderSide: BorderSide(color: Colors.red),
                 ),
                 errorStyle: TextStyle(fontSize:10),
                 filled: true,
                 fillColor: Colors.white,

               ),
             ),
           ),
           Container(
             margin: EdgeInsets.only(left: 15, top: 10, right: 10,),
             child: Text(
               'Last Name *'
                   '',
               style: TextStyle(fontWeight:FontWeight.normal, fontSize: 14,
                 color: Color(0xFF737373),

               ),
             ),
           ),

           Container(

             margin: EdgeInsets.only(left: 10, top: 5, right: 10,),
             child: TextFormField(
               validator: (value) {
                 if (value!.isEmpty) {
                   return "required";
                 } else
                   return null;
               },
               controller: _lastname,
               keyboardType: TextInputType.text,
               decoration: InputDecoration(
                 // errorText: 'required',
                 contentPadding: EdgeInsets.all(5),
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(3),
                   borderSide: BorderSide(color: Colors.black12, width: 0),
                 ),
                 enabledBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(3),
                   borderSide: BorderSide(color: Colors.black12),
                 ),
                 focusedBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(3),
                   borderSide: BorderSide(color: Colors.black12,),
                 ),
                 errorBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(3),
                   borderSide: BorderSide(color: Colors.red),
                 ),
                 errorStyle: TextStyle(fontSize:10),
                 filled: true,
                 fillColor: Colors.white,

               ),
             ),
           ),
           Container(
             margin: EdgeInsets.only(left: 15, top: 10, right: 10,),
             child: Text(
               'Telephone *',
               style: TextStyle(fontWeight:FontWeight.normal, fontSize: 14,
                 color: Color(0xFF737373),

               ),
             ),
           ),

           Container(
             margin: EdgeInsets.only(left: 10, top: 5, right: 10,),
             child: TextFormField(

               readOnly: true,
               //controller: _telphone,
              // initialValue: userphone,
               keyboardType: TextInputType.text,
               decoration: InputDecoration(
                 // errorText: 'required',
                 hintText: userphone !=null? userphone:'',
                 hintStyle: TextStyle(fontWeight: FontWeight.bold),
                 contentPadding: EdgeInsets.all(5),
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(3),
                   borderSide: BorderSide(color: Colors.black12, width: 0),
                 ),
                 enabledBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(3),
                   borderSide: BorderSide(color: Colors.black12),
                 ),
                 focusedBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(3),
                   borderSide: BorderSide(color: Colors.black12,),
                 ),
                 errorBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(3),
                   borderSide: BorderSide(color: Colors.red),
                 ),
                 errorStyle: TextStyle(fontSize:10),
                 filled: true,
                 fillColor: Colors.black12,

               ),
             ),
           ),
           Container(
             margin: EdgeInsets.only(left: 15, top: 10, right: 10,),
             child: Text(
               'NIN *',
               style: TextStyle(fontWeight:FontWeight.normal, fontSize: 14,
                 color: Color(0xFF737373),

               ),
             ),
           ),
           Container(
             margin: EdgeInsets.only(left: 10, top: 5, right: 10,),
             child: TextFormField(
               inputFormatters: [
                 FilteringTextInputFormatter.allow(RegExp('[a-zA-Z 0-9]')),
               ],
               maxLength: 14,
               validator: (value) {
                 if (value!.isEmpty) {
                   return "required";
                 }
                 else if(value.length <=13){
                   return 'You must enter 14 characters';
                 }
                 else
                   return null;
               },
               controller: _nin,
               keyboardType: TextInputType.text,
              // textCapitalization: TextCapitalization.characters,
               decoration: InputDecoration(
                 counterText: '',
                 // errorText: 'required',
                 contentPadding: EdgeInsets.all(5),
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(3),
                   borderSide: BorderSide(color: Colors.black12, width: 0),
                 ),
                 enabledBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(3),
                   borderSide: BorderSide(color: Colors.black12),
                 ),
                 focusedBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(3),
                   borderSide: BorderSide(color: Colors.black12,),
                 ),
                 errorBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(3),
                   borderSide: BorderSide(color: Colors.red),
                 ),
                 errorStyle: TextStyle(fontSize:10),
                 filled: true,
                 fillColor: Colors.white,

               ),
             ),
           ),

           Container(
             margin: EdgeInsets.only(left: 15, top: 10, right: 10,),
             child: Text(
               'Gender *',
               style: TextStyle(fontWeight:FontWeight.normal, fontSize: 14,
                 color: Color(0xFF737373),

               ),
             ),
           ),

           Container(
             margin: EdgeInsets.only(left: 10, top: 5, right: 10,),
            child:DropdownButtonFormField<String>(
              decoration:InputDecoration(
                // errorText: 'required',
                contentPadding: EdgeInsets.all(5),
             border: OutlineInputBorder(
               borderRadius: BorderRadius.circular(3),
               borderSide: BorderSide(color: Colors.black12, width: 0),
             ),
             enabledBorder: OutlineInputBorder(
               borderRadius: BorderRadius.circular(3),
               borderSide: BorderSide(color: Colors.black12),
             ),
             focusedBorder: OutlineInputBorder(
               borderRadius: BorderRadius.circular(3),
               borderSide: BorderSide(color: Colors.black12,),
             ),
             errorBorder: OutlineInputBorder(
               borderRadius: BorderRadius.circular(3),
               borderSide: BorderSide(color: Colors.red),
             ),
             errorStyle: TextStyle(fontSize:10),
           ),
              isDense: true,
              hint: new Text("Choose Gender"),
              value: _myselect,
              onChanged: (String? newValue) {
                setState(() {
                  _myselect = newValue;
                });
                // print (_countrySelection);
              },
              validator: (value) {
                if (value ==null) {
                  return "required";
                } else
                  return null;
              },
              items: _selectGender.map((Map map) {
                return new DropdownMenuItem<String>(
                  value: map["gender"].toString(),
                  child: new Text(
                    map["gender"],
                  ),
                );
              }).toList(),
            ),

           ),
       Container(
       margin: EdgeInsets.only(left: 15, top: 10, right: 10,),
       child: Text(
         'Date of Birth *',
         style: TextStyle(fontWeight:FontWeight.normal, fontSize: 14,
           color: Color(0xFF737373),

         ),
       ),
       ),

       Container(
       margin: EdgeInsets.only(left: 10, top: 5, right: 10,),
        child:TextFormField(
        validator: (value) {
          if (value ==null) {
            return "required";
          } else
            return null;
        },
        controller: _dob, //editing controller of this TextField
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.calendar_today),
          hintText: 'Select Date of Birth',//icon of text field
        // errorText: 'required',
        contentPadding: EdgeInsets.all(5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide: BorderSide(color: Colors.black12, width: 0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide: BorderSide(color: Colors.black12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide: BorderSide(color: Colors.black12,),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide: BorderSide(color: Colors.red),
        ),
        errorStyle: TextStyle(fontSize:10),
        filled: true,
        fillColor: Colors.white,

        ),            readOnly: true,  //set it true, so that user will not able to edit text
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context, initialDate: DateTime(2010),
              firstDate: DateTime(1945), //DateTime.now() - not to allow to choose before today.
              lastDate: DateTime(2010)
          );

          if(pickedDate != null ){
            print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            print(formattedDate); //formatted date output using intl package =>  2021-03-16
            //you can implement different kind of Date Format here according to your requirement

            setState(() {
              _dob.text = formattedDate; //set output date to TextField value.
            });
          }else{
            print("Date is not selected");
          }
        },
        ),
       ),

       Container(
       margin: EdgeInsets.only(left: 15, top: 10, right: 10,),
       child: Text(
       'Land Size(Acres)',
       style: TextStyle(fontWeight:FontWeight.normal, fontSize: 14,
         color: Color(0xFF737373),

       ),
       ),
       ),

       Container(
     margin: EdgeInsets.only(left: 10, top: 5, right: 10,),
       child: TextFormField(
       validator: (value) {
         if (value!.isEmpty) {
           return "required";
         } else
           return null;
       },
       controller: _landsize,
       keyboardType: TextInputType.number,
       decoration: InputDecoration(
       // errorText: 'required',
       contentPadding: EdgeInsets.all(5),
       border: OutlineInputBorder(
         borderRadius: BorderRadius.circular(3),
         borderSide: BorderSide(color: Colors.black12, width: 0),
       ),
       enabledBorder: OutlineInputBorder(
         borderRadius: BorderRadius.circular(3),
         borderSide: BorderSide(color: Colors.black12),
       ),
       focusedBorder: OutlineInputBorder(
         borderRadius: BorderRadius.circular(3),
         borderSide: BorderSide(color: Colors.black12,),
       ),
       errorBorder: OutlineInputBorder(
         borderRadius: BorderRadius.circular(3),
         borderSide: BorderSide(color: Colors.red),
       ),
       errorStyle: TextStyle(fontSize:10),
       filled: true,
       fillColor: Colors.white,

       ),
       ),
       ),
       Container(
       margin: EdgeInsets.only(left: 15, top: 10, right: 10,),
       child: Text(
       'Family Population',
       style: TextStyle(fontWeight:FontWeight.normal, fontSize: 14,
         color: Color(0xFF737373),

       ),
       ),
       ),

       Container(
     margin: EdgeInsets.only(left: 10, top: 5, right: 10,),
       child: TextFormField(
       validator: (value) {
         if (value!.isEmpty) {
           return "required";
         } else
           return null;
       },
       controller: _familypop,
       keyboardType: TextInputType.number,
       decoration: InputDecoration(
       // errorText: 'required',
       contentPadding: EdgeInsets.all(5),
       border: OutlineInputBorder(
         borderRadius: BorderRadius.circular(3),
         borderSide: BorderSide(color: Colors.black12, width: 0),
       ),
       enabledBorder: OutlineInputBorder(
         borderRadius: BorderRadius.circular(3),
         borderSide: BorderSide(color: Colors.black12),
       ),
       focusedBorder: OutlineInputBorder(
         borderRadius: BorderRadius.circular(3),
         borderSide: BorderSide(color: Colors.black12,),
       ),
       errorBorder: OutlineInputBorder(
         borderRadius: BorderRadius.circular(8),
         borderSide: BorderSide(color: Colors.red),
       ),
       errorStyle: TextStyle(fontSize:10),
       filled: true,
       fillColor: Colors.white,
       ),
       ),
       ),
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: [
           Container(
           margin: EdgeInsets.only(left: 15, top: 10, bottom: 10),
            child: FlatButton(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
                 color: Color(0xFF737373) ,
                 child: Text("Cancel", style: TextStyle(fontSize: 15,
                     color: Color(0xFFFFFFFF),
                   fontWeight: FontWeight.bold,),),
                 onPressed: (){
               // Navigator.pop(context);
                   Navigator.pushReplacement(context,
                       MaterialPageRoute(builder: (context) => BoottonNav()));

                 },
               )
           ),
           Container(
             // alignment: Alignment.centerRight,
             margin: EdgeInsets.only(left: 90, top: 10, bottom: 10),
             child: FlatButton(
               shape: const RoundedRectangleBorder(
             borderRadius: BorderRadius.all(Radius.circular(20))),
               color: Color(0xFF73B41A),
               child: Text('Next',
                 style: TextStyle(color: Color(0xFFFFFFFF),
                   fontWeight: FontWeight.bold,
                   fontSize: 15,
                 ),),

               onPressed: () {
                 if (_ProfileFormKey.currentState!.validate()) {
                   Navigator.pushReplacement(context,
                       MaterialPageRoute(builder: (context) => CompleteProfile(
                         lnames: _lastname.text,
                         fnames:_firstname.text, gender: _myselect.toString(),
                         ninumber: _nin.text, dateOfbirth:_dob.text,
                         landsize: _landsize.text, familyPopulation:_familypop.text,

                       )));
                   // Navigator.of(context).pushAndRemoveUntil(
                   //     MaterialPageRoute(builder: (BuildContext context) =>
                   //         CompleteProfile(lnames: _lastname.text,
                   //           fnames:_firstname.text, gender: _myselect.toString(),
                   //           ninumber: _nin.text, dateOfbirth:_dob.text,
                   //           landsize: _landsize.text, familyPopulation:_familypop.text,
                   //         )),
                   //         (Route<dynamic> route) => false);
                 }else{
                   // print("Not Validated");
                 }

                },
             ),
           ),
           // new SizedBox(
           //   width: 10.0,
           // ),
         ],
       ),

       new SizedBox(
             width: 10.0,
       ),
          // Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
         ],
       ),
     ),
     ),
   );
 }
 var userphone;
  _getPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userphone=prefs.getString('phone');
    });
  }

}
