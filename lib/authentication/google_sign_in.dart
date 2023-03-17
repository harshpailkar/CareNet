import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  // Getter to get USER_INFO
  GoogleSignInAccount? get user => _user;

  // Google Method executed on clicking the button
  Future googleLogin() async {
    //Waiting for account selection
    final googleUser = await googleSignIn.signIn();

    // If account is not selected
    if (googleUser == null)
      return;
    else
      _user = googleUser;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    // Updating the UI with Listeners
    notifyListeners();
  }

  Future logout() async {
    // await googleSignIn.disconnect();
    // FirebaseAuth.instance.signOut();

    await googleSignIn.disconnect().whenComplete(() async {
      await FirebaseAuth.instance.signOut();
    });
  }
}
