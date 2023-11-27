import 'package:flutter/material.dart';


class ErrorPage extends StatefulWidget {
  final  int numberError;

  ErrorPage({Key? key, required this.numberError}) : super(key: key); 

  @override
  _ErrorPage createState() => _ErrorPage();
}

class _ErrorPage extends State<ErrorPage> {
  late int number; // variable du numero d'erreur



  @override

  void initState() { // fonction qui s'execute au lancement de la page pour initialiser les variables 
    super.initState();
    number = widget.numberError;
    _namedError(number);
  }

  String message = ''; // variable du message d'erreur
  void _namedError(int number) async { // fonction qui permet de donner un message d'erreur en fonction du numero d'erreur
    if (number == 1) {
      setState(() {
        message = 'No user signed in';
      });
    } else if (number == 2) {
      setState(() {
        message = 'user login faild';
      });
    } else if (number == 3) {
      setState(() {
        message = 'Email or password incorrect';
      });
    } else if (number == 4) {
      setState(() {
       message = 'Email already used';
      });
    } else if (number == 5) {
      setState(() {
        message = 'Invalid email';
      });
    } else if (number == 6) {
      setState(() {
        message = 'Weak password';
      });
    } else { // si le numero d'erreur n'est pas dans la liste
      setState(() {
        message = 'No error ? why are you here ?';
      });
    }
    }


  
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error $message'), // affiche le message d'erreur
            ],
          ),
        )
); 
  }
}

