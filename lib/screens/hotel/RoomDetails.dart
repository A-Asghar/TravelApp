import 'package:flutter/material.dart';
import 'package:fyp/widgets/poppinsText.dart';
import 'package:fyp/widgets/tealButton.dart';

class RoomDetails extends StatelessWidget {
  const RoomDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: poppinsText(text: 'Room Details'),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: poppinsText(
                    text: 'Twin Room', size: 18.0, fontBold: FontWeight.w500),
              ),
              item('Max Occupants: 1'),
              item('Bed type: Twin Bunk Bed'),
              item('Number of bedrooms: 1'),
              item('Number of bathrooms: 1'),
              item('Free Wifi'),
              item('Daily Housekeeping'),
              item('Breakfast available (additional charges)'),
              item('Payment: Credit Card'),
              item('Cancellation: Non-refundable'),
              item('Room size (sqf): 172'),
            ],
          )),
          Center(
            child: TealButton(
              text: 'Book Now',
              onPressed: () {},
            ),
          )
        ],
      ),
    ));
  }

  Widget item(text) {
    return Row(
      children: [
        const SizedBox(width: 10),
        const Icon(
          Icons.circle,
          color: Colors.black,
          size: 12,
        ),
        const SizedBox(width: 10),
        poppinsText(text: text),
        const SizedBox(height: 10),
      ],
    );
  }
}
