import 'package:flutter/material.dart';
import 'package:fyp/Constants.dart';
import 'package:fyp/models/PropertySearchListings.dart';
import 'package:fyp/models/PropertyUnits.dart';
import 'package:fyp/screens/ConfirmPayment.dart';
import 'package:fyp/widgets/poppinsText.dart';
import 'package:fyp/widgets/tealButton.dart';
import 'package:html/parser.dart' show parse;

import '../../widgets/errorSnackBar.dart';
import '../FullScreenImagePage.dart';

class RoomDetails extends StatelessWidget {
  const RoomDetails({Key? key, required this.unit, required this.property})
      : super(key: key);
  final Unit unit;
  final PropertySearchListing property;

  @override
  Widget build(BuildContext context) {
    List<String>? parsedDetails =
        parse(unit.description).body?.text.split(' - ');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 25,
              color: Constants.secondaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: poppinsText(text: 'Room Details'),
        ),
        body: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 5),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (unit.unitGallery!.gallery!.isNotEmpty)
                      SizedBox(
                        height: 220,
                        child: ListView.builder(
                          shrinkWrap: false,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: unit.unitGallery!.gallery!.length,
                          itemBuilder: (context, idx) {
                            return Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: GestureDetector(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(unit
                                      .unitGallery!.gallery![idx].image!.url!),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FullScreenImagePage(
                                          image: unit.unitGallery!.gallery![idx]
                                              .image!.url!),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      )
                    else
                      Container(
                        height: 220,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: poppinsText(
                          text: unit.header!.text,
                          size: 18.0,
                          fontBold: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        poppinsText(
                            text:
                                "\$${unit.ratePlans![0].priceDetails![0].price!.lead!.amount.toStringAsFixed(2)}",
                            color: Constants.primaryColor,
                            size: 22.0,
                            fontBold: FontWeight.w500),
                        poppinsText(
                            text: ' /night',
                            color: Constants.secondaryColor,
                            size: 12.0),
                      ],
                    )
                  ],
                ),
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: parsedDetails?.length ?? 0,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: poppinsText(text: '• ${parsedDetails![index]}'),
                );
              },
            ),
            SizedBox(height: 25),
          ],
        ),
        bottomSheet: Container(
          height: 70,
          child: Center(
            child: TealButton(
              text: 'Book Now',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ConfirmPaymentScreen(
                    unit: unit,
                    property: property,
                  ),
                ));
              },
              bgColor: Constants.primaryColor,
              txtColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget item(text) {
    return Row(
      children: [
        const SizedBox(width: 10),
        const Icon(
          Icons.circle,
          color: Constants.secondaryColor,
          size: 12,
        ),
        const SizedBox(width: 10),
        poppinsText(text: text),
        const SizedBox(height: 10),
      ],
    );
  }
}
