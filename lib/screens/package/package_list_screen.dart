import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:travel_agency/Constants.dart';
import 'package:travel_agency/models/package.dart';
import 'package:travel_agency/network/package_network.dart';
import 'package:travel_agency/providers/user_provider.dart';
import 'package:travel_agency/providers/package_provider.dart';
import 'package:travel_agency/screens/package/add_package.dart';
import 'package:travel_agency/screens/package/edit_package.dart';
import 'package:travel_agency/widgets/heart_beat_floating_action_button.dart';
import 'package:travel_agency/widgets/lottie_loader.dart';
import 'package:travel_agency/widgets/poppinsText.dart';
import 'package:travel_agency/widgets/side_drawer.dart';
import 'package:travel_agency/widgets/tealButton.dart';

class PackageListScreen extends StatefulWidget {
  const PackageListScreen({super.key});

  @override
  State<PackageListScreen> createState() => _PackageListScreenState();
}

class _PackageListScreenState extends State<PackageListScreen> {
  PackageNetwork packageNetwork = PackageNetwork();
  bool isLoading = false;
  final _scrollController = ScrollController();
  bool showBtn = false;
  bool _isDrawerOpen = false;
  final UserProvider controller = Get.put(UserProvider());

  @override
  void initState() {
    super.initState();
    // fetchPackages();
    _scrollController.addListener(() {
      double showOffset = 10.0;
      if (_scrollController.offset > showOffset) {
        showBtn = true;
        setState(() {
          //update state
        });
      } else {
        showBtn = false;
        setState(() {
          //update state
        });
      }
    });
  }

  fetchPackages() async {
    PackageNetwork packageNetwork = PackageNetwork();
    context.read<PackageProvider>().agencyPackages = await packageNetwork
        .fetchAgencyPackages(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            title: poppinsText(
                text: 'Your Packages',
                fontBold: FontWeight.w600,
                color: Constants.secondaryColor,
                size: 24.0),
            actions: [
              Builder(
                builder: (context) => IconButton(
                  icon: CircleAvatar(
                    backgroundColor: Constants.primaryColor,
                    child: controller.user!.profilePhotoUrl ==
                                "assets/images/user.png" ||
                            controller.user!.profilePhotoUrl.isEmpty
                        ? poppinsText(
                            text: controller.user!.name.substring(0, 1),
                            size: 20.0,
                            color: Colors.white,
                            fontBold: FontWeight.w500)
                        : CircleAvatar(
                            backgroundImage: NetworkImage(
                              controller.user!.profilePhotoUrl,
                            ),
                          ),
                  ),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  iconSize: 50,
                ),
              ),
            ],
          ),
          body: context.watch<PackageProvider>().agencyPackages.isEmpty
              ? const PackagePromptLayout()
              : const PackageListLayout(),
          endDrawer: const SideDrawer(),
          endDrawerEnableOpenDragGesture: true,
          onEndDrawerChanged: (isOpen) {
            _isDrawerOpen = isOpen;
          },
        ),
        Positioned(
          bottom: 30,
          right: 20,
          child: _isDrawerOpen
              ? Container()
              : showBtn
                  ? FloatingActionButton(
                      onPressed: () {
                        _scrollController.animateTo(
                            //go to top of scroll
                            0, //scroll offset to go
                            duration: Duration(
                                milliseconds: 500), //duration of scroll
                            curve: Curves.fastOutSlowIn //scroll type
                            );
                      },
                      child: Icon(Icons.arrow_upward_outlined),
                      backgroundColor: Constants.primaryColor,
                    )
                  : HeartbeatFloatingActionButton(onPressed: () {
                      Get.to(AddPackageForm(), transition: Transition.fade);
                    }),
        ),
      ],
    );
  }
}

class PackageTile extends StatefulWidget {
  const PackageTile({super.key, required this.package, required this.index});
  final Package package;
  final int index;

  @override
  State<PackageTile> createState() => _PackageTileState();
}

