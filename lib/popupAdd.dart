import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddTaskDialog extends StatelessWidget {
  CollectionReference notes = FirebaseFirestore.instance.collection('notes'); // récupére la collection de notes de l'utilisateur connecté
  final _textController = TextEditingController();
  final _textController2 = TextEditingController();

  AddTaskDialog({Key? key}) : super(key: key);

  Future<void> _addNote() async {
    if (_textController.text.isNotEmpty && _textController2.text.isNotEmpty) { // si les champs de texte ne sont pas vides
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) { // si l'utilisateur est connecté
        await FirebaseFirestore.instance.collection('notes_${user.uid}').add({ // ajoute la note dans la base de données
          'title': _textController.text,
          'content': _textController2.text,
        });
      } else {
        print("No user signed in");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 300,
        height: 400,
        child: AlertDialog(
          title: const Text(
            'Ajout note',
            style: TextStyle(
              color: Color.fromARGB(223, 32, 142, 34),
              fontSize: 30,
            ),
          ),
          content: Column(
            children: [
              TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(223, 32, 142, 34),
                      width: 2,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelText: 'Titre de la note',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(223, 238, 238, 238),
                  ),
                  hintText: 'Exemple : Note 1',
                  hintStyle: TextStyle(
                    color: Color.fromARGB(98, 203, 203, 203),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.all(20)),
              TextField(
                controller: _textController2,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(223, 32, 142, 34),
                      width: 2,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelText: 'Contenu de la note',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(223, 238, 238, 238),
                  ),
                  hintText: 'Exemple : Je suis une note',
                  hintStyle: TextStyle(
                    color: Color.fromARGB(98, 203, 203, 203),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[ // bouton pour valider l'ajout de la note
            TextButton(
              onPressed: () async {
                await _addNote();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Ok',
                style: TextStyle(
                  color: Color.fromARGB(223, 32, 142, 34),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
