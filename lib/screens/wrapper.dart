import 'package:flutter/material.dart';
import 'package:r_ez2/screens/authentication/register.dart';
import 'package:provider/provider.dart';
import 'package:r_ez2/models/user.dart';
import 'authentication/user_details3.dart';
import 'first_page.dart';
import 'home/local.dart';


class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final userInWrapper = Provider.of<MyUser?>(context);
    print('user in wrapper is $userInWrapper');
    //return home or authentication widget

    if(userInWrapper == null){//kalau bukan null then it is the user uid(tak log out lagi)
      return FirstPage();
    }else{
      return Locals();//Firebase automatically persists the user credentials locally, and tries to restore those when the app is restarted.
                      //To sign the user out, you have to explicitly sign the user out by calling await FirebaseAuth.instance.signOut().
    };
  }
}
