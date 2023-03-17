import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Theming/customColors.dart';

class ProfButton extends StatelessWidget {
  ProfButton(this.text, this.function);
  String text;
  VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Text(
        text,
        style: TextStyle(
            color: CustomColors.grey2,
            fontWeight: FontWeight.w400,
            fontSize: 17.sp),
      ),
    );
  }
}
