import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';

class AuthService {

  MyUser? _userFromFirebaseUser(User? user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  // auth change user stream
  //so everytime user sign in or out akan dimapkan ke user class kita
  Stream<MyUser?> get user {
    return FirebaseAuth.instance.
    authStateChanges().map((User? user) => _userFromFirebaseUser(user));
    //authStateChanges().map(_userFromFirebaseUser(user) ); punboleh
  }

  Future getUid() async{
    try{
      String result = await FirebaseAuth.instance.currentUser!.uid.toString();
      return result;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future<List> registerWithEmailAndPassword(String email, String password) async {
    String error ="";
    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      _userFromFirebaseUser(user); //returning the user with the uid
      return [true,error];
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        error = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        error ='The account already exists for that email.';
      }
      return [false,error];
    } catch (e) {
      print(e.toString());
      return [false,e.toString()];
    }
  }

  Future<String?> errorRegisterWithEmailAndPassword(String e) async {
     if (e == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }else if(e =='invalid-email'){
        return 'The email is invalid.';
      }
      return "";
  }

}
