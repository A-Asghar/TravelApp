import 'package:flutter/material.dart';
import 'package:fyp/providers/SearchProvider.dart';
import 'package:fyp/repository/FlightRepository.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Constants.dart';

class SearchingDestination extends StatefulWidget {
  const SearchingDestination({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<SearchingDestination> createState() => _SearchingDestinationState();
}

TextEditingController controller = TextEditingController();
Future? listCities;
FlightRepository flightRepository = FlightRepository();

class _SearchingDestinationState extends State<SearchingDestination> {
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
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Container(
            // height: 45,
            decoration: BoxDecoration(
              color: Constants.secondaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              onChanged: (_) async {
                listCities = Future.delayed(const Duration(milliseconds: 500))
                    .then((_) {
                      List<Destination> tempList = [];
                      Constants.iataList.keys.forEach((k) {
                        List l = Constants.iataList[k]!;
                        if(l[1].toLowerCase().contains(controller.text.toLowerCase())){
                          tempList.add(Destination(city: l[1]+', '+l[2], iata: k));
                        }
                      });
                      return tempList;
                });
                    // flightRepository.citySearch(keyword: controller.text);
                setState(() {});
              },
              controller: controller,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintStyle: GoogleFonts.poppins(color: Colors.white),
                hintText: 'Search city',
                // suffixIcon: Icon(Icons.search),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(left: 20),
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: controller.text.length > 0
            ? FutureBuilder(
                future: listCities,
                builder: (context, AsyncSnapshot snapshot) {
                  return (snapshot.hasData)
                      ? ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            Destination destination = snapshot.data[index] as Destination;
                            return GestureDetector(
                              onTap: () {
                                widget.title == 'from'
                                    ? context.read<SearchProvider>().from =
                                    destination
                                    : context.read<SearchProvider>().to =
                                    destination;
                                controller.clear();
                                Navigator.pop(context);
                              },
                              child: Card(
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  // padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            color: Constants.primaryColor,
                                            size: 16,
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context).size.width *0.8,
                                              child: Text(
                                                destination.city,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ))
                                        ],
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(Constants.iataList[destination.iata]![0],style: GoogleFonts.poppins(color: Colors.grey),),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                      : const Center(
                          child: CircularProgressIndicator(color: Constants.primaryColor,),
                        );
                })
            : Container(),
      ),
    );
  }
}
