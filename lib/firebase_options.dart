// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyACv8tVNZyLhFAckeMMPIENdza9Zie3Vnc',
    appId: '1:53442563605:web:a2149c1cbdcdcba718c81c',
    messagingSenderId: '53442563605',
    projectId: 'notes-5cdee',
    authDomain: 'notes-5cdee.firebaseapp.com',
    storageBucket: 'notes-5cdee.appspot.com',
    measurementId: 'G-VWT4697CN9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAG66NMnDEEJopd7vCdQ8GMISCZqcr4NpU',
    appId: '1:53442563605:android:5aec654851f22d1918c81c',
    messagingSenderId: '53442563605',
    projectId: 'notes-5cdee',
    storageBucket: 'notes-5cdee.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAcTn2dxwCZj8L4acVFM0drRnH2U66mK5o',
    appId: '1:53442563605:ios:da814d799efe133718c81c',
    messagingSenderId: '53442563605',
    projectId: 'notes-5cdee',
    storageBucket: 'notes-5cdee.appspot.com',
    iosBundleId: 'com.example.notes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAcTn2dxwCZj8L4acVFM0drRnH2U66mK5o',
    appId: '1:53442563605:ios:fc4ee6af08d1815a18c81c',
    messagingSenderId: '53442563605',
    projectId: 'notes-5cdee',
    storageBucket: 'notes-5cdee.appspot.com',
    iosBundleId: 'com.example.notes.RunnerTests',
  );
}