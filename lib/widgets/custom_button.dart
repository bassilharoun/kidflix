import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kidflix_app/app/styles/color.dart';
import 'package:kidflix_app/app/styles/styles.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.data,
    required this.onPressed,
    this.backGroundColor,
    this.style,
    this.borderColor,
    this.height,
    this.leading,
  });
  final String data;
  final void Function()? onPressed;
  final Color? backGroundColor;
  final Color? borderColor;
  final TextStyle? style;
  final double? height;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 45.h,
      width: double.infinity,
      child: MaterialButton(
        elevation: 0,
        onPressed: onPressed,
        color: backGroundColor ?? AppColors.purble,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.sp),
          side: borderColor == null
              ? BorderSide.none
              : BorderSide(color: borderColor!),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leading != null) leading!,
            Text(
              data,
              style: style ??
                  AppStyles.style16Medium(
                    FontFamily.FIGTREE,
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

// class CustomButton extends StatelessWidget {
//   final String text;
//   final Function()? function;
//   const CustomButton({super.key, required this.text, required this.function});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: function,
//       child: Container(
//         height: 40.h,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12.sp),
//           gradient: function == null
//               ? LinearGradient(
//                   colors: [
//                     Colors.grey.shade400,
//                     Colors.grey,
//                   ],
//                 )
//               : const LinearGradient(
//                   colors: [
//                     Color.fromARGB(255, 36, 105, 255),
//                     Color.fromARGB(255, 214, 19, 204),
//                   ],
//                 ),
//         ),
//         child: Center(
//           child: Text(
//             text,
//             style: const TextStyle(
//                 color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
//           ),
//         ),
//       ),
//     );
//   }
// }
