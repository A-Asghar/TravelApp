import 'package:flutter/material.dart';
import 'package:travel_agency/widgets/poppinsText.dart';

class PackageImageSlider extends StatefulWidget {
  const PackageImageSlider({Key? key, required this.propertyImages})
      : super(key: key);

  final List<String> propertyImages;

  @override
  State<PackageImageSlider> createState() => _PackageImageSliderState();
}

class _PackageImageSliderState extends State<PackageImageSlider> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        itemCount: widget.propertyImages.length,
        pageSnapping: true,
        itemBuilder: (context, pagePosition) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Image.network(
                  widget.propertyImages.isEmpty || widget.propertyImages[pagePosition] == "" ?
                  'https://www.iconsdb.com/icons/preview/gray/mountain-xxl.png' :
                  widget.propertyImages[pagePosition],
                  fit: BoxFit.cover,
                  width: double.maxFinite,
                  height: 370,
                ),
                Positioned(
                  right: 10,
                  bottom: 20,
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(5)),
                      child: poppinsText(
                          text:
                              '${pagePosition + 1}/${widget.propertyImages.length}',
                          color: Colors.white)),
                )
              ],
            ),
          );
        });
  }
}
