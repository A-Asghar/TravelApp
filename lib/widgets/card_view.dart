import 'package:flutter/material.dart';
import 'package:fyp/models/Package.dart';
import 'package:fyp/models/PropertySearchListings.dart';
import 'package:fyp/models/PropertyUnits.dart';
import 'package:fyp/providers/HotelSearchProvider.dart';
import 'package:provider/provider.dart';

class CardView extends StatelessWidget {
  CardView({Key? key, this.package, this.unit, this.property})
      : super(key: key);

  Package? package;
  Unit? unit;
  PropertySearchListing? property;

  @override
  Widget build(BuildContext context) {
    var hotelProvider = context.watch<HotelSearchProvider>();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff04060F).withOpacity(0.05),
            blurRadius: 8,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            package != null
                ? Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: NetworkImage(
                          package!.imgUrls[0],
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                : unit != null &&
                        unit!.unitGallery!.gallery != null
                    ? Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: NetworkImage(
                              unit!.unitGallery!.gallery![0].image!.url!,
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                    : Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      ),
            const SizedBox(width: 10),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    package != null
                        ? package!.packageName
                        : unit!.header!.text!,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    package != null
                        ? package!.destination
                        : hotelProvider.to.city,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 14,
                          color: const Color(0xff757575),
                        ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color(0xffFFD300),
                        size: 15,
                      ),
                      Text(
                        package != null
                            ? package!.rating.toString()
                            : property!.reviews!.score.toString(),
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 14,
                              color: Colors.teal,
                            ),
                      ),
                      Text(
                        package != null
                            ? "(${package!.packageReviews!.length} reviews)"
                            : "(${hotelProvider.hotelReviews.length} reviews)",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 14,
                              color: const Color(0xff757575),
                            ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
