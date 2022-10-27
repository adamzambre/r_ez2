import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'auth.dart';

class UserInfos {

  Future<bool?> addNameAndAgeAndBiodata(String name, String age, String biodata) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('Users')
          .doc(uid);
      FirebaseFirestore.instance.runTransaction((
          transaction) async { //run trasnactions is when u want to ubah documentSSSSS (banyak document sekali gus) so data will not be ubah by other people while requesting, gitu
        //we read dulu the documetns from database to make sure we are working with the most uptodate data (beza dengan batched)
        DocumentSnapshot snapshot = await transaction.get(documentReference);
        if (!snapshot.exists) { //if there is no data (no document of that) (user tak buat lagi document tu)
          documentReference.set({"Name": name,"age": age, "biodata": biodata});
          return true;
        }
      });
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> addCountryStateCity(String Country, String State,String City) async{
    try{
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('Users')
          .doc(uid);
      FirebaseFirestore.instance.runTransaction((transaction) async { //run trasnactions is when u want to ubah documentSSSSS (banyak document sekali gus) so data will not be ubah by other people while requesting, gitu
        //we read dulu the documetns from database to make sure we are working with the most uptodate data (beza dengan batched)
        DocumentSnapshot snapshot = await transaction.get(documentReference);
        documentReference.update({"Country": Country,"State": State, "City": City});
      });
      return true;
    }catch(e){
      print(e.toString());
      return false;
    }
  }

  Future getImage(File? image) async{
    try{
      final images = await ImagePicker().pickImage(source: ImageSource.gallery);
        image = images as File;
        print('Image Path $image');
        return image;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future pickUploadImage(BuildContext context, File image) async{
    try {
      AuthService customAuth = new AuthService();
      String uid = await customAuth.getUid();
      String fileName = basename(image.path);
      Reference ref = FirebaseStorage.instance.ref("locals/$uid/$fileName")
          .child("$fileName");
      UploadTask uploadTask = ref.putFile(File("$image"));
      return uploadTask;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}