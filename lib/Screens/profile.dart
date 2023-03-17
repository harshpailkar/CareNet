import 'package:carenet/Theming/customColors.dart';
import 'package:carenet/authentication/google_sign_in.dart';
import 'package:carenet/custom_widgets/prof_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Profile",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w800
        ),),
      ),
      body: Padding(
    padding: EdgeInsets.fromLTRB(30.w, 20.h, 30.w, 20.h),
    child: Center(
        child: Column(
      children: [
        SizedBox(height: 30.h,),
        CircleAvatar(
            radius: 40.w, backgroundImage: NetworkImage(user!.photoURL!)),
            SizedBox(height: 18.h,),
        Text(
          user.displayName!,
          style: TextStyle(
              color: Colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700),
        ),
         SizedBox(height: 4.h,),
        Text(
          user.email!,
          style: TextStyle(
              color: CustomColors.grey2,
              fontSize: 15.sp,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 20.h,),
        Align(
          alignment: Alignment.centerLeft,
          child: Text("Settings",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Circular',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700)),
        ),
        SizedBox(height: 25.h,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfButton("Update Profile", () {}),
            SizedBox(height: 5.h,),
            Divider(
              color: CustomColors.grey2,
            ),
            SizedBox(height: 2.5.h,),
            ProfButton("Language", () {}),
            SizedBox(height: 2.5.h,),
            Divider(color: CustomColors.grey2),
            SizedBox(height: 2.5.h,),
            ProfButton("Terms of Service", () {}),
          ],
        ),
        SizedBox(height: 100.h,),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {
                final provider = Provider.of<GoogleSignInProvider>(context,
                    listen: false);
                provider.logout();
              },
              child: Text("LOG OUT")),
        )
      ],
    )),
      ),
    );
  }
}
