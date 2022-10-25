import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:r_ez2/services/user_info.dart';
import 'user_details2.dart';


class UserDetails1 extends StatefulWidget {
  const UserDetails1({Key? key}) : super(key: key);

  @override
  State<UserDetails1> createState() => _UserDetails1State();
}

class _UserDetails1State extends State<UserDetails1> {

  UserInfos nameAndAgeAndBiodata = new UserInfos();

  final _formKey = GlobalKey<FormState>();
  String error = "";

  String name = "";
  String age = "";
  String location = "";
  String biodata="";
  List<String> PicPath = ["","",""];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.brown[500],
        elevation: 0.0,
        title: Text('Fill Up Your Details'),
      ),
        body: Container(
        padding: EdgeInsets.all(13),
          child: Form(
            key: _formKey,//--> the key for our form
            child: Column(
              children: <Widget> [
                SizedBox(height: 20),
                TextFormField(//name
                  decoration: InputDecoration(
                    hintText: "Name",
                    fillColor: Colors.white,
                    filled: true,//nak benda ni difill ke tak?
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width:2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink, width: 2),
                    ),
                  ),
                  validator: (val) => val!.isEmpty ? 'Enter a valid name' : null,
                  onChanged: (val) {//everytime user tekan a key, this functuion will run
                    setState(() {
                    name = val;
                    });
                  }
                ),
                SizedBox(height: 20),
                TextFormField(//age
                    decoration: InputDecoration(
                      hintText: "Age",
                      fillColor: Colors.white,
                      filled: true,//nak benda ni difill ke tak?
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width:2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.pink, width: 2),
                      ),
                    ),
                    validator: (val) => val!.isEmpty ? 'Enter a valid age' : null,
                    onChanged: (val) {//everytime user tekan a key, this functuion will run
                      setState(() {
                        age = val;
                      });
                    }
                ),
                SizedBox(height: 20),
                TextFormField(//age
                    decoration: InputDecoration(
                      hintText: "Give a good impression about yoruself to the people who will look at your profile",
                      fillColor: Colors.white,
                      filled: true,//nak benda ni difill ke tak?
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width:2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.pink, width: 2),
                      ),
                    ),
                    minLines: 1,
                    maxLines: 100,
                    validator: (val) => val!.isEmpty ? 'You can change this later in your profile' : null,
                    onChanged: (val) {//everytime user tekan a key, this functuion will run
                      setState(() {
                        biodata = val;
                      });
                    }
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.blue,
                  ),
                  child: TextButton(
                    onPressed: () async{
                      if(_formKey.currentState!.validate()){//validate the current state of the form using 'validator' properties in the TextFormField, validate method lepas kalau smeua null je
                        dynamic result = await nameAndAgeAndBiodata.addNameAndAgeAndBiodata(name,age,biodata);
                        if(result==false){
                          setState(() {
                            error = "Please make sure you fill in the correct data";//error sebab result null, result null sebab method return null sebab takleh nak sign up
                          });
                        }else{
                          Navigator.push(
                            context, MaterialPageRoute(
                              builder: (context) => UserDetails2()
                          ),
                          );
                        }
                      }
                      //dynamic signin = await _auth.signInAnon();// ni cara lain (look up codecamp2)
                    },
                    child: Text(
                        'Next Page',
                        style: TextStyle(
                          color: Colors.white,
                        )
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  error,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
