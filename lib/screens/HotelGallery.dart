import 'package:flutter/material.dart';
import 'package:fyp/models/Detail.dart';

import 'FullScreenImagePage.dart';

class HotelGallery extends StatefulWidget {
  const HotelGallery({Key? key, required this.hotelImages}) : super(key: key);
  final List<ImageImage?> hotelImages;

  @override
  State<HotelGallery> createState() => _HotelGalleryState();
}

class _HotelGalleryState extends State<HotelGallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const SizedBox(
              width: 30,
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 30,
              ),
            )),
        title: Text(
          "Gallery Hotel Photos",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
        ),
      ),
      body: GridView.builder(
        padding:
            const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 20),
        itemCount: widget.hotelImages.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 150,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (BuildContext context, int index) {
          var image = widget.hotelImages[index]!;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullScreenImagePage(
                    image: image.url!,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                image: DecorationImage(
                  image: NetworkImage(image.url!),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
