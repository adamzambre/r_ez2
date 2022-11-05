import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:r_ez2/models/local.dart';
import 'package:r_ez2/screens/home/localTile.dart';

/*class localList{

  String Country;
  String State;
  String City;
  final CollectionReference localCollection=FirebaseFirestore.instance.collection('Users');
  Query? searched;

  localList({required this.Country,required this.State,required this.City});

    List<Local> _localListFromSnapshot(QuerySnapshot snapshot){
      searched = localCollection.where("Country", isEqualTo: Country).where("State", isEqualTo: State).where("City", isEqualTo: City);
      return snapshot.docs.map((doc){
        return Local(
            Name:doc['Name'] ?? '',
            age: doc['age'] ?? '',
            Country: doc['Country'] ?? '',
            State: doc['State'] ?? '',
            City: doc['City'] ?? '',
            PPUrl: doc['PPUrl'] ?? '',
        );
      }).toList();
    }

    Stream<List<Local>>get locals{
      return searched!.snapshots().map(_localListFromSnapshot);
    }

}*/

class LocalList extends StatefulWidget {
  const LocalList({Key? key}) : super(key: key);

  @override
  State<LocalList> createState() => _LocalListState();
}

class _LocalListState extends State<LocalList> {
  @override
  Widget build(BuildContext context) {

    final locals/*a list of locals' class*/ =Provider.of<List<Local>?>(context);//->getting the data from the provider's snapshot from home/local
    locals?.forEach((local) {
      print(local.Name);
      print(local.age);
      print(local.Country);
      print(local.State);
      print(local.City);
      print("done for the user");
    }
    );
    print("the program is supposed to end here");

    return Container(
      height: 299,
      child: ListView.builder(
          itemCount: locals?.length,
          itemBuilder:(context,index){
            return LocalTile(local: locals![index]);//runs localList.dart
          }
      ),
    );
  }
}
