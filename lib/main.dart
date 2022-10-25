import 'package:flutter/material.dart';
import 'package:r_ez2/screens/first_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';
import 'services/auth.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:FirebaseOptions(
      apiKey: 'AIzaSyAt-Y6vMS720xhzVNPxwCG2i3VVH4rZ0KY',
      appId: '1:135188977623:android:504646733bcf413a031d92',
      messagingSenderId: '135188977623',
      projectId: 'r-ez2-725a2',
      storageBucket: 'r-ez2-725a2.appspot.com',
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      initialData: null,
      value: AuthService().user,
      child:MaterialApp(
        home: Wrapper(),
      )
    );
  }
}

