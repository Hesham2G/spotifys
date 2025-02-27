// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    
      
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDwxQPdGbSiD5dcVGh88R23lGMImKCxtKs',
    appId: '1:426509858399:web:4b4738cef4e35016264dea',
    messagingSenderId: '426509858399',
    projectId: 'spotify0101',
    authDomain: 'spotify0101.firebaseapp.com',
    storageBucket: 'spotify0101.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDiKnAKwGnmt5KO56MT1gMYyGPV1TT0_ss',
    appId: '1:836665328683:android:cb21fca1dcb263f6d5166e',
    messagingSenderId: '836665328683',
    projectId: 'spotify-59b62',
    storageBucket: 'spotify-59b62.firebasestorage.app',
  );

 
  
 
}
