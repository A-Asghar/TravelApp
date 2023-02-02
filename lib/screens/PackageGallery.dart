import 'package:flutter/material.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
        title: Text(
          "Gallery Hotel Photos",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
        ),
      ),
      body: GridView.builder(
        padding:
        const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 20),
        itemCount: 10,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 150,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  index == 0
                      ? 'assets/images/g1.png'
                      : index == 1
                      ? 'assets/images/g2.png'
                      : index == 2
                      ? 'assets/images/g3.png'
                      : index == 3
                      ? 'assets/images/g4.png'
                      : index == 4
                      ? 'assets/images/g5.png'
                      : index == 5
                      ? 'assets/images/g7.png'
                      : index == 6
                      ? 'assets/images/g11.png'
                      : index == 7
                      ? 'assets/images/g8.png'
                      : index == 8
                      ? 'assets/images/g9.png'
                      : 'assets/images/g10.png',
                ),
                fit: BoxFit.fill,
              ),
            ),
          );
        },
      ),
    );
  }
}
