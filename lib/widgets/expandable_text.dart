import 'package:flutter/material.dart';
import 'package:fyp/Constants.dart';
import 'package:fyp/widgets/poppinsText.dart';

class ExpandableText extends StatefulWidget {
  final String text;

  const ExpandableText({super.key, required this.text});

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 150) {
      firstHalf = widget.text.substring(0, 150);
      secondHalf = widget.text.substring(150, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
      child: secondHalf.isEmpty
          ? poppinsText(
              text: firstHalf,
              color: Colors.grey,
            )
          : Column(
              children: <Widget>[
                poppinsText(
                  text: flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                  color: Constants.secondaryColor,
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      poppinsText(
                        text: flag ? "Show more" : "Show less",
                        color: Constants.primaryColor,
                        size: 16.0,
                      ),
                      Icon(
                        flag
                            ? Icons.arrow_drop_down_outlined
                            : Icons.arrow_drop_up,
                        color: Constants.primaryColor,
                      )
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    );
  }
}