class _PackageTileState extends State<PackageTile> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 15.0,
          ),
          height: 160,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
          child: Row(
            children: [
              Container(
                height: 120,
                width: 130,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: widget.package.imgUrls.isEmpty ||
                            widget.package.imgUrls[0] == ""
                        ? AssetImage('assets/images/greymountain.png')
                            as ImageProvider<Object>
                        : NetworkImage(widget.package.imgUrls[0])
                            as ImageProvider<Object>,
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Container(
                height: 130,
                width: 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    poppinsText(
                        text: widget.package.packageName,
                        fontBold: FontWeight.w600,
                        size: 16.0),
                    const SizedBox(
                      height: 3.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_sharp,
                            color: Constants.primaryColor,
                            size: 18.0,
                          ),
                          poppinsText(
                              text: widget.package.destination.split(',').first,
                              size: 14.0,
                              color: Colors.grey.shade600,
                              fontBold: FontWeight.w500),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 3.0,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 18.0,
                        ),
                        poppinsText(
                            text: widget.package.rating.toString(),
                            size: 14.0,
                            color: Constants.secondaryColor,
                            fontBold: FontWeight.w500),
                      ],
                    ),
                    const SizedBox(
                      height: 3.0,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.monetization_on,
                          color: Constants.primaryColor,
                          size: 18.0,
                        ),
                        poppinsText(
                            text:
                                '${widget.package.numOfSales.toString()} Sales',
                            size: 14.0,
                            color: Constants.secondaryColor,
                            fontBold: FontWeight.w500),
                      ],
                    ),
                    const SizedBox(
                      height: 3.0,
                    ),
                    Row(
                      children: [
                        poppinsText(
                            text: '\S${widget.package.packagePrice.toString()}',
                            color: Constants.primaryColor,
                            fontBold: FontWeight.w600,
                            size: 18.0),
                        poppinsText(
                            text: ' /person',
                            color: Constants.secondaryColor,
                            size: 12.0)
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: 150,
                width: 40,
                child: Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Constants.primaryColor,
                      ),
                      onPressed: () {
                        Get.to(
                            EditPackageForm(
                              package: widget.package,
                              index: widget.index,
                            ),
                            transition: Transition.cupertino);
                      },
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        PackageNetwork packageNetwork = PackageNetwork();
                        Get.bottomSheet(
                          Container(
                            height: MediaQuery.of(context).size.height * 0.33,
                            width: Get.width,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  poppinsText(
                                      text: "Delete",
                                      size: 24.0,
                                      color: const Color(0xffF75555),
                                      fontBold: FontWeight.w500),
                                  const SizedBox(height: 20),
                                  const Divider(
                                      color: Constants.secondaryColor),
                                  poppinsText(
                                    text:
                                        "Are you sure you want to delete this package?",
                                    size: 16.0,
                                  ),
                                  const SizedBox(height: 20),
                                  isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.red,
                                          ),
                                        )
                                      : TealButton(
                                          text: "Yes, Delete",
                                          onPressed: () async {
                                            setState(() => isLoading = true);
                                            try {
                                              context
                                                  .read<PackageProvider>()
                                                  .agencyPackages
                                                  .removeAt(widget.index);
                                              await packageNetwork
                                                  .deletePackage(
                                                      packageId: widget
                                                          .package.packageId);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: poppinsText(
                                                      text:
                                                          "Package successfully deleted!",
                                                      color: Colors.white,
                                                      size: 16.0,
                                                      fontBold:
                                                          FontWeight.w400),
                                                  backgroundColor:
                                                      Constants.primaryColor,
                                                ),
                                                // Get.offAll(
                                                //   const PackageListScreen(),
                                                //   transition: Transition.rightToLeft,
                                                // );
                                              );
                                              setState(() => isLoading = false);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          PackageListScreen())));
                                              Navigator.pop(context);
                                            } on FirebaseException catch (e) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: poppinsText(
                                                      text:
                                                          "Package successfully deleted!",
                                                      color: Colors.white,
                                                      size: 16.0,
                                                      fontBold:
                                                          FontWeight.w400),
                                                  backgroundColor: Colors.red,
                                                ),
                                                // Get.offAll(
                                                //   const PackageListScreen(),
                                                //   transition: Transition.rightToLeft,
                                                // );
                                              );
                                              setState(() => isLoading = false);
                                            }
                                          },
                                          bgColor: Colors.red.withOpacity(0.3),
                                          txtColor: Colors.red,
                                        ),
                                  TealButton(
                                    text: "Cancel",
                                    bgColor: Constants.primaryColor,
                                    txtColor: Colors.white,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  const SizedBox(height: 15),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PackageListLayout extends StatefulWidget {
  const PackageListLayout({super.key});

  @override
  State<PackageListLayout> createState() => _PackageListLayoutState();
}

class _PackageListLayoutState extends State<PackageListLayout> {
  final _scrollController = ScrollController();
  bool showBtn = false;
  bool _isDrawerOpen = false;
  final UserProvider controller = Get.put(UserProvider());

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      double showOffset = 10.0;
      if (_scrollController.offset > showOffset) {
        showBtn = true;
        setState(() {
          //update state
        });
      } else {
        showBtn = false;
        setState(() {
          //update state
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var packageProvider = context.watch<PackageProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: poppinsText(
            text: 'Your Packages',
            fontBold: FontWeight.w600,
            color: Constants.secondaryColor,
            size: 24.0),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: CircleAvatar(
                backgroundColor: Constants.primaryColor,
                child: controller.user!.profilePhotoUrl ==
                            "assets/images/user.png" ||
                        controller.user!.profilePhotoUrl.isEmpty
                    ? poppinsText(
                        text: controller.user!.name.substring(0, 1),
                        size: 20.0,
                        color: Colors.white,
                        fontBold: FontWeight.w500)
                    : CircleAvatar(
                        backgroundImage: NetworkImage(
                          controller.user!.profilePhotoUrl,
                        ),
                      ),
              ),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              iconSize: 50,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: packageProvider.agencyPackages.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return PackageTile(
            package: packageProvider.agencyPackages[index],
            index: index,
          );
        },
        controller: _scrollController,
      ),
      endDrawer: SideDrawer(),
      endDrawerEnableOpenDragGesture: true,
      onEndDrawerChanged: (isOpen) {
        _isDrawerOpen = isOpen;
      },
      floatingActionButton: showBtn
          ? FloatingActionButton(
              onPressed: () {
                _scrollController.animateTo(
                    //go to top of scroll
                    0, //scroll offset to go
                    duration: Duration(milliseconds: 500), //duration of scroll
                    curve: Curves.fastOutSlowIn //scroll type
                    );
              },
              child: Icon(Icons.arrow_upward_outlined),
              backgroundColor: Constants.primaryColor,
            )
          : HeartbeatFloatingActionButton(onPressed: () {
              Get.to(AddPackageForm(), transition: Transition.fade);
            }),
    );
  }
}

