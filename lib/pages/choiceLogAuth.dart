import 'package:flutter/material.dart';
import 'LogPage.dart';
import 'AuthPage.dart';
import '../main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'error.dart';

class Choice extends StatefulWidget {
  @override
  _Choice createState() => _Choice();
}

class _Choice extends State<Choice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('You are logged out'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()), //bouton pour aller sur la page de login
                  );
                },

                child: Container(
                        height: 50,
                        width: 200,
                        child: Center(
                          child: Text(
                            'Login',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                      ),
              ),
              const Padding(padding: EdgeInsets.all(50)),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AuthPage()), //bouton pour aller sur la page d'authentification
                  );
                },
                child: Container(
                        height: 50,
                        width: 200,
                        child: Center(
                          child: Text(
                            'Register',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
        );
  }
}
