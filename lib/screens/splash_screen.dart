import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ngimpi/dashboard.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 0)).then((value) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const Dashboard(),
          ),
          (route) => false);
    });

    return Scaffold(
      body: Stack(children: [
        Image.asset('assets/images/bg.png'),
        Center(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 70,
                ),
                SvgPicture.asset(
                  'assets/logo/logo.svg',
                  height: 40,
                ),
                const SizedBox(
                  height: 110,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Catat semua",
                    style: GoogleFonts.manrope(
                      fontSize: 32,
                      color: const Color(0xff31457E),
                      height: 1.1,
                    ),
                    children: const [
                      TextSpan(
                          text: "\nmimpi ",
                          style: TextStyle(fontWeight: FontWeight.w900)),
                      TextSpan(
                        text: "indahmu!",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
