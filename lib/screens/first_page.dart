import 'package:flutter/material.dart';
import 'package:r_ez2/screens/authentication/register.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[500],
      body: Container(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Container(
              //width: MediaQuery.of(context).size.width / 1.3,
              child: Center
                (
                  child: Text("R-ez")
                ),
            ),
              Container(
                //width: MediaQuery.of(context).size.width / 1.3,
                child: Center(
                    child: Text("Recomendation made easy")
                ),
              ),

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.blue,
                      ),
                      child: TextButton(
                          onPressed:(){},
                          child: Text(
                              "Log in",
                            style: TextStyle(
                              color: Colors.white,
                            )
                          ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.blue,
                      ),
                      child: TextButton(
                        onPressed:(){
                          Navigator.push(
                              context, MaterialPageRoute(
                              builder: (context) => Register()
                          ),
                          );
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                ),
              ),

          ],
        )
      ),
    );
  }
}


