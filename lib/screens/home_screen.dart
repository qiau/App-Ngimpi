import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ngimpi/models/artimimpi_model.dart';
import 'package:ngimpi/screens/addnote_screen.dart';
import 'package:ngimpi/screens/detailarti_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          Image.asset('assets/images/bg_home.png'),
          Center(
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 127,
                  ),
                  _greetings(),
                  const SizedBox(
                    height: 23,
                  ),
                  _card(context),
                  const SizedBox(
                    height: 23,
                  ),
                  _artimimpi()
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

ListView _artimimpi() {
  return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => _arti(context, artimimpi[index], index),
      separatorBuilder: (context, index) => const SizedBox(
            height: 11,
          ),
      itemCount: artimimpi.length);
}

GestureDetector _arti(BuildContext context, ArtimimpiModel artimimpiModel, int index) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailartiScreen(id: index,),
        ),
      );
    },
    child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 24),
        decoration: BoxDecoration(
          color: const Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff000000).withOpacity(0.14),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Image.asset(
                'assets/images/${artimimpiModel.image}',
                height: 70,
                width: 88,
              ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  artimimpiModel.name,
                  style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xff3f3e3f)),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    text: "${artimimpiModel.description}",
                    style: GoogleFonts.manrope(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff3f3e3f),
                    ),
                  ),
                ),
              ],
            )
          ],
        )),
  );
}

AspectRatio _card(BuildContext context) {
  return AspectRatio(
    aspectRatio: 380 / 182,
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [
            Color(0xff31457E),
            Color(0xff6A8EC9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(children: [
        Image.asset(
          'assets/images/aset.png',
          height: double.maxFinite,
          width: double.maxFinite,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: "Mimpimu unik dan\npenuh teka-teki?",
                  style: GoogleFonts.manrope(
                    fontSize: 18,
                    color: const Color(0xffFFFFFF),
                    height: 1.3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              RichText(
                text: TextSpan(
                  text: "Sebelum lupa, yuk segera\ncatat mimpimu di sini.",
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    color: const Color(0xffFFFFFF),
                    height: 1.3,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddnoteScreen()));
                },
                style: ElevatedButton.styleFrom(
                    textStyle: GoogleFonts.manrope(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                )),
                child: const Text('Catatan',
                    style: TextStyle(color: Color(0xff31457E))),
              ),
            ],
          ),
        )
      ]),
    ),
  );
}

Padding _greetings() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      children: [
        Text(
          "Hai, gimana mimpimu?",
          style: GoogleFonts.manrope(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: const Color(0xff3f3e3f)),
        ),
      ],
    ),
  );
}
