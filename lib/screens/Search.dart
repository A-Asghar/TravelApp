import 'package:flutter/material.dart';
import 'package:fyp/providers/FlightSearchProvider.dart';
import 'package:fyp/repository/FlightRepository.dart';
import 'package:fyp/screens/SearchDestination.dart';
import 'package:fyp/screens/flight/FlightSearchResult.dart';
import 'package:fyp/widgets/poppinsText.dart';
import 'package:fyp/widgets/tealButton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Constants.dart';

class Search extends StatefulWidget {
  const Search({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    clear() {
      if (widget.title == 'flight') {
        context.read<FlightSearchProvider>().adults = 1;
        context.read<FlightSearchProvider>().departDate =
            Constants.convertDate(DateTime.now());
        context.read<FlightSearchProvider>().returnDate =
            Constants.convertDate(DateTime.now());
        context.read<FlightSearchProvider>().from =
            Destination(city: '', iata: '');
        context.read<FlightSearchProvider>().to =
            Destination(city: '', iata: '');
      } else if (widget.title == 'hotel') {}
    }

    return WillPopScope(
      onWillPop: () async {
        clear();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: Colors.black,
                onPressed: () {
                  clear();
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                widget.title == 'hotel' ? 'Find your hotel' : 'Find a flight',
                style: GoogleFonts.poppins(color: Colors.black),
              ),
              centerTitle: true,
            ),
            body: returnLayout()),
      ),
    );
  }

  Widget returnLayout() {
    if (widget.title == 'flight') {
      return const FlightLayout();
    } else if (widget.title == 'hotel') {
      return const HotelLayout();
    } else {
      return Container();
    }
  }
}

Widget searchButton(BuildContext context, VoidCallback onPressed) {
  return TealButton(text: 'Search', onPressed: onPressed);
}

Widget packageLayout() {
  return Container();
}

Widget from_to_textfield(context, topText, bottomText, title, option) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SearchDestination(title: title, option: option),
      ));
    },
    child: Align(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: const EdgeInsets.symmetric(vertical: 20),
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.withOpacity(0.1)
            // border: Border.all(),
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            poppinsText(text: topText, color: Constants.secondaryColor),
            poppinsText(text: bottomText, size: 18.0),
          ],
        ),
      ),
    ),
  );
}

Future<void> _selectDate(BuildContext context, String date) async {
  DateTime? selectedDate = DateTime.now();
  selectedDate = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            colorScheme: const ColorScheme.light(
              primary: Constants.primaryColor, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Constants.primaryColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101));

  if (selectedDate != null) {
    if (date == 'depart') {
      context.read<FlightSearchProvider>().departDate =
          Constants.convertDate(selectedDate);
    } else if (date == 'return') {
      context.read<FlightSearchProvider>().returnDate =
          Constants.convertDate(selectedDate);
    }
  }

  // return selectedDate;
}

Widget checkin_checkout_textfield(
    BuildContext context, topText, bottomText, String date) {
  return GestureDetector(
    onTap: () async {
      _selectDate(context, date);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(0.1)
          // border: Border.all()
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.calendar_today,
                color: Constants.secondaryColor,
                size: 18,
              ),
              const SizedBox(
                width: 5,
              ),
              poppinsText(text: topText, color: Constants.secondaryColor)
            ],
          ),
          poppinsText(text: bottomText, size: 18.0),
        ],
      ),
    ),
  );
}

Widget guests_adult_textfield(context, topText, bottomText) {
  return GestureDetector(
    onTap: () {
      adults_guests_alertbox(context);
    },
    child: Align(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: const EdgeInsets.symmetric(vertical: 20),
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.withOpacity(0.1)
            // border: Border.all()
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            poppinsText(text: topText, color: Constants.secondaryColor),
            poppinsText(text: bottomText.toString(), size: 18.0),
          ],
        ),
      ),
    ),
  );
}

Future adults_guests_alertbox(BuildContext context) {
  int adults = context.read<FlightSearchProvider>().adults;
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: StatefulBuilder(
            builder: (context, StateSetter setState) {
              return Container(
                alignment: Alignment.center,
                width: 300,
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        poppinsText(text: '   Adults', size: 20.0),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              adults++;
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.add_circle_outlined,
                              color: Constants.primaryColor,
                            )),
                        poppinsText(text: adults.toString(), size: 20.0),
                        IconButton(
                            onPressed: () {
                              adults--;
                              if (adults < 1) adults = 1;
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.remove_circle,
                              color: Constants.primaryColor,
                            )),
                      ],
                    ),
                    TextButton(
                        onPressed: () {
                          context.read<FlightSearchProvider>().adults = adults;
                          Navigator.of(context).pop();
                        },
                        child: poppinsText(
                            text: 'OK',
                            color: Constants.primaryColor,
                            fontBold: FontWeight.bold))
                  ],
                ),
              );
            },
          ),
        );
      });
}

