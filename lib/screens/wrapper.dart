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
      return UserDetails3();
    };
  }
}
