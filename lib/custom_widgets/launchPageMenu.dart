import 'package:carenet/Strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LaunchPageMenu extends StatelessWidget {
  double icon_width = 14.w;
  double icon_spacing = 10.w;
  double line_spacing = 5.h;
  double menu_left_spacing = 85.w;
  

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width)/4.5;
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: width),
            SvgPicture.asset(
              "assets/images/download.svg",
              width: icon_width,
            ),
            SizedBox(
              width: icon_spacing,
            ),
            Builder(builder: (context) {
              return Text(Strings.menu1,
                  style: Theme.of(context).textTheme.bodyText1);
            })
          ],
        ),
        SizedBox(height: line_spacing),
        Row(
          children: [
            SizedBox(width: width),
            SvgPicture.asset(
              "assets/images/location.svg",
              width: icon_width,
            ),
            SizedBox(
              width: icon_spacing,
            ),
            Builder(builder: (context) {
              return Text(Strings.menu2,
                  style: Theme.of(context).textTheme.bodyText1);
            })
          ],
        ),
        SizedBox(height: line_spacing),
        Row(
          children: [
            SizedBox(width: width),
            SvgPicture.asset(
              "assets/images/bills.svg",
              width: icon_width,
            ),
            SizedBox(
              width: icon_spacing,
            ),
            Builder(builder: (context) {
              return Text(Strings.menu3,
                  style: Theme.of(context).textTheme.bodyText1);
            })
          ],
        ),
        SizedBox(height: line_spacing),
        Row(
          children: [
            SizedBox(width: width),
            SvgPicture.asset(
              "assets/images/pills.svg",
              width: icon_width,
            ),
            SizedBox(
              width: icon_spacing,
            ),
            Builder(builder: (context) {
              return Text(Strings.menu4,
                  style: Theme.of(context).textTheme.bodyText1);
            })
          ],
        ),
      ],
    );
  }
}
