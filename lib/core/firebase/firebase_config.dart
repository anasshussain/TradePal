import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBFW_3wKDt4NlGUZdZaLDACPGP2zVKHR4s",
            authDomain: "trade-connect-x1mzbx.firebaseapp.com",
            projectId: "trade-connect-x1mzbx",
            storageBucket: "trade-connect-x1mzbx.firebasestorage.app",
            messagingSenderId: "684653929102",
            appId: "1:684653929102:web:7c853f7e6249f6a0ecdfdf",
            measurementId: "G-V9RF9MGX34"));
  } else {
    await Firebase.initializeApp();
  }
}
