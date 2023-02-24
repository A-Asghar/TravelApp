import 'package:flutter/material.dart';
import 'package:fyp/screens/Home2.dart';

import '../Constants.dart';
import '../widgets/poppinsText.dart';
import '../widgets/tealButton.dart';

class BoardingPass extends StatefulWidget {
  const BoardingPass({Key? key}) : super(key: key);

  @override
  State<BoardingPass> createState() => _BoardingPassState();
}

class _BoardingPassState extends State<BoardingPass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).textTheme.bodyText1!.color!,
          ),
        ),
        title: Text(
          "Boarding pass",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: ListView(
              children: [
                Row(
                  children: <Widget>[
                    Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/user.png"),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        poppinsText(
                            text: 'Abdullah \nAmin ',
                            size: 16.0,
                            fontBold: FontWeight.w500),
                      ],
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(color: Constants.secondaryColor),
                Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Flight Carrier
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: poppinsText(
                                  text: 'Flight Duration',
                                  size: 16.0,
                                  fontBold: FontWeight.w500),
                            ),

                            // Trip Duration
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              child: poppinsText(
                                text: '2 hrs',
                                // text: '${Constants.minutesToDuration(flight.segments.last.arrival.at.difference(flight.segments[0].departure.at).inMinutes)}',
                                color: Constants.secondaryColor,
                              ),
                            )
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Departure Time
                              poppinsText(
                                  text: '15:00',
                                  size: 22.0,
                                  fontBold: FontWeight.w400),
                              const Expanded(
                                child: Divider(
                                  color: Constants.secondaryColor,
                                  indent: 20,
                                  endIndent: 10,
                                ),
                              ),

                              // Airplane Icon
                              Transform.rotate(
                                angle: 90 * 3.1415 / 180,
                                child: const Icon(
                                  Icons.flight,
                                  color: Constants.primaryColor,
                                  size: 25,
                                ),
                              ),

                              const Expanded(
                                  child: Divider(
                                color: Constants.secondaryColor,
                                indent: 10,
                                endIndent: 20,
                              )),

                              // Arrival Time
                              poppinsText(
                                  text: '17:00',
                                  size: 22.0,
                                  fontBold: FontWeight.w400),
                            ]),
                      ),

                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            poppinsText(
                                text: 'Khi', color: Constants.secondaryColor),
                            poppinsText(
                                text: 'Dubai', color: Constants.secondaryColor),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          children: [
                            // Flight Class
                            Row(
                              children: [
                                const Icon(
                                  Icons.event_seat,
                                  color: Constants.secondaryColor,
                                  size: 15,
                                ),
                                const SizedBox(width: 5),
                                poppinsText(
                                    text: 'ECONOMY',
                                    color: Constants.secondaryColor,
                                    size: 14.0,
                                    fontBold: FontWeight.w500)
                              ],
                            ),

                            const Spacer(),

                            poppinsText(
                                text: 'Date', color: Constants.secondaryColor),
                            const SizedBox(
                              width: 10,
                            ),
                            // Trip Price
                            poppinsText(
                              text: '17/07/2022 ',
                              color: Constants.secondaryColor,
                              fontBold: FontWeight.w500,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(color: Constants.secondaryColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        poppinsText(
                          text: 'Flight',
                          color: Constants.secondaryColor,
                        ),
                        poppinsText(
                            text: 'IN 230 ',
                            size: 16.0,
                            fontBold: FontWeight.w500),
                      ],
                    ),
                    Column(
                      children: [
                        poppinsText(
                          text: 'Gate',
                          color: Constants.secondaryColor,
                        ),
                        poppinsText(
                            text: '22', size: 16.0, fontBold: FontWeight.w500),
                      ],
                    ),
                    Column(
                      children: [
                        poppinsText(
                          text: 'Seat',
                          color: Constants.secondaryColor,
                        ),
                        poppinsText(
                            text: '2B', size: 16.0, fontBold: FontWeight.w500),
                      ],
                    ),
                    Column(
                      children: [
                        poppinsText(
                          text: 'Class',
                          color: Constants.secondaryColor,
                        ),
                        poppinsText(
                            text: 'Economy',
                            size: 16.0,
                            fontBold: FontWeight.w500),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(color: Constants.secondaryColor),
              ],
            )),
            Center(
              child: TealButton(
                text: "Back to home",
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Home2(),
                  ));
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget customColumn(String text1, String text2) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text1,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 16,
                  color: const Color(0xff757575),
                ),
          ),
          const SizedBox(height: 8),
          Text(
            text2,
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
