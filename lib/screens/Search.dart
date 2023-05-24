import 'package:flutter/material.dart';
import 'package:fyp/models/Destination.dart';
import 'package:fyp/providers/FlightSearchProvider.dart';
import 'package:fyp/providers/HotelSearchProvider.dart';
import 'package:fyp/providers/loading_provider.dart';
import 'package:fyp/repository/FlightRepository.dart';
import 'package:fyp/repository/HotelRepository.dart';
import 'package:fyp/screens/SearchDestination.dart';
import 'package:fyp/screens/flight/FlightSearchResult.dart';
import 'package:fyp/screens/hotel/HotelSearchResults.dart';
import 'package:fyp/widgets/poppinsText.dart';
import 'package:fyp/widgets/tealButton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Constants.dart';
import '../repository/RecommendationRepository.dart';
import '../widgets/errorSnackBar.dart';

class Search extends StatefulWidget {
  const Search({Key? key, required this.title, required this.recommended})
      : super(key: key);
  final String title;
  final bool recommended;

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
      } else if (widget.title == 'hotel') {
        context.read<HotelSearchProvider>().adults = 1;
        context.read<HotelSearchProvider>().checkIn =
            Constants.convertDate(DateTime.now());
        context.read<HotelSearchProvider>().checkOut =
            Constants.convertDate(DateTime.now());
        context.read<HotelSearchProvider>().to =
            Destination(city: '', iata: '');
      }
    }

    return WillPopScope(
      onWillPop: () async {
        clear();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
            appBar: widget.recommended == true
                ? null
                : AppBar(
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      color: Constants.secondaryColor,
                      iconSize: 25,
                      onPressed: () {
                        clear();
                        Navigator.pop(context);
                      },
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: poppinsText(
                        text: widget.title == 'hotel'
                          ? 'Find your hotel'
                          : 'Find a flight',
                        size: 24.0,
                        fontBold: FontWeight.w500),
                    centerTitle: true,
                  ),
            body: returnLayout()),
      ),
    );
  }

  Widget returnLayout() {
    if (widget.title == 'flight') {
      return FlightLayout(
        recommended: widget.recommended,
      );
    } else if (widget.title == 'hotel') {
      return HotelLayout(
        recommended: widget.recommended,
      );
    } else {
      return Container();
    }
  }
}

Widget searchButton(BuildContext context, VoidCallback onPressed) {
  return TealButton(
    text: 'Search',
    onPressed: onPressed,
    bgColor: Constants.primaryColor,
    txtColor: Colors.white,
  );
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

Future _selectDate(BuildContext context, String date) async {
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
            colorScheme: ColorScheme.light(
              primary: Constants.primaryColor, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Constants.secondaryColor, // body text color
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
    } else if (date == 'checkin') {
      context.read<HotelSearchProvider>().checkIn =
          Constants.convertDate(selectedDate);
    } else if (date == 'checkout') {
      context.read<HotelSearchProvider>().checkOut =
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
                color: Constants.primaryColor,
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

class DateTextfield extends StatefulWidget {
  DateTextfield(
      {super.key,
      required this.topText,
      required this.bottomText,
      required this.date});

  final String topText;
  final String bottomText;
  final String date;
  bool isSelected = false;

  @override
  State<DateTextfield> createState() => _DateTextfieldState();
}

class _DateTextfieldState extends State<DateTextfield> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        _selectDate(context, widget.date);
        setState(() {
          widget.isSelected = !widget.isSelected;
        });
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
                Icon(
                  Icons.calendar_today,
                  color: widget.isSelected
                      ? Constants.primaryColor
                      : Constants.secondaryColor,
                  size: 18,
                ),
                const SizedBox(
                  width: 5,
                ),
                poppinsText(
                    text: widget.topText, color: Constants.secondaryColor)
              ],
            ),
            poppinsText(text: widget.bottomText, size: 18.0),
          ],
        ),
      ),
    );
  }
}

