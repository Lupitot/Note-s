import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'LogPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'error.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _register() async {
    //enregistrement de l'utilisateur
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        //création de l'utilisateur dans firebase avec une instance de firebase
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Utilisateur enregistré avec succès
      User? user = userCredential.user;

      if (user != null) {
        // Définir le displayName comme le premier mot de l'email avant le "@"
        String displayName = _emailController.text.split('@').first;
        await user.updateProfile(displayName: displayName);

        // Stocker le nom d'utilisateur dans Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'displayName': displayName,
        }, SetOptions(merge: true));

        Navigator.pushReplacementNamed(context, '/');
      } else {
        print('User creation failed');
      }
    } on FirebaseAuthException catch (e) {
      // Gérer les erreurs
      print('Error code: ${e.code}');
      print('Error message: ${e.message}');
      if (e.code == 'email-already-in-use') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ErrorPage(numberError: 4)),
        );
      } else if (e.code == 'invalid-email') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ErrorPage(numberError: 5)),
        );
      } else if (e.code == 'weak-password') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ErrorPage(numberError: 6)),
        );
      }
    }
  }

  //mot de passe trop court == weak-password
  //email non valide == invalid-email
  //email deja utilisé   == email-already-in-use

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Registration'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.0),
              const Padding(padding: EdgeInsets.all(20)),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              const Padding(padding: EdgeInsets.all(20)),
              ElevatedButton(
                onPressed: _register,
                child: Text('Register'),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          //bouton pour aller sur la page de login
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          child: Text('Login'),
        ));
  }
}
