import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:r_ez2/services/auth.dart';
import 'package:permission_handler/permission_handler.dart';
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
  String uid = FirebaseAuth.instance.currentUser!.uid;

  void pickUploadProfilePic() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 90,
    );

    String userUid = customAuth.getUid().toString();

    Reference ref = FirebaseStorage.instance
        .ref("local/$uid").child("profilepic.jpg");

    await ref.putFile(File(image!.path));

    ref.getDownloadURL().then((value) async {
      setState(() {
        profilePicLink = value;
      });
      print(value.toString());
      DocumentReference documentReference = FirebaseFirestore.instance.collection('Users').doc(uid);
      FirebaseFirestore.instance.runTransaction((
          transaction) async { //run trasnactions is when u want to ubah documentSSSSS (banyak document sekali gus) so data will not be ubah by other people while requesting, gitu
        //we read dulu the documetns from database to make sure we are working with the most uptodate data (beza dengan batched)
        DocumentSnapshot snapshot = await transaction.get(documentReference);
        documentReference.update({"PPUrl": value.toString()});
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
