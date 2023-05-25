import 'package:flutter/material.dart';
import 'package:fyp/Constants.dart';
import 'package:fyp/models/Detail.dart';
import 'package:fyp/widgets/poppinsText.dart';

class HotelImageSlider extends StatefulWidget {
  const HotelImageSlider({Key? key, required this.propertyImages})
      : super(key: key);

  final List<ImageImage?> propertyImages;

  @override
  State<HotelImageSlider> createState() => _HotelImageSliderState();
}

class _HotelImageSliderState extends State<HotelImageSlider> {
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
                  widget.propertyImages[pagePosition]!.url!,
                  fit: BoxFit.cover,
                  width: double.maxFinite,
                  height: 370,
                  loadingBuilder: ((context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Constants.primaryColor,
                      ),
                    );
                  }),
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
