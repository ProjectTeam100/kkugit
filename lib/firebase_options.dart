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
    apiKey: 'AIzaSyCRPYqX5jVcqTIAla4hDThVcE_p0rE5kpA',
    appId: '1:838246255148:web:3a16e70df996e483555f89',
    messagingSenderId: '838246255148',
    projectId: 'kkugit-8eb89',
    authDomain: 'kkugit-8eb89.firebaseapp.com',
    storageBucket: 'kkugit-8eb89.firebasestorage.app',
    measurementId: 'G-7G22MMTYXB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA-_q652WhbbbmiZ0jdzd7Zx8ElsLXcctU',
    appId: '1:838246255148:android:767e5e85c94b5025555f89',
    messagingSenderId: '838246255148',
    projectId: 'kkugit-8eb89',
    storageBucket: 'kkugit-8eb89.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD8E87Kj9VVc6smpAxGovZK5KLD6cAcDWo',
    appId: '1:838246255148:ios:6b4b134f5f21586a555f89',
    messagingSenderId: '838246255148',
    projectId: 'kkugit-8eb89',
    storageBucket: 'kkugit-8eb89.firebasestorage.app',
    iosBundleId: 'com.team100.kkugit',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD8E87Kj9VVc6smpAxGovZK5KLD6cAcDWo',
    appId: '1:838246255148:ios:6b4b134f5f21586a555f89',
    messagingSenderId: '838246255148',
    projectId: 'kkugit-8eb89',
    storageBucket: 'kkugit-8eb89.firebasestorage.app',
    iosBundleId: 'com.team100.kkugit',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCRPYqX5jVcqTIAla4hDThVcE_p0rE5kpA',
    appId: '1:838246255148:web:b39310208906c68c555f89',
    messagingSenderId: '838246255148',
    projectId: 'kkugit-8eb89',
    authDomain: 'kkugit-8eb89.firebaseapp.com',
    storageBucket: 'kkugit-8eb89.firebasestorage.app',
    measurementId: 'G-9R1QLKCVRD',
  );
}