Widget guests_adult_textfield(context, topText, bottomText, title) {
  return GestureDetector(
    onTap: () {
      adults_guests_alertbox(context, title);
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

Future adults_guests_alertbox(BuildContext context, title) {
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
                          if (title == 'flight') {
                            context.read<FlightSearchProvider>().adults =
                                adults;
                          } else {
                            context.read<HotelSearchProvider>().adults = adults;
                          }
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
  const FlightLayout({Key? key, required this.recommended}) : super(key: key);
  final bool recommended;

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

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Container(
          height: widget.recommended == true
              ? MediaQuery.of(context).size.height * 0.815
              : MediaQuery.of(context).size.height * 0.87,
          child: Column(
            children: [
              // One Way / Round Trip
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 35,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 35,
                  child: Wrap(
                    spacing: 60,
                    children: List.generate(flightTrips.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          for (var e in flightTrips) {
                            e.isSelected = false;
                          }
                          flightTrips[index].isSelected = true;
                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: flightTrips[index].isSelected
                                ? Constants.primaryColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: flightTrips[index].isSelected
                                  ? Constants.primaryColor
                                  : Constants.primaryColor,
                            ),
                          ),
                          child: poppinsText(
                            text: flightTrips[index].text,
                            color: flightTrips[index].isSelected
                                ? Colors.white
                                : Constants.primaryColor,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
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
              guests_adult_textfield(context, 'Adults', adults, 'flight'),

              const Spacer(),

              // Search
              searchButton(
                context,
                () async {
                  context.read<LoadingProvider>().loadingUpdate =
                      'Fetching Flights';
                  bool returnDateSelected = flightTrips[1].isSelected;
                  DateTime departDate = DateTime.parse(
                      context.read<FlightSearchProvider>().departDate);
                  DateTime returnDate = DateTime.parse(
                      context.read<FlightSearchProvider>().returnDate);
                  DateTime now = DateTime.now();
                  if (context.read<FlightSearchProvider>().from.city == '' ||
                      context.read<FlightSearchProvider>().to.city == '') {
                    errorSnackBar(context, 'You haven\'t selected a city');
                    return;
                  }

                  if (!returnDateSelected) {
                    if (departDate.isBefore(now) && departDate.day != now.day) {
                      errorSnackBar(
                          context, 'Depart Date can\'t be before Today');
                      return;
                    }
                  }

                  if (returnDateSelected) {
                    if (departDate.isBefore(now) && departDate.day != now.day) {
                      errorSnackBar(
                          context, 'Depart Date can\'t be before Today');
                      return;
                    }
                    if (returnDate.isBefore(departDate) &&
                        returnDate.day != departDate.day) {
                      errorSnackBar(
                          context, 'Return Date can\'t be before Depart Date');
                      return;
                    }
                  }

                  searchFlight(flightTrips);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  searchFlight(flightTrips) async {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const FlightSearchResult()));

    // todo update user searchedCities

    RecommendationRepository().updateUserSearchedCities(
        iata: context.read<FlightSearchProvider>().to.iata);
    FlightRepository flightRepository = FlightRepository();
    List response = await flightRepository.flightOffersSearch(
        originLocationCode: context.read<FlightSearchProvider>().from.iata,
        destinationLocationCode: context.read<FlightSearchProvider>().to.iata,
        departureDate: context.read<FlightSearchProvider>().departDate,
        returnDate: flightTrips[1].isSelected
            ? context.read<FlightSearchProvider>().returnDate
            : '',
        adults: context.read<FlightSearchProvider>().adults);

    context.read<FlightSearchProvider>().dictionary = response[0];
    context.read<FlightSearchProvider>().flights = response[1];
    context.read<FlightSearchProvider>().count = response[2];
  }
}

class HotelLayout extends StatefulWidget {
  const HotelLayout({Key? key, required this.recommended}) : super(key: key);
  final bool recommended;

  @override
  State<HotelLayout> createState() => _HotelLayoutState();
}

class _HotelLayoutState extends State<HotelLayout> {
  @override
  Widget build(BuildContext context) {
    String to = context.watch<HotelSearchProvider>().to.city == ''
        ? 'Select a destination'
        : context.watch<HotelSearchProvider>().to.city;
    String checkIn = context.watch<HotelSearchProvider>().checkIn;
    String checkOut = context.watch<HotelSearchProvider>().checkOut;
    int adults = context.watch<HotelSearchProvider>().adults;

    return Column(
      children: [
        // Destination
        from_to_textfield(context, 'Destination', to, 'to', 'hotel'),

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
                    context,
                    'Checkin',
                    '${checkIn.split('-')[2]}\t${Constants.integerToMonth[int.parse(checkIn.split('-')[1])]!}',
                    'checkin'),
                const Spacer(),

                // Check Out
                checkin_checkout_textfield(
                    context,
                    'Checkout',
                    '${checkOut.split('-')[2]}\t${Constants.integerToMonth[int.parse(checkOut.split('-')[1])]!}',
                    'checkout'),
              ],
            ),
          ),
        ),

        // Guests
        guests_adult_textfield(context, 'Adults', adults, 'hotel'),

        const Spacer(),

        searchButton(context, () async {
          print("searchButton()");
          context.read<LoadingProvider>().loadingUpdate = 'Fetching Hotels';
          if (context.read<HotelSearchProvider>().to.city == '') {
            errorSnackBar(context, 'You haven\'t selected a city');
            return;
          }

          DateTime checkOut =
              DateTime.parse(context.read<HotelSearchProvider>().checkOut);
          DateTime checkIn =
              DateTime.parse(context.read<HotelSearchProvider>().checkIn);
          DateTime now = DateTime.now();

          if (checkOut.isBefore(checkIn)) {
            errorSnackBar(
                context, 'CheckOut date can\'t be before CheckIn Date');
            return;
          }

          if ((checkOut.isBefore(now) && checkOut.day != now.day) ||
              (checkIn.isBefore(now) && checkIn.day != now.day)) {
            errorSnackBar(context,
                'CheckIn date or CheckOut date can\'t be before Today');
            return;
          }
          searchHotel();
        })
      ],
    );
  }

  searchHotel() async {
    print("searchHotel() called");
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const HotelSearchResults()));

    RecommendationRepository().updateUserSearchedCities(
        iata: context.read<HotelSearchProvider>().to.iata);

    HotelRepository hotelRepository = HotelRepository();
    List response = await hotelRepository.hotelSearch(
        city: context.read<HotelSearchProvider>().to.city.split(',')[0],
        checkIn: DateTime.parse(context.read<HotelSearchProvider>().checkIn),
        checkOut: DateTime.parse(context.read<HotelSearchProvider>().checkOut),
        adults: context.read<HotelSearchProvider>().adults);

    context.read<HotelSearchProvider>().hotels = response[0];
    context.read<HotelSearchProvider>().regionId = response[1];
    context.read<HotelSearchProvider>().errorMessage = response[2];
    context.read<LoadingProvider>().clearLocationUpdate();
  }
}

class FlightTrip {
  FlightTrip({required this.text, required this.isSelected});

  String text;
  bool isSelected;
}
