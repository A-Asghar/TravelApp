import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fyp/Constants.dart';
import 'package:fyp/providers/loading_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomAnimatedText extends StatelessWidget {

  const CustomAnimatedText({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        SizedBox(
        width: 20.0,
      ),
      DefaultTextStyle(
          style: const TextStyle(
            fontSize: 20.0,
          ),
          child: AnimatedTextKit(
              repeatForever: true,

              animatedTexts: [
          TypewriterAnimatedText(context.read<LoadingProvider>().loadingUpdate,
          speed: Duration(milliseconds: 50),
          textStyle: GoogleFonts.poppins(
              fontSize: 24.0, color: Constants.primaryColor),
          // textStyle: const TextStyle(
          //     color: Constants.primaryColor,
          //     fontSize: 20,)),
          ),
          ],

          onTap: () {
    print("I am executing");
    },
    ),

    ),
    SizedBox(
    width: 20.0,
    ),
    ]
    ,
    )
    ,
    );
  }
}
