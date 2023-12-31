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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
      apiKey: "AIzaSyCm_3Pk_nrQt0iS68WBRwG4gRE8FL1pvio",
      authDomain: "farmerally-users.firebaseapp.com",
      projectId: "farmerally-users",
      storageBucket: "farmerally-users.appspot.com",
      messagingSenderId: "911024547681",
      appId: "1:911024547681:web:e56be0bf55beabe7e38720",
      measurementId: "G-YVW30R9QDJ"
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDNtPel6-WB7TOX9G3ejqOnHM_r28S9DBY',
    appId: '1:506316658825:android:9b013473711a24ffa44e58',
    messagingSenderId: '506316658825',
    projectId: 'temp-5a288',
    storageBucket: 'temp-5a288.appspot.com',
  );
}
