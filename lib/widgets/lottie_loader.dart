import 'package:flutter/material.dart';
import 'package:fyp/widgets/custom_animated_text.dart';
import 'package:fyp/widgets/poppinsText.dart';
import 'package:lottie/lottie.dart';
import 'package:fyp/providers/loading_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

Widget lottieLoader(BuildContext context) {
  print("lottie load" + context.read<LoadingProvider>().loadingUpdate);
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset('assets/lf30_editor_pdzneexn.json', height: 100),
        context.watch<LoadingProvider>().loadingUpdate != ''
            ? CustomAnimatedText()
            : Container(),
      ],
    ),
  );
}

