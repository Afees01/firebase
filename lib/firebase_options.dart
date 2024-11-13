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
      case TargetPlatform.iOS:
        return ios;
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
    apiKey: 'AIzaSyCTTYd7LNJ6z4U8Ttuyt01TBFz3Z7anTsA',
    appId: '1:1079193727436:web:36a218227cedc5e1926d69',
    messagingSenderId: '1079193727436',
    projectId: 'sampleluminar',
    authDomain: 'sampleluminar.firebaseapp.com',
    storageBucket: 'sampleluminar.firebasestorage.app',
    measurementId: 'G-5TG9FXRXCJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDg9PBWDQzQDk_aI2SQeKU34G9D6U7UtQM',
    appId: '1:1079193727436:android:433b22b4498ff7cd926d69',
    messagingSenderId: '1079193727436',
    projectId: 'sampleluminar',
    storageBucket: 'sampleluminar.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBWf4mAwfmGGF6ZN0u9nKzH8ndMb9yqe54',
    appId: '1:1079193727436:ios:4b1049b5093304ff926d69',
    messagingSenderId: '1079193727436',
    projectId: 'sampleluminar',
    storageBucket: 'sampleluminar.firebasestorage.app',
    iosBundleId: 'com.example.firebase',
  );
}