// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:carenet/Screens/homePage.dart';

import 'package:carenet/Screens/profile.dart';
import 'package:carenet/Screens/prom_disc.dart';
import 'package:carenet/Theming/customColors.dart';
import 'package:carenet/authentication/email_authentication.dart';
import 'package:carenet/authentication/google_sign_in.dart';
import 'package:carenet/custom_widgets/launchPageMenu.dart';
import 'package:carenet/storage/cloudStorageTest.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LaunchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          // Cases for connection states
        
          if (snapshot.hasError) {
            return Center(
              child: Text("Something went wrong!"),
            );
          } else if (snapshot.hasData)
            return PromDisclosure();

          else
            return SafeArea(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 120.h,
                      ),
                      SvgPicture.asset(
                        "assets/images/AppIcon.svg",
                        width: 110.w,
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Builder(builder: (context) {
                        return Text(
                          "Welcome to CareNet",
                          style: Theme.of(context).textTheme.headline1,
                        );
                      }),
                      SizedBox(
                        height: 50.h,
                      ),
                      LaunchPageMenu(),
                      SizedBox(
                        height: 80.h,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(
                                47.5.w, 12.h, 47.5.w, 12.h)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EmailAuth()),
                          );
                        },
                        child: Builder(builder: (context) {
                          return Text(
                            "Join CareNet",
                            style: Theme.of(context).textTheme.button,
                          );
                        }),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            final provider = Provider.of<GoogleSignInProvider>(
                                context,
                                listen: false);
                            provider.googleLogin();
                          },
                          child: Builder(builder: (context) {
                            return Text(
                              "Login with Google",
                              style: TextStyle(
                                  color: CustomColors.bluebell,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp),
                            );
                          }),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(200),
                                      side: BorderSide(
                                          color: CustomColors.bluebell))))),
                    ],
                  ),
                ),
              ),
            );
        });
  }
}
