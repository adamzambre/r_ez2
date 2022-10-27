import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:r_ez2/services/auth.dart';
import 'package:permission_handler/permission_handler.dart';

class UserDetails3 extends StatefulWidget {
  const UserDetails3({Key? key}) : super(key: key);

  @override
  State<UserDetails3> createState() => _UserDetails3State();
}

class _UserDetails3State extends State<UserDetails3> {

  int counter=0;
  File? _image;

  AuthService customAuth = new AuthService();

  Future<bool> getImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      setState(() {
        _image = File(image!.path);
        print('Image Path $_image');
      });
      return true;
    }catch(e){
      return false;
    }
  }

  Future<bool> pickUploadImage(BuildContext context) async {
    try {
      //unsupported operation cause im doing this on flutterweb not on phone bruh moment
      //TODO download flutterimagepickerweb
      //TODO add permission
      /*final image = await ImagePicker().
      pickImage(source: ImageSource.gallery,
        maxWidth: MediaQuery
            .of(context)
            .size
            .width / 5,
        maxHeight: MediaQuery
            .of(context)
            .size
            .height / 5,
        imageQuality: 75,
      );*/
      String fileName = basename(_image!.path);
      counter += 1;
      //TODO https://www.educative.io/answers/how-to-upload-to-firebase-storage-with-flutter
      String uid = await customAuth.getUid();
      Reference ref = FirebaseStorage.instance.ref("locals/$uid/$fileName")
          .child("$fileName");
      UploadTask uploadTask = ref.putFile(File("$_image"));
      TaskSnapshot taskSnapshot=await uploadTask.whenComplete(() {
        setState(() {
          print("Profile Picture $counter uploaded");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
        });
      });
      //await ref.putFile(File(image!.path)); the lines of 43 until 49
      //ref.getDownloadURL().then((value) {
      //  print(value);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              child: Text(
                  "Upload at least 1 pictures of yourself",
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 3,
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
              ),
            ),
            SizedBox(height:20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap:() async{
                  bool result = await pickUploadImage(context);
                  if(result){

                  }else{

                  }
                  },
                child: Container(
                  padding: EdgeInsets.all(80),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child:Icon(
                          Icons.add_a_photo,
                        ),
                      ),
                      Container(
                        child: Text("main photo"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //////////
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap:(){
                      pickUploadImage(context);
                      print("Was pressed");
                      },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.add_a_photo,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap:(){
                      pickUploadImage(context);
                      print("Was pressed");
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.add_a_photo,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap:(){
                      pickUploadImage(context);
                      print("Was pressed");
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.add_a_photo,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ///////////
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.blue,
              ),
              child: TextButton(
              onPressed: () {},
              child: Text(
                  'Next Page',
                  style: TextStyle(
                    color: Colors.white,
                  )
              ),
            ),),
          ],
        ),
      ),
    );
  }
}
