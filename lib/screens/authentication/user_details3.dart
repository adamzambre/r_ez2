import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:r_ez2/services/auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:r_ez2/services/shared_widgets.dart';
import 'package:r_ez2/services/user_info.dart';
import 'package:r_ez2/screens/home/local.dart';

class UserDetails3 extends StatefulWidget {
  const UserDetails3({Key? key}) : super(key: key);

  @override
  State<UserDetails3> createState() => _UserDetails3State();
}

class _UserDetails3State extends State<UserDetails3> {

  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = const Color(0xffeef444c);
  String profilePicLink = "";

  int counter=0;
  File? _image;

  AuthService customAuth = new AuthService();

  void pickUploadProfilePic() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 90,
    );

    String userUid = customAuth.getUid().toString();

    Reference ref = FirebaseStorage.instance
        .ref("local/$userUid").child("profilepic.jpg");

    await ref.putFile(File(image!.path));

    ref.getDownloadURL().then((value) async {
      setState(() {
        profilePicLink = value;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Container(
        child: SingleChildScrollView(
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
              Container(
                child: InkWell(
                  onTap:() async{
                    pickUploadProfilePic();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 80, bottom: 24),
                    child: CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.white,
                      child:Center(
                        child: profilePicLink == "" ?
                        Column(
                          children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                            child: Center(
                              child: Icon(Icons.add_a_photo, color: Colors.green, size: 80,),
                            ),
                          ),
                            SizedBox(height:2),
                            Container(
                              child: Text(
                                  "Upload your main picture here",
                                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                          ) : ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CircleAvatar(
                            radius: 100.0,
                            backgroundImage:
                            NetworkImage(profilePicLink),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                    ),
                  ),
                  ),
                //),


              //////////
              /*Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap:(){
                        //pickUploadImage(context);
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
                        //pickUploadImage(context);
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
                        //pickUploadImage(context);
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
              ),*/
              ///////////
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.blue,
                ),
                child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context, MaterialPageRoute(
                      builder: (context) => Locals()
                    ),
                  );
                },
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
      ),
    );
  }
}
