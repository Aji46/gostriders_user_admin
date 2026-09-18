// File generated normally by the FlutterFire CLI.
//
// ⚠️ IMPORTANT — READ ME FIRST ⚠️
// This is a PLACEHOLDER. Replace this entire file automatically by running:
//
//   dart pub global activate flutterfire_cli
//   flutterfire configure
//
// ...from the project root, after creating a Firebase project at
// https://console.firebase.google.com and enabling:
//   - Authentication (Email/Password provider) — for the hidden admin login
//   - Cloud Firestore — for storing products
//   - Storage — for product photos
//
// The command above will overwrite this file with your real project's
// API keys and IDs, and will also register a Web app automatically.
// See README.md for the full step-by-step setup guide.

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform. '
          'Run `flutterfire configure` to generate a real firebase_options.dart.',
        );
    }
  }

  // ---- PLACEHOLDER VALUES — replace by running `flutterfire configure` ----

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBYz_07oYAsVCWgmrNcHtzqTux9NSV9xpY',
    appId: '1:307034200211:web:72c72e85f4b73386efd566',
    messagingSenderId: '307034200211',
    projectId: 'gostrider-f27d7',
    authDomain: 'gostrider-f27d7.firebaseapp.com',
    storageBucket: 'gostrider-f27d7.firebasestorage.app',
    measurementId: 'G-2KEGZ2PBNV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCzw0E43DsvBNj0BVfOiV_ds9vAcyfjkl8',
    appId: '1:307034200211:android:6e7bb079e819f689efd566',
    messagingSenderId: '307034200211',
    projectId: 'gostrider-f27d7',
    storageBucket: 'gostrider-f27d7.firebasestorage.app',
  );
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBxkeuHVrofaHX8WXoI4VxrLLtx4Ju6-4Y',
    appId: '1:307034200211:ios:fd4f85ccb8802da6efd566',
    messagingSenderId: '307034200211',
    projectId: 'gostrider-f27d7',
    storageBucket: 'gostrider-f27d7.firebasestorage.app',
    iosBundleId: 'com.example.gostriders',
  );
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBxkeuHVrofaHX8WXoI4VxrLLtx4Ju6-4Y',
    appId: '1:307034200211:ios:fd4f85ccb8802da6efd566',
    messagingSenderId: '307034200211',
    projectId: 'gostrider-f27d7',
    storageBucket: 'gostrider-f27d7.firebasestorage.app',
    iosBundleId: 'com.example.gostriders',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBYz_07oYAsVCWgmrNcHtzqTux9NSV9xpY',
    appId: '1:307034200211:web:f7fa15cf76ac8cb8efd566',
    messagingSenderId: '307034200211',
    projectId: 'gostrider-f27d7',
    authDomain: 'gostrider-f27d7.firebaseapp.com',
    storageBucket: 'gostrider-f27d7.firebasestorage.app',
    measurementId: 'G-CFZDJ83VQ8',
  );
}
