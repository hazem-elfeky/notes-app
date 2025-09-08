import 'package:flutter/material.dart';
import 'package:notesapp/core/app_theme.dart' as AppColor;

class CustomTextSignUpOrSignIn extends StatelessWidget {
  final String textone;
  final String texttwo;
  final void Function() onTap;
  const CustomTextSignUpOrSignIn({
    Key? key,
    required this.textone,
    required this.texttwo,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(textone),
        InkWell(
          onTap: onTap,
          child: Text(
            texttwo,
            style: TextStyle(
              color: AppColor.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
