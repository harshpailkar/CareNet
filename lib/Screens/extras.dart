import 'package:carenet/Screens/homePage.dart';
import 'package:carenet/custom_widgets/date_picker_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Theming/customColors.dart';

String name = "";
String BG_val = 'Select a blood group';
String genderOption = 'Select gender';

class extras_screen extends StatefulWidget {
  @override
  State<extras_screen> createState() => _extras_screenState();
}

class _extras_screenState extends State<extras_screen> {
  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30.w, 20.h, 30.w, 20.h),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 50.h,),
                      SvgPicture.asset(
                        "assets/images/info.svg",
                        width: 35.w,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text("Please enter your information",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Circular',
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700)),
                      SizedBox(
                        height: 50.h,
                      ),
                      TextFormField(
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: CustomColors.grey2),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        controller: nameController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        autofocus: false,
                        validator: (value) {
                          if (value!.length > 20) {
                            return 'Name should be less than 20 characters';
                          } else if (value.isEmpty || value == null)
                            return "Please enter your name";
                          else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'FULL NAME',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelStyle: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "CHOOSE GENDER",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13.5.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            DropdownButton<String>(
                              // validator: ((value) => value == null
                              //     ? 'This field is required'
                              //     : null),
                              borderRadius: BorderRadius.circular(10),
                              elevation: 2,
                              isExpanded: true,
                              value: genderOption,
                              items: <String>[
                                'Select gender',
                                'Male',
                                'Female',
                                'Other',
                                'Rather not say'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  genderOption = newValue!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "DATE OF BIRTH",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13.5.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            DatePickerWidget(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "BLOOD GROUP",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13.5.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            DropdownButton<String>(
                              // validator: ((value) => value == null
                              //     ? 'This field is required'
                              //     : null),
                              borderRadius: BorderRadius.circular(10),
                              elevation: 2,
                              isExpanded: true,
                              value: BG_val,
                              items: <String>[
                                'Select a blood group',
                                'O+',
                                'O-',
                                'A+',
                                'A-',
                                'B+',
                                'B-',
                                'AB+',
                                'AB-'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  BG_val = newValue!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      SizedBox(
                        width: 180.w,
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                //form is valid, proceed further
                                _formKey.currentState!.save();
                                name = nameController.text;
                                createUser(name: name);
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
                                //save once fields are valid, onSaved method invoked for every form fields
      
                              } else {
                                setState(() {
                                  _autovalidate =
                                      true; //enable realtime validation
                                });
                              }
                            },
                            child: Text('Continue')),
                      )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future createUser({ String? name}) async {
  final docUser = FirebaseFirestore.instance.collection('users').doc('my-id');

  final json = {
    'name': name,
    'birtday': date,
    'blood_group': BG_val,
    'gender': genderOption,
  };

  await docUser.set(json);
}
