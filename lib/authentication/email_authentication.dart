// ignore_for_file: prefer_const_constructors

import 'package:carenet/Screens/extras.dart';
import 'package:carenet/Screens/prom_disc.dart';
import 'package:carenet/authentication/authPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return PromDisclosure();
              } else if (snapshot.hasError) {
                return Center(
                  child: SnackBar(
                    content: Text("An error occured! Please try again."),
                  ),
                );
              } else {
                return AuthPage();
              }
            }),
      ),
    );
  }
}
