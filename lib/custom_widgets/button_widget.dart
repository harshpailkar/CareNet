import 'package:carenet/Theming/customColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ButtonHeaderWidget extends StatelessWidget {
//   final String title;
//   final String text;
//   final VoidCallback onClicked;

//   const ButtonHeaderWidget({
//     Key? key,
//     required this.title,
//     required this.text,
//     required this.onClicked,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) => HeaderWidget(
//         title: title,
//         child: ButtonWidget(
//           text: text,
//           onClicked: onClicked,
//         ),
//       );
// }

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
     required this.text,
     required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClicked,
      child: Container(
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.sp),
        color: Colors.grey[300],
      ),
      padding: EdgeInsets.fromLTRB(10.w, 6.h, 10.w, 6.h),
        child: Text(text,
        style: TextStyle(color: CustomColors.grey1, fontWeight: FontWeight.w500,
        fontSize: 15.sp),),
      ),
    );
  }
}

// class HeaderWidget extends StatelessWidget {
//   final String title;
//   final Widget child;

//   const HeaderWidget({
//     Key? key,
//     required this.title,
//     required this.child,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               color: Colors.amber,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
          
//           child,
//         ],
//       );
// }
