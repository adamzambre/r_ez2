import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:r_ez2/models/local.dart';
import 'package:r_ez2/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:r_ez2/screens/first_page.dart';
import 'package:r_ez2/services/localPageDatabaseService.dart';
import 'package:provider/provider.dart';
import 'package:r_ez2/screens/home/localList.dart';
import 'dart:developer';
import 'localList.dart';
import 'localTile.dart';
import 'Interactions/interactions.dart';
import 'Reviews/reviews.dart';

class Locals extends StatefulWidget {
  const Locals({Key? key}) : super(key: key);

  @override
  State<Locals> createState() => _LocalsState();
}

class _LocalsState extends State<Locals> {

  void _onItemTapped(int index) {
    if(index==0) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new Locals())
      );
    }else if(index==1) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new Reviews())
      );
    }else if(index==2) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new Interactions())
      );
    }
  }

  String? countryValue="";
  String? stateValue="";
  String? cityValue="";

  int _currentIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                backgroundColor: Colors.amber,
                appBar: AppBar(
                  title: Text('Locals'),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      onPressed: () async{
                        await FirebaseAuth.instance.signOut();// do something
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => FirstPage())
                        );
                      },
                    )
                  ],
                  backgroundColor: Colors.brown,
                  elevation: 0.0,
                ),
                body: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Text(
                          "Search locals based on location",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        child:CSCPicker(
                          onCountryChanged: (value) {
                            setState(() {
                              countryValue = value;
                            });
                          },
                          onStateChanged:(value) {
                            setState(() {
                              stateValue = value;
                            });
                          },
                          onCityChanged:(value) {
                            setState(() {
                              cityValue = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(height:10),
                      Center(
                        child:Container(
                          height:1.0,
                          width: MediaQuery.of(context).size.width,
                          color:Colors.black,),
                      ),
                      SizedBox(height:10),
                      Container(
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance.collection("Users").where(
                              "Country", isEqualTo: countryValue)
                              .where("State", isEqualTo: stateValue)
                              .where("City", isEqualTo: cityValue)
                              .snapshots(),
                          //FirebaseFirestore.instance.collection("Users").snapshots(),//
                          //retrieveLocals(countryValue,stateValue,cityValue,whichMethod),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                          if(!snapshot.hasData){//kalau data takde
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Container(
                          height: 299,
                            child: ListView(
                              children: snapshot.data!.docs.map((document) {
                                  return Card(
                                    child: ListTile(
                                      leading: CircleAvatar(
                                      radius: 50.0,
                                      backgroundImage:
                                      NetworkImage(document.get('PPUrl')),
                                      backgroundColor: Colors.transparent,
                                      ),
                                      title: Text(document.get('Name')),
                                      subtitle: Text("${document.get('Country')},${document.get('State')}, ${document.get('City')}"),
                                    ),
                                  );
                              }).toList(),
                            ),
                          );
                          }
                        ),
                      ),
                    ],
                  ),
                ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:_currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_rounded),
            label: 'Locals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_alt_outlined),
            label: 'Reviews',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            label: 'Interactions',
          ),
        ],
        onTap:_onItemTapped,
      ),
      );
  }

  /*Stream<List<LocalData>> retrieveLocals(String? Country,String? State, String? City, int whichMethod){

    if(whichMethod==1) {
      FirebaseFirestore.instance.collection("Users").get().then((value) {
        value.docs.forEach((result) {
          //print(result.data())-> print the data of the current document(which is the result)
          //FirebaseFirestore.instance.collection("Users").doc(result.id).collection("what we are looking for").get();-> when we want to get a secific collection from the collection within the current itterating document
          FirebaseFirestore.instance.collection("Users").where(
              "Country", isEqualTo: Country).snapshots();
        }
        );
      });
    }else if(whichMethod==2){
      FirebaseFirestore.instance.collection("Users").get().then((value) {
        value.docs.forEach((result) {
          //print(result.data())-> print the data of the current document(which is the result)
          //FirebaseFirestore.instance.collection("Users").doc(result.id).collection("what we are looking for").get();-> when we want to get a secific collection from the collection within the current itterating document
          FirebaseFirestore.instance.collection("Users").where(
              "Country", isEqualTo: Country).
          where(
              "State", isEqualTo: State).snapshots();
        }
        );
      });
    }else if(whichMethod==3){
      FirebaseFirestore.instance.collection("Users").get().then((value) {
        value.docs.forEach((result) {
          //print(result.data())-> print the data of the current document(which is the result)
          //FirebaseFirestore.instance.collection("Users").doc(result.id).collection("what we are looking for").get();-> when we want to get a secific collection from the collection within the current itterating document
          FirebaseFirestore.instance.collection("Users").where(
              "Country", isEqualTo: Country).
          where(
              "State", isEqualTo: State).
          where(
              "City", isEqualTo: City).snapshots();
        }
        );
      });
  }*/
}
