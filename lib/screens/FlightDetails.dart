import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:fyp/screens/Profile.dart';
import 'package:fyp/widgets/poppinsText.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../Constants.dart';
import '../models/Flight.dart';

class FlightDetails extends StatefulWidget {
  const FlightDetails({Key? key, required this.trip}) : super(key: key);
  final Flight trip;

  @override
  State<FlightDetails> createState() => _FlightDetailsState();
}

class _FlightDetailsState extends State<FlightDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Constants.primaryColor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: poppinsText(text: 'Trip Details', size: 18.0),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Column(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  poppinsText(text: Constants.iataList[widget.trip.itineraries[0].segments[0].departure.iataCode]![1],fontBold: FontWeight.w500),
                  const SizedBox(width: 5,),
                  Lottie.asset('assets/lf30_editor_my7jjxvm.json',height: 20),
                  const SizedBox(width: 5,),
                  poppinsText(text: Constants.iataList[widget.trip.itineraries[0].segments.last.arrival.iataCode]![1],fontBold: FontWeight.w500),
                ],
              ),

              flightDetailsList(0),

              widget.trip.itineraries.length > 1 ?
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  poppinsText(text: Constants.iataList[widget.trip.itineraries[1].segments.last.arrival.iataCode]![1],fontBold: FontWeight.w500),
                  const SizedBox(width: 5,),
                  Transform.rotate(
                    angle: 180 * math.pi / 180,
                    child: Lottie.asset('assets/lf30_editor_my7jjxvm.json',height: 20),
                  ),
                  const SizedBox(width: 5,),
                  poppinsText(text: Constants.iataList[widget.trip.itineraries[1].segments[0].departure.iataCode]![1],fontBold: FontWeight.w500),
                ],
              ) : Container(),
              widget.trip.itineraries.length > 1 ?
              flightDetailsList(1) : Container(),

              const SizedBox(height: 10,),
              // Price
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    poppinsText(text: 'Total',size: 30.0),
                    const SizedBox(width: 10,),
                    poppinsText(text: '\$${widget.trip.price.grandTotal}',size: 30.0,fontBold: FontWeight.w500)
                  ],
                ),

              const SizedBox(height: 10,),
              // Buttons
              Row(
                children: [
                  const SizedBox(width: 10,),
                  CustomButton(text: 'Cancel', textColor: Constants.primaryColor ,bgColor: Colors.teal.withOpacity(0.1), onTap: ()=> Navigator.pop(context)),
                  const SizedBox(width: 10,),
                  CustomButton(text: 'Confirm', onTap: (){}, bgColor: Constants.primaryColor, textColor: Colors.white,),
                  const SizedBox(width: 10,),
                ],
              ),

              const SizedBox(height: 20,)


            ],
          )
        ],
      ),
    );
  }

  Widget flightDetailsList(itineraryIndex){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.trip.itineraries[itineraryIndex].segments.length,
      physics: const ScrollPhysics(),
      itemBuilder: (context,index){
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: Column(
                children: [
                  // Times
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      poppinsText(text: Constants.convertTime(widget.trip.itineraries[itineraryIndex].segments[index].departure.at),size: 20.0),
                      poppinsText(text: Constants.convertTime(widget.trip.itineraries[itineraryIndex].segments[index].arrival.at),size: 20.0),
                    ],
                  ),

                  // IATA Codes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      poppinsText(text: widget.trip.itineraries[itineraryIndex].segments[index].departure.iataCode),
                      const Expanded(
                        child: Divider(
                          color: Constants.secondaryColor,
                          indent: 20,
                          endIndent: 10,
                        ),
                      ),

                      // Airplane Icon
                      Transform.rotate(
                        angle: 90 * math.pi / 180,
                        child: const Icon(Icons.flight,color: Constants.primaryColor,size: 25,),
                      ),

                      const Expanded(
                          child: Divider(
                            color: Constants.secondaryColor,
                            indent: 10,
                            endIndent: 20,
                          )),
                      poppinsText(text: widget.trip.itineraries[itineraryIndex].segments[index].arrival.iataCode),
                    ],
                  ),

                  // Airports
                  Row(
                    children: [
                      SizedBox(
                          width: 120,
                          child: poppinsText(text: Constants.iataList[widget.trip.itineraries[itineraryIndex].segments[index].departure.iataCode]![0],size: 13.0,color: Constants.secondaryColor)
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 120,
                        child: Text(
                          Constants.iataList[widget.trip.itineraries[itineraryIndex].segments[index].arrival.iataCode]![0],
                          style: GoogleFonts.poppins(fontSize: 13.0,color: Constants.secondaryColor),textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Date & Duration
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width:120,
                        height: 50,
                        padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Constants.secondaryColor)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            poppinsText(text: 'Date',size: 12.0,color: Constants.secondaryColor),
                            Row(
                              children: [
                                const Icon(Icons.calendar_month_outlined,color: Colors.black,),
                                const SizedBox(width:5),
                                poppinsText(text: Constants.convertDate(widget.trip.itineraries[itineraryIndex].segments[index].departure.at))
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 20,),
                      Container(
                        width:120,
                        height: 50,
                        padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Constants.secondaryColor)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            poppinsText(text: 'Duration',size: 12.0,color: Constants.secondaryColor),
                            Row(
                              children: [
                                const Icon(Icons.access_time,color: Colors.black,),
                                const SizedBox(width: 5,),
                                poppinsText(text: widget.trip.itineraries[itineraryIndex].segments[index].duration.replaceAll('PT', '').replaceAll('H', 'H ').toLowerCase())
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
        );
      },
    );
  }
}
