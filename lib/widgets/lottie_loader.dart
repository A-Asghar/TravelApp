import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:travel_agency/providers/loading_provider.dart';
import 'package:travel_agency/widgets/custom_animated_text.dart';

Widget lottieLoader(BuildContext context) {
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

