import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:r_ez2/models/local.dart';

class localPageDatabaseService{

  final String? uid;
  final String? Country;
  final String? State;
  final String? City;
  localPageDatabaseService({this.uid,this.Country,this.State,this.City});
  //late Query searched;
  final CollectionReference usersCollection= FirebaseFirestore.instance.collection("Users");
  //final Query searched = usersCollection.where("Country", isEqualTo: Country).where("State", isEqualTo: State).where("City", isEqualTo: City);

  //local list from snapshot
  List<Local> _localListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Local(
        Name: doc.get('Name') ?? "",
        Country:doc.get('Country') ?? "",
        City:doc.get('City') ?? "",
        State:doc.get('State') ?? "",
        age:doc.get('age') ?? "",
        PPUrl: doc.get("PPUrl") ?? "",
      );
    }).toList();
  }

  //get localList
  Stream<List<Local>> get locals {
    //Query searched = usersCollection.where("Country", isEqualTo: Country).where("State", isEqualTo: State).where("City", isEqualTo: City);
    return usersCollection.snapshots().map(_localListFromSnapshot);//returns a stream
  }
}
