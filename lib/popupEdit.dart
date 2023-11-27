import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditTaskDialog extends StatelessWidget {
  CollectionReference notes = FirebaseFirestore.instance.collection('notes'); // récupére la collection de notes de l'utilisateur connecté
  final String docId; // id de la note à modifier
  final String previousTitle; // titre de la note avant modification
  final String previousContent; // contenu de la note avant modification

  final TextEditingController _textController;
  final TextEditingController _textController2;

  EditTaskDialog(
      {Key? key,
      required this.docId,
      required this.previousTitle,
      required this.previousContent})
      : _textController = TextEditingController(text: previousTitle),
        _textController2 = TextEditingController(text: previousContent),
        super(key: key);

  Future<void> _editNote() async { // fonction pour modifier la note
    if (_textController.text.isNotEmpty && _textController2.text.isNotEmpty) {
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance // modifie la note dans la base de données
            .collection('notes_${user.uid}')
            .doc(docId)
            .update({
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
        width: 330,
        height: 600,
        child: AlertDialog(
          title: const Text(
            'Edit note',
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
                  labelText: 'Titre modifié ?',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(223, 238, 238, 238),
                  ),
                  hintText: 'Exemple : titre modif 1',
                  hintStyle: TextStyle(
                    color: Color.fromARGB(98, 203, 203, 203),
                  ),
                ),
              ),  
              const Padding(padding: EdgeInsets.all(15)),

                Expanded(
                  child: TextField(
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
                      labelText: 'Contenu modifié ?',
                      labelStyle: TextStyle(
                        color: Color.fromARGB(223, 238, 238, 238),
                      ),
                      hintText: 'Exemple : Je suis modifié :)',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(98, 203, 203, 203),
                      ),
                    ),
                    maxLines:
                        null, 
                  ),
                ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                await _editNote();
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
