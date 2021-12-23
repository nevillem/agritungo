import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class ImagePickerDemo extends StatefulWidget {
  const ImagePickerDemo({Key? key}) : super(key: key);

  @override
  _ImagePickerDemoState createState() => _ImagePickerDemoState();
}

class _ImagePickerDemoState extends State<ImagePickerDemo> {
  File? _selectedFile;
  bool _inProcess = false;
  final picker = ImagePicker();

  Widget getImageWidget() {
    if (_selectedFile != null) {
      return Image.file(
        _selectedFile!,
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        "assets/images/logo.png",
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      );
    }
  }
//   import 'package:http/http.dart' as http;
//
//   final Uri uri = Uri.parse(url);
//   final http.MultipartRequest request = http.MultipartRequest("POST", uri);
// // Additional key-values here
//   request.fields['sample'] = variable;
// // Adding the file, field is the key for file and file is the value
//   request.files.add(http.MultipartFile.fromBytes(
//   field, await file.readAsBytes(), filename: filename);
// // progress track of uploading process
//   final http.StreamedResponse response = await request.send();
//   print('statusCode => ${response.statusCode}');
// // checking response data
//   Map<String, dynamic> data;
//   await for (String s in response.stream.transform(utf8.decoder)) {
//   data = jsonDecode(s);
//   print('data: $data');
//   }

  _saveImage() async {
    String uploadurl = "http://94ab-160-242-140-205.ngrok.io/uploadimageflutter/uploadimage.php";
    try {
      List<int> imageBytes = _selectedFile!.readAsBytesSync();
      print(_selectedFile!);
      String baseimage = base64Encode(imageBytes);
      var response = await http.post(
          Uri.parse(uploadurl),
          body: {
            'image': baseimage,
          }
      );
      if(response.statusCode == 200){
        var jsondata = json.decode(response.body); //decode json data
        if(jsondata["error"]){ //check error sent from server
          print(jsondata["msg"]);
          //if error return from server, show message from server
        }else{
          print("Upload successful");
        }
      }else{
        print("Error during connection to server");
        //there is error during connecting to server,
        //status code might be 404 = url not found
      }
    }
  catch(e){
  print(e);
  //there is error during converting file image to base64 encoding.
  }

  }
  getImage(ImageSource source) async {
    this.setState((){
      _inProcess = true;
    });
    final image = await picker.pickImage(source: source);
    if(image != null){
      File? cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(
              ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Color(0xFF73B41A),
            toolbarTitle: "Crop Photo",
           // statusBarColor: Colors.deepOrange.shade900,
            backgroundColor: Colors.white,
          )
      );
      this.setState((){
        _selectedFile = cropped;
        _inProcess = false;
      });
    } else {
      this.setState((){
        _inProcess = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

   body: SafeArea(
     child: Center(
       child: Stack(
         children: [
           Column(
             children: [
               getImageWidget(),
               RaisedButton(
                shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.all(Radius.circular(10.0))),
               onPressed:() {
                 showModalBottomSheet(
                     context: context,
                     builder: (context) {
                       return Column(
                         mainAxisSize: MainAxisSize.min,
                         children: <Widget>[
                           ListTile(
                             leading: const Icon(Icons.photo_camera),
                             title: const Text('Camera'),
                             onTap: () {
                               Navigator.pop(context);
                               getImage(ImageSource.camera);
                             },
                           ),
                           ListTile(
                             leading: const Icon(Icons.photo),
                             title: const Text('Gallery'),
                             onTap: () {
                               Navigator.pop(context);
                               getImage(ImageSource.gallery);

                             },
                           ),
                           ListTile(
                             leading: new Icon(Icons.videocam),
                             title: new Text('Video'),
                             onTap: () {
                               Navigator.pop(context);
                             },
                           ),
                           ListTile(
                             leading: new Icon(Icons.share),
                             title: new Text('Share'),
                             onTap: () {
                               Navigator.pop(context);
                             },
                           ),
                         ],
                       );
                     });
               },
                 padding:
                 EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15),
                 color: Colors.pink,
                 child: Text(
                   'Click Me',
                   style: TextStyle(
                       color: Colors.white,
                       fontWeight: FontWeight.w600,
                       letterSpacing: 0.6),
                 ),
               ),
              RaisedButton(onPressed:(){
                _saveImage();

              },
                padding:
                EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15),
                color: Colors.pink,
                child: Text(
                  'Save',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.6),
                ),
              ),
               SizedBox(
                 height: 120,
                 width: 120,
                 child: Stack(
                     clipBehavior: Clip.none, fit: StackFit.expand,
                     children: [
                 CircleAvatar(
                 backgroundImage: AssetImage('assets/icons/avatar.png'),

                ),
                Positioned(
                  right: -16,
                  bottom: 0,
                  child: SizedBox(
                    height: 46,
                    width: 46,
                child: FlatButton(

                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
                side: BorderSide(color: Colors.white),
                ),
                color: Colors.grey[200],
                onPressed: () {

                },
             child: Icon(Icons.photo_camera,
             size: 20,),
                ),
              ),
                )
                 ]
                 )
               ),



             ],
           ),
       (_inProcess)?Container(
     color: Colors.white,
     height: MediaQuery.of(context).size.height * 0.95,
     child: Center(
       child: CircularProgressIndicator(),
     ),
   ):Center()
         ],

       ),
     ),
   ),
    );
  }
}
