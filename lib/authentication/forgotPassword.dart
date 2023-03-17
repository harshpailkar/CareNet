import 'package:carenet/authentication/util_showSnackBar.dart';
import 'package:carenet/authentication/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Theming/customColors.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
                  child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.fromLTRB(30.w, 20.h, 30.w, 20.h),
              child: Column(children: [
                SizedBox(height: 200.h,),
                SvgPicture.asset("assets/images/forgotPassword.svg"),
                SizedBox(height: 20.h,),
                Text("Forgot your password?",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Circular',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700)),
                        SizedBox(height: 15.h,),
                SizedBox(
                    width: 250.w,
                    child: Text(
                      "Enter your email address to retreive your password!",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                    )),
                    SizedBox(height: 30.h,),
                TextFormField(
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (input) => input!.isValidEmail()
                      ? null
                      : "Enter a valid email address",
                  decoration: InputDecoration(
                    hintText: "Enter your email here",
                    hintStyle: TextStyle(
                      color: CustomColors.grey2,
                      fontSize: 15.sp
                    ),
                      // labelText: 'EMAIL',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      // labelStyle: TextStyle(
                      //     fontSize: 18.sp,
                      //     color: CustomColors.grey2,
                      //     fontWeight: FontWeight.w500)
                      ),
                ),
                SizedBox(height: 25.h,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => resetPassword(),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 2.h, 0, 2.h),
                        child: Text(
                          "Reset Password",
                          style: Theme.of(context).textTheme.button,
                        ),
                      )),
                ),
              ]),
            ),
                  ),
                ),
          )),
    );
  }

  Future resetPassword() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      Utils.showSnackBar("Password Reset email sent!",Colors.green);
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on Exception catch (e) {
      // TODO
      print(e);
      Utils.showSnackBar(e.toString(), Colors.red);
    }
  }
}