class PackagePromptLayout extends StatefulWidget {
  const PackagePromptLayout({super.key});

  @override
  State<PackagePromptLayout> createState() => _PackagePromptLayoutState();
}

class _PackagePromptLayoutState extends State<PackagePromptLayout> {
  final UserProvider controller = Get.put(UserProvider());
  bool _isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: poppinsText(
            text: 'Your Packages',
            fontBold: FontWeight.w600,
            color: Constants.secondaryColor,
            size: 24.0),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: CircleAvatar(
                backgroundColor: Constants.primaryColor,
                child: controller.user!.profilePhotoUrl ==
                            "assets/images/user.png" ||
                        controller.user!.profilePhotoUrl.isEmpty
                    ? poppinsText(
                        text: controller.user!.name.substring(0, 1),
                        size: 20.0,
                        color: Colors.white,
                        fontBold: FontWeight.w500)
                    : CircleAvatar(
                        backgroundImage: NetworkImage(
                          controller.user!.profilePhotoUrl,
                        ),
                      ),
              ),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              iconSize: 50,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          Center(
            child: poppinsText(
                text: "No packages yet?",
                color: Color.fromRGBO(158, 158, 158, 1),
                size: 24.0,
                fontBold: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          Center(
            child: poppinsText(
                text: "Wanna try?",
                color: Colors.grey,
                size: 24.0,
                fontBold: FontWeight.w600),
          ),
          const SizedBox(height: 16),
        ],
      ),
      endDrawer: SideDrawer(),
      endDrawerEnableOpenDragGesture: true,
      onEndDrawerChanged: (isOpen) {
        _isDrawerOpen = isOpen;
      },
      floatingActionButton: HeartbeatFloatingActionButton(onPressed: () {
        Get.to(AddPackageForm(), transition: Transition.fade);
      }),
    );
  }
}
