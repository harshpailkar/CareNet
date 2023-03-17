import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../Theming/customColors.dart';

class Tag extends StatelessWidget {
  Tag(this.svg_path, this.tag_text);
  String svg_path;
  String tag_text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.grey[300],
      ),
      padding: EdgeInsets.fromLTRB(8.w, 6.h, 8.w, 6.h),
      child: Row(
        children: [
          SvgPicture.asset(
            svg_path,
            width: 16.w,
          ),
          SizedBox(
            width: 4.w,
          ),
          Text(tag_text,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: CustomColors.grey1)),
        ],
      ),
    );
  }
}
