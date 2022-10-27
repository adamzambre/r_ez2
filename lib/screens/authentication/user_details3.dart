import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:r_ez2/services/auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:r_ez2/services/shared_widgets.dart';
import 'package:r_ez2/services/user_info.dart';

class UserDetails3 extends StatefulWidget {
  const UserDetails3({Key? key}) : super(key: key);

  @override
  State<UserDetails3> createState() => _UserDetails3State();
}

class _UserDetails3State extends State<UserDetails3> {

  int counter=0;
  File? _image;

  AuthService customAuth = new AuthService();



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
                  var result = await UserInfos().getImage(_image);
                  if(result!=null){
                    child: PictureUploaded(image: result);
                  }else{
                    child: PictureNotUpload();
                  };
                },

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
