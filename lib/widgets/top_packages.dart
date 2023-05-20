import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_agency/Constants.dart';
import 'package:travel_agency/models/package.dart';
import 'package:travel_agency/screens/package/package_preview_screen.dart';
import 'package:travel_agency/widgets/poppinsText.dart';

Widget topPackages(
    List<Package> packages, BuildContext context, String packageType) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    height: MediaQuery.of(context).size.height * 0.4,
    child: ListView.builder(
        itemCount: packages.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PackagePreview(
                  package: packages[index],
                ),
              ));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                width: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    packageType == 'top'
                        ? Container()
                        : poppinsText(
                            text: packages[index].packageName,
                            color: Constants.primaryColor,
                            fontBold: FontWeight.w400,
                            size: 18.0),
                    const SizedBox(height: 5.0),
                    roundedImage(160.0, 250.0, packages[index].imgUrls[0]),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          poppinsText(
                              text: packages[index].packageName,
                              size: 20.0,
                              fontBold: FontWeight.w500),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Constants.primaryColor,
                                size: 12,
                              ),
                              poppinsText(
                                  text: packages[index].destination,
                                  size: 15.0,
                                  color: Constants.secondaryColor),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 15,
                              ),
                              poppinsText(
                                  text: double.parse(packages[index]
                                          .rating
                                          .toStringAsFixed(1))
                                      .toString(),
                                  size: 15.0,
                                  color: Constants.secondaryColor,
                                  fontBold: FontWeight.w500),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.monetization_on,
                                color: Constants.primaryColor,
                                size: 15,
                              ),
                              poppinsText(
                                  text:
                                      '${packages[index].numOfSales.toString()} Sales',
                                  size: 15.0,
                                  color: Constants.secondaryColor,
                                  fontBold: FontWeight.w500),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              poppinsText(
                                  text:
                                      '\$${double.parse(packages[index].packagePrice.toStringAsFixed(1)).toString()}',
                                  size: 20.0,
                                  color: Constants.primaryColor,
                                  fontBold: FontWeight.w500),
                              poppinsText(
                                  text: ' /person',
                                  color: Constants.secondaryColor,
                                  size: 12.0)
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
  );
}

Widget packageList(
    List<Package> packages, BuildContext context, String packageType, double height) {
  return Container(
    alignment: Alignment.centerLeft,
    height: height,
    child: ListView.builder(
        itemCount: packages.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          var formatter = NumberFormat('#,##,000');
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PackagePreview(
                  package: packages[index],
                ),
              ));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: SizedBox(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    roundedImage(160.0, 250.0, packages[index].imgUrls[0]),
                    Container(
                      height: 160,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: poppinsText(
                                    text:
                                        packages[index].packageName,
                                    size: 18.0,
                                    color: Constants.secondaryColor,
                                    fontBold: FontWeight.w500,
                                ),
                                flex: 1,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.monetization_on,
                                color: Constants.primaryColor,
                                size: 18,
                              ),
                              const SizedBox(
                                  width: 2,
                                ),
                              poppinsText(
                                  text:
                                      '${packages[index].numOfSales.toString()} Sales',
                                  size: 16.0,
                                  color: Constants.secondaryColor,
                                  fontBold: FontWeight.w500),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 18.0,
                                color: Constants.primaryColor,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              poppinsText(
                                  text: packages[index].destination.split(',').first,
                                  size: 16.0,
                                  color: Constants.secondaryColor),
                            ],
                          ),
                          Container(
                            width: 180,
                            alignment: Alignment.bottomRight,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 18,
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Row(
                                  children: [
                                    poppinsText(
                                        text: double.parse(packages[index]
                                                .rating
                                                .toStringAsFixed(1))
                                            .toString(),
                                        size: 16.0,
                                        color: Constants.secondaryColor,
                                        fontBold: FontWeight.w400),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              poppinsText(
                                  text:
                                      '\$${double.parse(packages[index].packagePrice.toStringAsFixed(1)).toString()}',
                                  size: 20.0,
                                  color: Constants.primaryColor,
                                  fontBold: FontWeight.w500),
                              poppinsText(
                                  text: ' /person',
                                  color: Constants.secondaryColor,
                                  size: 12.0)
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
  );
}

Widget  roundedImage(height, width, src) {
  return SizedBox(
    height: height,
    width: width,
    child: ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
      child: Image.network(
        '$src',
        fit: BoxFit.fill,
      ),
    ),
  );
}
