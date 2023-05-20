import 'package:flutter/material.dart';
import 'package:travel_agency/Constants.dart';
import 'package:travel_agency/screens/fullscreen_image_screen.dart';

class PackageGallery extends StatefulWidget {
  const PackageGallery({super.key, required this.packageImages});

  final List<String> packageImages;

  @override
  State<PackageGallery> createState() => _PackageGalleryState();
}

class _PackageGalleryState extends State<PackageGallery> {
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
                color: Constants.secondaryColor,
                size: 25,
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
        itemCount: widget.packageImages.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 150,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (BuildContext context, int index) {
          var image = widget.packageImages[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullScreenImagePage(
                    image: image.isEmpty || image == "" ? 'https://www.iconsdb.com/icons/preview/gray/mountain-xxl.png' : image,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                image: DecorationImage(
                  image: NetworkImage(image.isEmpty || image == "" ? 'https://www.iconsdb.com/icons/preview/gray/mountain-xxl.png' : image),
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