class FlightLayout extends StatefulWidget {
  const FlightLayout({Key? key}) : super(key: key);

  @override
  State<FlightLayout> createState() => _FlightLayoutState();
}

class _FlightLayoutState extends State<FlightLayout> {
  List<FlightTrip> flightTrips = [
    FlightTrip(text: 'OneWay', isSelected: true),
    FlightTrip(text: 'Round Trip', isSelected: false),
  ];

  @override
  Widget build(BuildContext context) {
    String from = context.watch<FlightSearchProvider>().from.city == ''
        ? 'Select a destination'
        : context.watch<FlightSearchProvider>().from.city;
    String to = context.watch<FlightSearchProvider>().to.city == ''
        ? 'Select a destination'
        : context.watch<FlightSearchProvider>().to.city;
    String departDate = context.watch<FlightSearchProvider>().departDate;
    String returnDate = context.watch<FlightSearchProvider>().returnDate;
    int adults = context.watch<FlightSearchProvider>().adults;

    return Column(
      children: [
        // One Way / Round Trip
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          height: 35,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: flightTrips.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    for (var e in flightTrips) {
                      e.isSelected = false;
                    }
                    flightTrips[index].isSelected = true;
                    setState(() {});
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                            color: flightTrips[index].isSelected
                                ? Constants.primaryColor
                                : Colors.black)),
                    child: poppinsText(
                        text: flightTrips[index].text,
                        color: flightTrips[index].isSelected
                            ? Constants.primaryColor
                            : Colors.black,
                        fontBold: flightTrips[index].isSelected
                            ? FontWeight.w600
                            : FontWeight.w300),
                  ),
                );
              }),
        ),

        // From
        from_to_textfield(context, 'From', from, 'from', 'flight'),

        //To
        from_to_textfield(context, 'To', to, 'to', 'flight'),

        // Depart / Return
        Align(
          alignment: Alignment.center,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.85,
            child: Row(
              children: [
                // Depart / Check In
                checkin_checkout_textfield(
                    context,
                    'Depart',
                    '${departDate.split('-')[2]}\t${Constants.integerToMonth[int.parse(departDate.split('-')[1])]!}',
                    'depart'),
                const Spacer(),

                // Return Check Out
                flightTrips[1].isSelected
                    ? checkin_checkout_textfield(
                        context,
                        'Return',
                        '${returnDate.split('-')[2]}\t${Constants.integerToMonth[int.parse(returnDate.split('-')[1])]!}',
                        'return')
                    : Container(),
              ],
            ),
          ),
        ),

        // Adults
        guests_adult_textfield(context, 'Adults', adults),

        const Spacer(),

        // Search
        searchButton(
          context,
          () async {
            if (context.read<FlightSearchProvider>().from.city != '' &&
                context.read<FlightSearchProvider>().to.city != '') {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const FlightSearchResult()));
              FlightRepository flightRepository = FlightRepository();
              List response = await flightRepository.flightOffersSearch(
                  originLocationCode:
                      context.read<FlightSearchProvider>().from.iata,
                  destinationLocationCode:
                      context.read<FlightSearchProvider>().to.iata,
                  departureDate:
                      context.read<FlightSearchProvider>().departDate,
                  returnDate: flightTrips[1].isSelected
                      ? context.read<FlightSearchProvider>().returnDate
                      : '',
                  adults: context.read<FlightSearchProvider>().adults);

              context.read<FlightSearchProvider>().dictionary = response[0];
              context.read<FlightSearchProvider>().flights = response[1];
              context.read<FlightSearchProvider>().count = response[2];
            } else {}
          },
        )
      ],
    );
  }
}

class HotelLayout extends StatefulWidget {
  const HotelLayout({Key? key}) : super(key: key);

  @override
  State<HotelLayout> createState() => _HotelLayoutState();
}

class _HotelLayoutState extends State<HotelLayout> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Destination
        from_to_textfield(context, 'Destination', 'Lahore, Pakistan', 'from', 'hotel'),

        // Check-in / Check-out
        Align(
          alignment: Alignment.center,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.85,
            child: Row(
              children: [
                // Check In
                checkin_checkout_textfield(
                    context, 'Checkin', '20 Oct', 'checkin'),
                const Spacer(),

                // Check Out
                checkin_checkout_textfield(
                    context, 'Checkout', '23 Oct', 'checkout'),
              ],
            ),
          ),
        ),

        // Guests
        guests_adult_textfield(context, 'Guests', '1'),

        const Spacer(),

        searchButton(context, () async {})
      ],
    );
  }
}

class FlightTrip {
  FlightTrip({required this.text, required this.isSelected});

  String text;
  bool isSelected;
}
