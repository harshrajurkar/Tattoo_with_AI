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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyBxZ-Sb2it8Y62Xip_g0cRv9pwyiNQK1bs',
    appId: '1:544746278717:web:968b0787e8d59497073f54',
    messagingSenderId: '544746278717',
    projectId: 'tattowebapp',
    authDomain: 'tattowebapp.firebaseapp.com',
    storageBucket: 'tattowebapp.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCVA91ewGMGlBhzfjfm7D-1w26UJJ6Ry_w',
    appId: '1:544746278717:android:5904a1671552ab06073f54',
    messagingSenderId: '544746278717',
    projectId: 'tattowebapp',
    storageBucket: 'tattowebapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDT6mIVFhjUNbDCTiQKWM0oEdT4wgNSku4',
    appId: '1:544746278717:ios:c3d21633484a1fbe073f54',
    messagingSenderId: '544746278717',
    projectId: 'tattowebapp',
    storageBucket: 'tattowebapp.appspot.com',
    iosBundleId: 'com.example.tattoWebapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDT6mIVFhjUNbDCTiQKWM0oEdT4wgNSku4',
    appId: '1:544746278717:ios:c3d21633484a1fbe073f54',
    messagingSenderId: '544746278717',
    projectId: 'tattowebapp',
    storageBucket: 'tattowebapp.appspot.com',
    iosBundleId: 'com.example.tattoWebapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBxZ-Sb2it8Y62Xip_g0cRv9pwyiNQK1bs',
    appId: '1:544746278717:web:a0dbd606280108e0073f54',
    messagingSenderId: '544746278717',
    projectId: 'tattowebapp',
    authDomain: 'tattowebapp.firebaseapp.com',
    storageBucket: 'tattowebapp.appspot.com',
  );

}