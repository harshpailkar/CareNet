import 'package:carenet/Screens/extras.dart';
import 'package:carenet/Screens/homePage.dart';
import 'package:carenet/Theming/customColors.dart';
import 'package:carenet/custom_widgets/prom_disc_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Strings.dart';

class PromDisclosure extends StatefulWidget {
  const PromDisclosure({Key? key}) : super(key: key);

  @override
  State<PromDisclosure> createState() => _PromDisclosureState();
}

class _PromDisclosureState extends State<PromDisclosure> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.fromLTRB(30.w, 20.h, 30.w, 20.h),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: 100.h,
              ),
              SvgPicture.asset("assets/images/AppIcon.svg"),
              SizedBox(
                height: 20.h,
              ),
              Text("Prominent Disclosure",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Circular',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700)),
              SizedBox(
                height: 20.h,
              ),
              Text(
                Strings.prom_disc,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
              ),

              SizedBox(
                height: 25.h,
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Text("DOCUMENT STORAGE PERMISSIONS",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Circular',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700)),
              ),

              SizedBox(
                height: 5.h,
              ),

              Row(
                children: [
                  Tag("assets/images/gallery.svg", "Picture Gallery"),
                  SizedBox(
                    width: 5.w,
                  ),
                  Tag("assets/images/files.svg", "File Storage"),
                ],
              ),
              SizedBox(
                height: 12.5.h,
              ),

              Divider(color: CustomColors.grey2,),

              SizedBox(
                height: 12.5.h,
              ),


              Align(
                alignment: Alignment.centerLeft,
                child: Text("LOCATION TRACKING & SERVICES",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Circular',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700)),
              ),
               SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  Tag("assets/images/location2.svg", "Location"),
                  SizedBox(
                    width: 5.w,
                  ),
                ],
              ),
              SizedBox(
                height: 12.5.h,
              ),

              Divider(color: CustomColors.grey2,),

              SizedBox(
                height: 12.5.h,
              ),
              
              Align(
                alignment: Alignment.centerLeft,
                child: Text("REMINDER SERVICE",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Circular',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700)),
              ),

              SizedBox(
                height: 5.h,
              ),
              
               
              Row(
                children: [
                  Tag("assets/images/reminder.svg", "Calender Access"),
                  SizedBox(
                    width: 5.w,
                  ),
                ],
              ),

              SizedBox(height: 199.h,),

              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(onPressed: ()=>
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => extras_screen())), 
                child: Text("Proceed")))
            ],
          ),
        ),
      )),
    );
  }
}
