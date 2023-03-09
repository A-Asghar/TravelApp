import 'package:flutter/material.dart';
import 'package:fyp/Constants.dart';
import 'package:fyp/widgets/poppinsText.dart';
import 'package:fyp/widgets/tealButton.dart';
import 'package:html/parser.dart' show parse;

class RoomDetails extends StatelessWidget {
  const RoomDetails({Key? key, required this.details}) : super(key: key);
  final String details;
  @override
  Widget build(BuildContext context) {
    List<String>? parsedDetails = parse(details).body?.text.split(' - ');
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 25,
            color: Constants.secondaryColor,
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
            child: ListView.builder(
                itemCount: parsedDetails?.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: poppinsText(text: '• ${parsedDetails![index]}'),
                  );
                }),
          ),
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
          color: Constants.secondaryColor,
          size: 12,
        ),
        const SizedBox(width: 10),
        poppinsText(text: text),
        const SizedBox(height: 10),
      ],
    );
  }
}
