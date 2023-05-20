import 'package:flutter/material.dart';
import 'package:travel_agency/models/Destination.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travel_agency/providers/package_provider.dart';

import '../../Constants.dart';

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

class _SearchDestinationState extends State<SearchDestination> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 25,
              color: Constants.secondaryColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Container(
            decoration: BoxDecoration(
              color: Constants.secondaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              onChanged: (_) async {
                listCities =
                    Future.delayed(const Duration(milliseconds: 500)).then((_) {
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
                  final uniqueCitiesByName =
                      matchingList.fold<List<Destination>>([], (prev, dest) {
                    if (!prev.any((h) => h.city == dest.city)) {
                      prev.add(dest);
                    }
                    return prev;
                  });
                  if (widget.option == 'package') {
                    return uniqueCitiesByName;
                  } else {
                    return matchingList;
                  }
                });
                setState(() {});
              },
              controller: controller,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintStyle: GoogleFonts.poppins(color: Constants.secondaryColor),
                hintText: 'Search city',
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(left: 20),
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: controller.text.isNotEmpty
            ? FutureBuilder(
                future: listCities,
                builder: (context, AsyncSnapshot snapshot) {
                  return (snapshot.hasData)
                      ? ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            Destination destination =
                                snapshot.data[index] as Destination;
                            return GestureDetector(
                              onTap: () {
                                context.read<PackageProvider>().to =
                                    destination;

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
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                      : const Center(
                          child: CircularProgressIndicator(
                            color: Constants.primaryColor,
                          ),
                        );
                })
            : Container(),
      ),
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
