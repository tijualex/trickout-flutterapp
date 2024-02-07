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
    apiKey: 'AIzaSyADIhwDRz1OYr-QpgP9TlnTFC5XJLBihGI',
    appId: '1:666444474968:web:6859e4de59357c9469b82d',
    messagingSenderId: '666444474968',
    projectId: 'trickout-398809',
    authDomain: 'trickout-398809.firebaseapp.com',
    storageBucket: 'trickout-398809.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCmeVSjP-VoVfn1Sd5eVowFiG6gP8ifOV8',
    appId: '1:666444474968:android:2b8f7e88c530a54d69b82d',
    messagingSenderId: '666444474968',
    projectId: 'trickout-398809',
    storageBucket: 'trickout-398809.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCQDQ5KGRUxY1Aj2j-tm6TBuC9v84hKWtk',
    appId: '1:666444474968:ios:575748683bde97a869b82d',
    messagingSenderId: '666444474968',
    projectId: 'trickout-398809',
    storageBucket: 'trickout-398809.appspot.com',
    androidClientId: '666444474968-fm9dgb5m9epel89ng64j5g23931e62lp.apps.googleusercontent.com',
    iosBundleId: 'com.example.trickout',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCQDQ5KGRUxY1Aj2j-tm6TBuC9v84hKWtk',
    appId: '1:666444474968:ios:9309568bd5dae6ff69b82d',
    messagingSenderId: '666444474968',
    projectId: 'trickout-398809',
    storageBucket: 'trickout-398809.appspot.com',
    androidClientId: '666444474968-fm9dgb5m9epel89ng64j5g23931e62lp.apps.googleusercontent.com',
    iosBundleId: 'com.example.trickout.RunnerTests',
  );
}
