import 'package:flutter/material.dart';
import 'package:fyp/providers/SearchProvider.dart';
import 'package:fyp/repository/FlightRepository.dart';
import 'package:fyp/screens/FlightSearchResult.dart';
import 'package:fyp/screens/SearchingDestination.dart';
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
  List<FlightTrip> flightTrips = [
    FlightTrip(text: 'OneWay', isSelected: true),
    FlightTrip(text: 'Round Trip', isSelected: false),
  ];

  var items = [
    'All',
    'ECONOMY',
    'PREMIUM_ECONOMY',
    'BUSINESS',
    'FIRST',
  ];
var dropdownvalue = 'All';
  @override
  Widget build(BuildContext context) {
    Clear(){
      context.read<SearchProvider>().adults =1 ;
      context.read<SearchProvider>().departDate = Constants.convertDate(DateTime.now());
      context.read<SearchProvider>().returnDate = Constants.convertDate(DateTime.now());
      context.read<SearchProvider>().from = Destination(city: '', iata: '');
      context.read<SearchProvider>().to = Destination(city: '', iata: '');

    }

    String from = context.watch<SearchProvider>().from.city == ''
        ? 'Select a destination'
        : context.watch<SearchProvider>().from.city;
    String to = context.watch<SearchProvider>().to.city == ''
        ? 'Select a destination'
        : context.watch<SearchProvider>().to.city;
    String departDate = context.watch<SearchProvider>().departDate;
    String returnDate = context.watch<SearchProvider>().returnDate;
    int adults = context.watch<SearchProvider>().adults;

    return WillPopScope(
        onWillPop: ()async{
          Clear();
          return true;
        },
      child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: Colors.black,
                onPressed: (){
                  Clear();
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
            body: Column(
              children: [
                // Round Trip , OneWay Widget
                widget.title == 'flight'
                    ? SizedBox(
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
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
                )
                    : Container(),

                // From
                widget.title == 'flight'
                    ? from_to_textfield(context, 'From', from, 'from')
                    : from_to_textfield(
                    context, 'Destination', 'Lahore, Pakistan', 'from'),

                // To
                widget.title == 'flight'
                    ? from_to_textfield(context, 'To', to, 'to')
                    : Container(),

                Align(
                  alignment: Alignment.center,
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Row(
                      children: [
                        // Depart / Check In
                        widget.title == 'flight'
                            ? checkin_checkout_textfield(
                            context,
                            'Depart',
                            '${departDate.split('-')[2]}\t${Constants.integerToMonth[int.parse(departDate.split('-')[1])]!}',
                            'depart')
                            : checkin_checkout_textfield(
                            context, 'Checkin', '20 Oct', 'checkin'),
                        const Spacer(),

                        // Return Check Out
                        widget.title == 'flight'
                            ? flightTrips[1].isSelected
                            ? checkin_checkout_textfield(
                            context,
                            'Return',
                            '${returnDate.split('-')[2]}\t${Constants.integerToMonth[int.parse(returnDate.split('-')[1])]!}',
                            'return')
                            : Container()
                            : checkin_checkout_textfield(
                            context, 'Checkout', '23 Oct', 'checkout'),
                      ],
                    ),
                  ),
                ),

                // Adults / Guests
                widget.title == 'flight'
                    ? guests_adult_textfield(context, 'Adults', adults)
                    : guests_adult_textfield(context, 'Guests', '1'),

                widget.title == 'flight' ?
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: DropdownButtonFormField(
                  decoration: InputDecoration(
                      // border: InputBorder.none,
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      enabled: false,
                      fillColor: Colors.grey.withOpacity(0.1),
                      filled: true,
                      suffixIcon: Icon(Icons.arrow_drop_down,color: Colors.grey,)
                  ),
                  borderRadius: BorderRadius.circular(20),

                  // style: GoogleFonts.poppins(color: Colors.black),

                  // dropdownColor: Colors.grey.withOpacity(0.1),
                  elevation: 0,
                  focusColor: Constants.secondaryColor.withOpacity(0.1),
                  iconSize: 0,
                  // Initial Value
                  value: dropdownvalue,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 50,
                        decoration: BoxDecoration(
                          // color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        // width: MediaQuery.of(context).size.width*0.8,
                        child: poppinsText(text:items),
                      ),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
                )
                    : Container(),

                const Spacer(),

                // Search Button
                searchButton(context),
              ],
            ),
          )),

    );
  }

  Widget searchButton(BuildContext context) {
    return TealButton(
        text: 'Search',
        onPressed: () async {
          if(context.read<SearchProvider>().from.city!=''
          && context.read<SearchProvider>().to.city!=''){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const FlightSearchResult()));
            FlightRepository flightRepository = FlightRepository();
            List response = await flightRepository.flightOffersSearch(
                originLocationCode: context.read<SearchProvider>().from.iata,
                destinationLocationCode:
                context.read<SearchProvider>().to.iata,
                departureDate: context.read<SearchProvider>().departDate,
                returnDate: flightTrips[1].isSelected
                    ? context.read<SearchProvider>().returnDate
                    : '',
                adults: context.read<SearchProvider>().adults);

            context.read<SearchProvider>().dictionary = response[0];
            context.read<SearchProvider>().flights = response[1];
            context.read<SearchProvider>().count = response[2];
          }else{

          }
        });
  }
}

Widget from_to_textfield(context, topText, bottomText, title) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SearchingDestination(title: title),
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
            poppinsText(text: topText,color: Constants.secondaryColor),
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
      context.read<SearchProvider>().departDate =
          Constants.convertDate(selectedDate);
    } else if (date == 'return') {
      context.read<SearchProvider>().returnDate =
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
              poppinsText(text: topText,color: Constants.secondaryColor)
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
            poppinsText(text: topText,color: Constants.secondaryColor),
            poppinsText(text: bottomText.toString(), size: 18.0),
          ],
        ),
      ),
    ),
  );
}

Future adults_guests_alertbox(BuildContext context) {
  int adults = context.read<SearchProvider>().adults;
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
                          context.read<SearchProvider>().adults = adults;
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

class FlightTrip {
  FlightTrip({required this.text, required this.isSelected});

  String text;
  bool isSelected;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter DropDownButton',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

// Initial Selected Value
  String dropdownvalue = 'Item 1';

// List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Geeksforgeeks"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(

              // Initial Value
              value: dropdownvalue,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
