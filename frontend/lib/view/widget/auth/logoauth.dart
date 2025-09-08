import 'package:flutter/material.dart';
import 'package:notesapp/core/constant/imageasset.dart';

class LogoAuth extends StatelessWidget {
  const LogoAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0xFF1976D2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ), // انحناء من تحت بس
      ),
      child: Center(
        child: Image.asset(
          AppImageAsset.logo,
          width: 120,
          height: 120,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
