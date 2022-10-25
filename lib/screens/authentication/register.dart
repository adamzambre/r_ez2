import 'package:flutter/material.dart';
import 'package:r_ez2/services/auth.dart';
import 'user_details1.dart';

class Register extends StatefulWidget {
  //TODO ubah error message kalau dah ada account
  //TODO masukkan all the register pages into one page sebab nanti provder akan kesan after dah masuk uid terus akan masuk local page
  //UNLESS kita set uid MyUser AFTER masukkan gambar, alhamdulillah
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();
  String error = "";

  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.brown[500],
        elevation: 0.0,
        title: Text('Register to R-ez'),
      ),
        body: Container(
          padding: EdgeInsets.all(13),
          child: Form(
              key: _formKey,//--> the key for our form
              child: Column(
                children: <Widget> [
                  SizedBox(height: 20),
                  TextFormField(//Email
                      decoration: InputDecoration(
                        hintText: "Email",
                        fillColor: Colors.white,
                        filled: true,//nak benda ni difill ke tak?
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width:2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink, width: 2),
                        ),
                      ),
                      validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {//everytime user tekan a key, this functuion will run
                        setState(() {
                          email = val;
                        });
                      }
                  ),
                  SizedBox(height: 20),
                  TextFormField(//password
                    decoration: InputDecoration(
                      hintText: "Password",
                      fillColor: Colors.white,
                      filled: true,//nak benda ni difill ke tak?
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width:2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.pink, width: 2),
                      ),
                    ),
                    obscureText: true,
                    validator: (val) => val!.length <6 ? 'Make sure the pass word is 6 or more characters' : null,
                    onChanged: (val){
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Container(//button
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.blue,
                    ),
                    child: TextButton(
                      onPressed: () async{
                        if(_formKey.currentState!.validate()){//validate the current state of the form using 'validator' properties in the TextFormField, validate method lepas kalau smeua null je
                          dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                          if(result){//it is true
                            Navigator.pushReplacement(
                              context, MaterialPageRoute(
                                builder: (context) => UserDetails1()
                              ),
                            );
                          }
                        }else{
                          setState(() {
                            error = "Make sure you filled in your details correctly";//error sebab result null, result null sebab method return null sebab takleh nak sign up
                          });
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
              )
          ),
        )
      );
  }
}

