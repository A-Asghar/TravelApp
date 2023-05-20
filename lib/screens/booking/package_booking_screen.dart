import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_agency/providers/user_provider.dart';
import 'package:travel_agency/screens/booking/canceled_view.dart';
import 'package:travel_agency/screens/booking/completed_view.dart';
import 'package:travel_agency/screens/booking/ongoing_view.dart';
import 'package:travel_agency/widgets/side_drawer.dart';

import '../../../Constants.dart';
import '../../../widgets/poppinsText.dart';

class PackageBookingScreen extends StatefulWidget {
  const PackageBookingScreen({Key? key}) : super(key: key);

  @override
  State<PackageBookingScreen> createState() => _PackageBookingScreenState();
}

class _PackageBookingScreenState extends State<PackageBookingScreen> {
  final documentController = Get.put(DocumentController());
  final UserProvider controller = Get.put(UserProvider());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: poppinsText(
            text: 'Your Bookings', size: 24.0, fontBold: FontWeight.w600),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: CircleAvatar(
                backgroundColor: Constants.primaryColor,
                child:
                    controller.user!.profilePhotoUrl == "assets/images/user.png"
                        ? poppinsText(
                            text: controller.user!.name.substring(0, 1),
                            size: 20.0,
                            color: Colors.white,
                            fontBold: FontWeight.w500)
                        : CircleAvatar(backgroundImage: NetworkImage(controller.user!.profilePhotoUrl,),),
              ),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              iconSize: 50,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // GetX<DocumentController>(
            //   init: documentController,
            //   builder: (documentController) => Row(
            //     children: [
            //       tapCard(
            //         "Ongoing",
            //         documentController.isDocument.value == 0
            //             ? Constants.primaryColor
            //             : Colors.transparent,
            //         () {
            //           documentController.isDocument.value = 0;
            //         },
            //       ),
            //       const SizedBox(width: 14),
            //       tapCard(
            //         "Completed",
            //         documentController.isDocument.value == 1
            //             ? Constants.primaryColor
            //             : Colors.transparent,
            //         () {
            //           documentController.isDocument.value = 1;
            //         },
            //       ),
            //       const SizedBox(width: 14),
            //       tapCard(
            //         "Canceled",
            //         documentController.isDocument.value == 2
            //             ? Constants.primaryColor
            //             : Colors.transparent,
            //         () {
            //           documentController.isDocument.value = 2;
            //         },
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(height: 20),
            GetX<DocumentController>(
              init: documentController,
              builder: (documentController) =>
                  documentController.isDocument.value == 0
                      ? const OnGoingView()
                      : documentController.isDocument.value == 1
                          ? const OnGoingView()
                          : const OnGoingView(),
            ),
          ],
        ),
      ),
      endDrawer: SideDrawer(),
    );
  }

  Widget tapCard(String text, Color bgColor, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: Constants.primaryColor,
            ),
          ),
          child: Center(
            child: poppinsText(
                text: text,
                size: 15.0,
                color: bgColor == Colors.transparent
                    ? Constants.primaryColor
                    : Colors.white),
          ),
        ),
      ),
    );
  }
}

class DocumentController extends GetxController {
  RxInt isDocument = 0.obs;
}
