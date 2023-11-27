import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'error.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController(); 
  final TextEditingController _passwordController = TextEditingController();

  void _login() async { //fonction de connexion
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword( //connexion de l'utilisateur avec une instance de firebase
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Utilisateur connecté avec succès
      User? user = userCredential.user;

      if (user != null) {
        // Recharger les données de l'utilisateur
        await user.reload();

        Navigator.pushReplacementNamed(context, '/');
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ErrorPage(numberError: 2)),
        );
      }
    } on FirebaseAuthException catch (e) {
      // Gérer les erreurs
      print('Error code: ${e.code}');
      print('Error message: ${e.message}');
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ErrorPage(numberError: 3)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField( //champ de texte pour l'email
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.0),
            const Padding(padding: EdgeInsets.all(20)),
            TextField( //champ de texte pour le mot de passe
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            const Padding(padding: EdgeInsets.all(20)),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
