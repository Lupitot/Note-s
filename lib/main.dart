import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/lectureData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'pages/choiceLogAuth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final mytheme = ThemeData(
      //theme de l'application
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Color.fromARGB(255, 25, 55, 191),
        brightness: Brightness.dark,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 40,
          color: Color.fromARGB(255, 200, 200, 200),
        ),
        displayMedium: TextStyle(
          fontSize: 27,
          color: Color.fromARGB(255, 243, 243, 243),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              Color.fromARGB(223, 32, 142, 34)),
        ),
      ),
    );
    return MaterialApp(
      //application
      title: 'Flutter Demo',
      theme: mytheme,
      home: const MyHomePage(title: 'Note\'s'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      //stream pour verifier si l'utilisateur est connecté
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          //verifie si la connexion est en cours
          return CircularProgressIndicator(); //affiche un cercle de chargement
        } else {
          User? user = snapshot.data; //recupere les données de l'utilisateur

          if (user != null) {
            return Scaffold(
              appBar: AppBar(
                title: Text(widget.title,
                    style: Theme.of(context).textTheme.displayLarge),
                centerTitle: true,
              ),
              body: Center(
                child: Column(
                  children: [
                    const Padding(padding: EdgeInsets.all(30)),
                    FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.uid)
                            .get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text("Loading");
                          }

                          if (snapshot.hasError) {
                            return Text("Something went wrong");
                          }

                          if (snapshot.data == null || !snapshot.data!.exists) {
                            return Text("No data");
                          }

                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          String userName = data['displayName'] ?? 'User';

                          return InkWell(
                            child: Text(
                              'Hello $userName',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          );
                        }),
                    const Padding(padding: EdgeInsets.all(30)),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  LectureData()), //bouton pour aller sur la page de lecture des notes
                        );
                      },
                      child: Container(
                        height: 50,
                        width: 200,
                        child: Center(
                          child: Text(
                            'Notes',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(30)),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                // bouton de deconnexion
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();

                  // verifie si l'utilisateur est deconnecté
                  var user = FirebaseAuth.instance.currentUser;
                  if (user == null) {
                    print("User signed out successfully");
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Choice()), // retourne sur la page de choix de connexion ou d'authentification
                    );
                  } else {
                    print("Failed to sign out");
                  }
                },
                child: Icon(Icons.logout),
              ),
            );
          } else {
            return Choice();
          }
        }
      },
    );
  }
}
