import 'package:carenet/authentication/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Strings.dart';
import '../Theming/customColors.dart';
import 'email_login_widget.dart';
import 'util_showSnackBar.dart';

class SignUpWidget extends StatefulWidget {
  final VoidCallback onClickedSignIn;
  const SignUpWidget({Key? key,  required this.onClickedSignIn})
      : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.fromLTRB(30.w, 20.h, 30.w, 20.h),
      child: SafeArea(
        child: Form(
          key: formGlobalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 100.h, 0, 0),
                child: Text(
                  Strings.signUp,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),

              SizedBox(
                height: 36.h,
              ),

              // EMAIL ADDRESS
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
                    labelText: 'EMAIL',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelStyle: TextStyle(
                        fontSize: 18.sp,
                        color: CustomColors.grey2,
                        fontWeight: FontWeight.w500)),
              ),

              SizedBox(height: 15.h),

              // PASSWORD
              TextFormField(
                validator: (text) {
                  if (text == null || text.isEmpty)
                    return "Please enter password";
                  return null;
                },
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.visiblePassword,
                obscureText: !_passwordVisible,
                controller: passwordController,
                decoration: InputDecoration(
                    suffixIcon: InkWell(
                      splashColor: Colors.transparent,
                      onTap: () => setState(
                        () => _passwordVisible = !_passwordVisible,
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 15.h, 0, 0),
                        child: Icon(
                          _passwordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: CustomColors.grey2,
                          size: 18,
                        ),
                      ),
                    ),
                    labelText: 'PASSWORD',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelStyle: TextStyle(
                        fontSize: 18.sp,
                        color: CustomColors.grey2,
                        fontWeight: FontWeight.w500)),
              ),

              SizedBox(height: 15.h),

              // CONFIRM PASSWORD
              TextFormField(
                validator: (text) {
                  if (text == null || text.isEmpty)
                    return "Please confirm enter password";
                  else if (passwordController.text !=
                      confirmPasswordController.text)
                    return "Passwords do not match. Please try again :)";
                  else
                    return null;
                },
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.visiblePassword,
                obscureText: !_passwordVisible,
                controller: confirmPasswordController,
                decoration: InputDecoration(
                    suffixIcon: InkWell(
                      splashColor: Colors.transparent,
                      onTap: () => setState(
                        () => _passwordVisible = !_passwordVisible,
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 15.h, 0, 0),
                        child: Icon(
                          _passwordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: CustomColors.grey2,
                          size: 18,
                        ),
                      ),
                    ),
                    labelText: 'CONFIRM PASSWORD',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelStyle: TextStyle(
                        fontSize: 18.sp,
                        color: CustomColors.grey2,
                        fontWeight: FontWeight.w500)),
              ),

              SizedBox(height: 25.h),

              

              SizedBox(
                height: 30.h,
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      onPressed:

                      // conditionals here
                      if (formGlobalKey.currentState!.validate()) {
                        print("Success");
                      } else
                        print("Unsucessfull");
                      signUp();
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 2.h, 0, 2.h),
                      child: Text(
                        "SIGN UP",
                        style: Theme.of(context).textTheme.button,
                      ),
                    )),
              ),

              SizedBox(height: 20.h),

              Align(
                  alignment: Alignment.center,
                  child: RichText(
                      text: TextSpan(
                          style: TextStyle(
                              color: CustomColors.grey1,
                              fontFamily: 'Circular',
                              fontSize: 14.sp),
                          text: "Already have an account? ",
                          children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.onClickedSignIn,
                            text: "Log In",
                            style: TextStyle(
                                color: CustomColors.bluebell,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500))
                      ]))),
            ],
          ),
        ),
      ),
    );
  }

  Future signUp() async {
    // showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (context) => Center(
    //           child: CircularProgressIndicator(),
    //         ));

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
          Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e.code.toString());
      switch (e.code) {
        case "email-already-in-use":
          // ignore: deprecated_member_use
          Utils.showSnackBar(e.message!, Colors.red);
          break;
      }
    }
  }
}
