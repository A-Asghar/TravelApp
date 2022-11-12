import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Constants.dart';
import '../widgets/customTextField.dart';
import '../widgets/poppinsText.dart';
import 'Search.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              physics: const ClampingScrollPhysics(),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),

                    // Hello User
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        "Hello, Daniel 👋",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // SearchBar
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: CustomTextField(
                        hintText: "Search",
                        textFieldController: TextEditingController(),
                        prefix: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Icon(Icons.search),
                        ),
                        sufix: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Icon(Icons.filter_alt)),
                      ),
                    ),

                    const SizedBox(height: 20),

                     topIcons(context),

                    const SizedBox(height: 20),

                    // Hotels ListView builder
                    SizedBox(
                      height: 200,
                      width: Get.width,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(left: 20),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Container(
                              // height: 200,
                              width: 260,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(34),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    index % 2 == 0
                                        ? 'https://www.gannett-cdn.com/-mm-/05b227ad5b8ad4e9dcb53af4f31d7fbdb7fa901b/c=0-64-2119-1259/local/-/media/USATODAY/USATODAY/2014/08/13/1407953244000-177513283.jpg'
                                        : 'https://watermark.lovepik.com/photo/20211121/large/lovepik-hotel-room-picture_500597063.jpg',
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 20, bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          height: 32,
                                          width: 71,
                                          decoration: BoxDecoration(
                                            color: Constants.primaryColor,
                                            border: Border.all(
                                              color: Constants.primaryColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.white,
                                                  size: 15,
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  "4.8",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Emeralda De Hotel",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "Paris, France",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Text(
                                              "\$29",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                  ),
                                            ),
                                            Text(
                                              "/ per night",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        // Get.to(
                        //   const RecentlyBookScreen(),
                        //   transition: Transition.rightToLeft,
                        // );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Recommended Packages",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontSize: 18,
                                  ),
                            ),
                            Text(
                              "See All",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontSize: 16,
                                    color: Constants.primaryColor,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Column(children: [
                      for (var index = 0; index < 5; index++)
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 25, left: 20, right: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  Colors.white,
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
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(index == 0
                                            ? 'https://watermark.lovepik.com/photo/20211121/large/lovepik-hotel-room-picture_500597063.jpg'
                                            : index == 1
                                                ? 'https://cf.bstatic.com/xdata/images/hotel/max1024x768/325757142.jpg?k=a6f579d3f873feaae22eb034a656fa158a99093053f1f34ec7a78991ca9a32db&o=&hp=1'
                                                : index == 2
                                                    ? 'https://cdn.loewshotels.com/loewshotels.com-2466770763/cms/cache/v2/5f5a6e0d12749.jpg/1920x1080/fit/80/86e685af18659ee9ecca35c465603812.jpg'
                                                    : index == 3
                                                        ? 'https://www.gannett-cdn.com/-mm-/05b227ad5b8ad4e9dcb53af4f31d7fbdb7fa901b/c=0-64-2119-1259/local/-/media/USATODAY/USATODAY/2014/08/13/1407953244000-177513283.jpg'
                                                        : 'https://www.ohotelsindia.com/pune/images/b32d5dc553ee2097368bae13f83e93cf.jpg'),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          index == 0
                                              ? "Le Bristol Hotel"
                                              : index == 1
                                                  ? "Maison Souquet"
                                                  : index == 2
                                                      ? "Le Meurice Hotel"
                                                      : "Plaza Athenee",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                              ),
                                        ),
                                        const SizedBox(height: 15),
                                        Text(
                                          index == 0
                                              ? "Istanbul, Turkiye"
                                              : index == 1
                                                  ? "Paris, France"
                                                  : index == 2
                                                      ? "London, United Kingdom"
                                                      : "Rome, Italia",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
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
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    fontSize: 14,
                                                    color: Constants.primaryColor,
                                                  ),
                                            ),
                                            Text(
                                              index == 0
                                                  ? "(4,981 reviews)"
                                                  : index == 1
                                                      ? "(4,981 reviews)"
                                                      : index == 2
                                                          ? "(3,672 reviews)"
                                                          : index == 3
                                                              ? "(4,441 reviews)"
                                                              : "(4,338 reviews)",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    fontSize: 14,
                                                    color:
                                                        const Color(0xff757575),
                                                  ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          index == 0
                                              ? "\$27"
                                              : index == 1
                                                  ? "\$35"
                                                  : index == 2
                                                      ? "\$32"
                                                      : index == 3
                                                          ? "\$36"
                                                          : "\$38",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                fontSize: 18,
                                                color: Constants.primaryColor,
                                              ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "/ person",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                fontSize: 10,
                                                color: const Color(0xff757575),
                                              ),
                                        ),
                                        const SizedBox(height: 20),

                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                    ]),
                    const SizedBox(height: 100),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
  Widget topIcons(context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          iconBox(Icons.flight, 'Flights', () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Search(title: 'flight')));
          }),
          iconBox(Icons.location_city,  'Hotels', () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Search(title: 'hotel')));
          }),
          iconBox(Icons.beach_access,  'Vacations', () {}),
        ],
      ),
    );
  }

  Widget iconBox(icon,text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                      color: Colors.white,
                      blurRadius: 5.0,
                      offset: Offset(1.0, 0.75))
                ],
                color: Constants.primaryColor,
                borderRadius: BorderRadius.circular(15)),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          poppinsText(text: text)
        ],
      ),
    );
  }
}


class CustomField extends StatelessWidget {
  final String hintText;
  final TextEditingController textFieldController;

  final Widget sufix;
  const CustomField(
      {Key? key,
      required this.hintText,
      required this.textFieldController,
      required this.sufix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: Get.width,
      child: TextFormField(
        controller: textFieldController,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 14,
            ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 15, left: 16),
          fillColor: const Color(0xffFAFAFA),
          filled: true,
          hintText: hintText,
          suffixIcon: sufix,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: const Color(0xff9E9E9E),
                fontSize: 14,
              ),
        ),
      ),
    );
  }
}

Widget searchCard(String text, Color bgColor, VoidCallback onTap) {
  return InkWell(
    onTap: () {
      onTap();
    },
    child: Container(
      height: 38,
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(
          color: Constants.primaryColor,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Center(
          child: Text(
            text,
            style: Theme.of(Get.context!).textTheme.bodyText1!.copyWith(
                  fontSize: 16,
                  color: bgColor == Constants.primaryColor ? Colors.white : Constants.primaryColor,
                ),
          ),
        ),
      ),
    ),
  );
}
