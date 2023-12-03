import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../popupAdd.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../popupEdit.dart';
import 'package:permission_handler/permission_handler.dart';

class LectureData extends StatelessWidget {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future uploadFile() async {
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download-Link: $urlDownload');
  }

  Future selectFile() async {
    var status = await Permission.storage.status; // vérifie si l'application a accés au stockage
    if (!status.isGranted) {
      status = await Permission.storage.request(); // demande l'accés au stockage

      if (!status.isGranted) {
        print("Permission denied");
        return;
      }
    }

    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setStat() {
      pickedFile = result.files.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser?.uid ??
        ''; // récupére l'uid de l'utilisateur connecté
    CollectionReference notes = FirebaseFirestore.instance.collection(
        'notes_$uid'); // récupére la collection de notes de l'utilisateur connecté

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: Column(
        children: [
          Column(
            children: [
              if (pickedFile != null)
                Expanded(
                  child: Container(
                  color: Colors.red,
                  child: Image.file(
                    File(pickedFile!.path!),
                      width: double.infinity,
                       fit: BoxFit.cover),
                  ),
                ),
              const Padding(padding: EdgeInsets.all(30)),
              ElevatedButton(
                  onPressed: selectFile, child: const Text('Select file')),
              const Padding(padding: EdgeInsets.all(30)),
              ElevatedButton(
                  onPressed: uploadFile, child: const Text('Upload file')),
            ],
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
            // StreamBuilder permet de mettre à jour la liste de notes en temps réel
            stream: notes.snapshots(),

            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return ListView(
                // liste de notes
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String,
                      dynamic>; // récupére les données de la note
                  return ListTile(
                      title: Text(data['title'] != null
                          ? data['title']
                          : ''), // affiche le titre de la note
                      subtitle: Text(data['content'] != null
                          ? data['content']
                          : ''), // affiche le contenu de la note
                      leading: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          await notes
                              .doc(document.id)
                              .delete(); // supprime la note
                        },
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // ouvre la popup d'edit de la note
                          showDialog(
                              context: context,
                              builder: (buildcontext) => EditTaskDialog(
                                  docId: document.id,
                                  previousTitle: data['title'],
                                  previousContent: data['content']));
                        },
                      ));
                }).toList(),
              );
            },
          ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // bouton d'ajout de note
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (buildcontext) =>
                  AddTaskDialog()); // ouvre la popup d'ajout de note
        },
      ),
    );
  }
}
