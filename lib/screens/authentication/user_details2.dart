import 'package:flutter/material.dart';
import 'package:r_ez2/services/user_info.dart';
import 'user_details3.dart';
import 'package:csc_picker/csc_picker.dart';

class UserDetails2 extends StatefulWidget {
  const UserDetails2({Key? key}) : super(key: key);

  @override
  State<UserDetails2> createState() => _UserDetails2State();
}

class _UserDetails2State extends State<UserDetails2> {

  UserInfos CountryStateCity = new UserInfos();
  String? countryValue="";
  String? stateValue="";
  String? cityValue="";

  String error="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Determine your local area'),
        elevation: 0.0,
        backgroundColor: Colors.brown,
      ),
      backgroundColor: Colors.amber,
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 600,
            child:
            Column(
              children: [
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
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.blue,
                  ),
                  child: TextButton(
                    onPressed: () async{
                      if(countryValue!.length>=0 && stateValue!.length>=0 && cityValue!.length>=0){
                      bool result = await CountryStateCity.addCountryStateCity(countryValue,stateValue,cityValue);
                        if(result){
                          Navigator.push(
                            context, MaterialPageRoute(
                              builder: (context) => UserDetails3()
                          ),
                          );
                        }
                      }else{
                        setState(() {
                          error = "Please make sure you fill all the boxes";
                        });
                      };
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

            )
        ),
      ),
    );
  }
}
