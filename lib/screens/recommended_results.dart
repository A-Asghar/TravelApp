import 'package:flutter/material.dart';
import 'package:fyp/Constants.dart';
import 'package:fyp/providers/FlightSearchProvider.dart';
import 'package:fyp/providers/HotelSearchProvider.dart';
import 'package:fyp/screens/Search.dart';
import 'package:fyp/screens/flight/FlightSearchResult.dart';
import 'package:fyp/screens/hotel/HotelSearchResults.dart';
import 'package:fyp/widgets/back_button.dart';
import 'package:fyp/widgets/poppinsText.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class RecommendedResults extends StatelessWidget {
  const RecommendedResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.all(20.0),
              child: poppinsText(
                  text: 'Recommendations', size: 24.0, fontBold: FontWeight.w500),
            ),
            leading: InkWell(
                onTap: () {
                  context.read<HotelSearchProvider>().clearHotels();
                  context.read<FlightSearchProvider>().clearFlights();
                  
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Constants.secondaryColor,
                )),
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  Center(
                      child: poppinsText(
                          text: 'Hotels',
                          color: Constants.primaryColor,
                          size: 18.0)),
                  Center(
                      child: poppinsText(
                          text: 'Flights',
                          color: Constants.primaryColor,
                          size: 18.0)),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              Search(
                title: 'hotel',
                recommended: true,
              ),
              Search(
                title: 'flight',
                recommended: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
