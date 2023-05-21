import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyp/models/Destination.dart';
import 'package:fyp/providers/FlightSearchProvider.dart';
import 'package:fyp/providers/HotelSearchProvider.dart';
import 'package:fyp/repository/FlightRepository.dart';
import 'package:fyp/widgets/poppinsText.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Constants.dart';

class SearchDestination extends StatefulWidget {
  const SearchDestination({Key? key, required this.title, required this.option})
      : super(key: key);

  final String title;
  final String option;

  @override
  State<SearchDestination> createState() => _SearchDestinationState();
}

TextEditingController controller = TextEditingController();
Future? listCities;
FlightRepository flightRepository = FlightRepository();

class _SearchDestinationState extends State<SearchDestination> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: poppinsText(
                text: 'Search Destination',
                fontBold: FontWeight.w500,
                size: 24.0),
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 25,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                controller.clear();
              },
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(15, 0, 10, 0),
                decoration: BoxDecoration(
                  color: Constants.secondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  onChanged: (_) async {
                    listCities =
                        Future.delayed(const Duration(milliseconds: 500))
                            .then((_) {
                      List<Destination> matchingList = [];
                      Constants.iataList.keys.forEach((iata) {
                        List entry = Constants.iataList[iata]!;
                        if (entry[1]
                                .toLowerCase()
                                .contains(controller.text.toLowerCase()) ||
                            entry[2]
                                .toLowerCase()
                                .contains(controller.text.toLowerCase())) {
                          matchingList.add(Destination(
                              city: entry[1] + ', ' + entry[2], iata: iata));
                        }
                      });
                      final uniqueHotelsByName = matchingList
                          .fold<List<Destination>>([], (prev, dest) {
                        if (!prev.any((h) => h.city == dest.city)) {
                          prev.add(dest);
                        }
                        return prev;
                      });
                      if (widget.option == 'hotel') {
                        return uniqueHotelsByName;
                      } else {
                        return matchingList;
                      }
                    });
                    setState(() {});
                  },
                  controller: controller,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search_outlined,
                    ),
                    hintStyle:
                        GoogleFonts.poppins(color: Constants.secondaryColor),
                    hintText: 'Search city',
                    border: InputBorder.none,
                  ),
                ),
              ),
              controller.text.isNotEmpty
                  ? FutureBuilder(
                      future: listCities,
                      builder: (context, AsyncSnapshot snapshot) {
                        return (snapshot.hasData)
                            ? Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                                      shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    Destination destination =
                                        snapshot.data[index] as Destination;
                                    return GestureDetector(
                                      onTap: () {
                                        if (widget.option == 'flight') {
                                          widget.title == 'from'
                                              ? context
                                                  .read<FlightSearchProvider>()
                                                  .from = destination
                                              : context
                                                  .read<FlightSearchProvider>()
                                                  .to = destination;
                                        } else if (widget.option == 'hotel') {
                                          context.read<HotelSearchProvider>().to =
                                              destination;
                                        }
                            
                                        controller.clear();
                                        Navigator.pop(context);
                                      },
                                      child: Card(
                                        child: Container(
                                          margin: const EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  locationIcon(),
                                                  destinationCity(destination),
                                                ],
                                              ),
                                              widget.option == 'flight'
                                                  ? airport(destination)
                                                  : Container()
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            )
                            : const Center(
                                child: CircularProgressIndicator(
                                  color: Constants.primaryColor,
                                ),
                              );
                      })
                  : Container(),
            ],
          )),
    );
  }

  Widget locationIcon() {
    return const Icon(
      Icons.location_on,
      color: Constants.primaryColor,
      size: 16,
    );
  }

  Widget destinationCity(destination) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Text(
        destination.city,
        style: GoogleFonts.poppins(
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget airport(destination) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        Constants.iataList[destination.iata]![0],
        style: GoogleFonts.poppins(color: Colors.grey),
      ),
    );
  }
}
