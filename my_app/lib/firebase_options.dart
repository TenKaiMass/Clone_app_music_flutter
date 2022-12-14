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
    apiKey: 'AIzaSyAUzfM5orCwWb-GRuSTwv3AyaAtH1N3yrY',
    appId: '1:103564141887:web:29627544b32b4b403b1f8a',
    messagingSenderId: '103564141887',
    projectId: 'usic-be953',
    authDomain: 'usic-be953.firebaseapp.com',
    storageBucket: 'usic-be953.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDeU5GzlPMTrzq2Y89Ro0KPUeKFmXZQkv4',
    appId: '1:103564141887:android:efbfe9512e7047c83b1f8a',
    messagingSenderId: '103564141887',
    projectId: 'usic-be953',
    storageBucket: 'usic-be953.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCxTcWYgCPNrUDBjgssytzJNY9rjZGcoVw',
    appId: '1:103564141887:ios:b669368750275cf83b1f8a',
    messagingSenderId: '103564141887',
    projectId: 'usic-be953',
    storageBucket: 'usic-be953.appspot.com',
    iosClientId: '103564141887-l2gbuhq0a2voca1qlgklgnekiuhcmvoe.apps.googleusercontent.com',
    iosBundleId: 'com.example.myApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCxTcWYgCPNrUDBjgssytzJNY9rjZGcoVw',
    appId: '1:103564141887:ios:b669368750275cf83b1f8a',
    messagingSenderId: '103564141887',
    projectId: 'usic-be953',
    storageBucket: 'usic-be953.appspot.com',
    iosClientId: '103564141887-l2gbuhq0a2voca1qlgklgnekiuhcmvoe.apps.googleusercontent.com',
    iosBundleId: 'com.example.myApp',
  );
}
