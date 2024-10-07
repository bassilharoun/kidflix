import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kidflix_app/app/styles/color.dart';
import 'package:kidflix_app/app/styles/styles.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      this.labelText,
      this.hintText,
      this.onChanged,
      this.canUnObsecure = false,
      this.isObsecure = false,
      this.controller,
      this.validator,
      this.maxLines = 1,
      this.suffixIcon = const SizedBox(),
      this.prefixIcon = const SizedBox(),
      this.focusNode,
      this.keyboardType = TextInputType.text});
  final String? labelText;
  final String? hintText;
  final bool canUnObsecure;
  final void Function(String)? onChanged;
  final bool isObsecure;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int maxLines;
  final Widget suffixIcon;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final Widget prefixIcon;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool isObscureText;

  @override
  void initState() {
    super.initState();
    isObscureText = widget.isObsecure;
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   widget.controller?.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      key: widget.key,
      validator: widget.validator,
      controller: widget.controller,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      obscureText: isObscureText,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.canUnObsecure
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isObscureText = !isObscureText;
                  });
                },
                icon: Icon(
                  isObscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
              )
            : widget.suffixIcon,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: widget.labelText,
        labelStyle: AppStyles.style16Medium(
          FontFamily.FIGTREE,
          color: Colors.grey,
        ).copyWith(fontWeight: FontWeight.bold),
        hintText: widget.hintText,
        hintStyle: AppStyles.style16Medium(
          FontFamily.FIGTREE,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.sp),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.sp),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.sp),
          borderSide: BorderSide(
            color: AppColors.blue,
            width: 2,
          ),
        ),
      ),
    );
  }
}
