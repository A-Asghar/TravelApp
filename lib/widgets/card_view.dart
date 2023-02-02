import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  const CardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff04060F).withOpacity(0.05),
            blurRadius: 8,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/d5.png",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Palazzo Versace",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Rome, Italia",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 14,
                      color: const Color(0xff757575),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color(0xffFFD300),
                        size: 15,
                      ),
                      Text(
                        "  4.8  ",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 14,
                          color: Colors.teal,
                        ),
                      ),
                      Text(
                        "(3,672 reviews)",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 14,
                          color: const Color(0xff757575),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
