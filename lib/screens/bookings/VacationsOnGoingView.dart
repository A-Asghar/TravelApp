import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Constants.dart';
import '../../network/BookingNetwork.dart';
import '../../widgets/poppinsText.dart';

class VacationsOnGoingView extends StatefulWidget {
  const VacationsOnGoingView({Key? key}) : super(key: key);

  @override
  State<VacationsOnGoingView> createState() => _VacationsOnGoingViewState();
}

class _VacationsOnGoingViewState extends State<VacationsOnGoingView> {
  void initState() {
    super.initState();
    getTravelerBookings();
  }

  bool isLoading = false;
  List bookingsFromFirebase = [];

  getTravelerBookings() async {
    setState(() => isLoading = true);
    BookingNetwork bookingNetwork = BookingNetwork();
    var snapshot = await bookingNetwork.getTravelerPackageBooking(
        travelerId: FirebaseAuth.instance.currentUser?.uid);
    bookingsFromFirebase = snapshot.docs.map((doc) => doc.data()).toList();
    print(bookingsFromFirebase);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : bookingsFromFirebase.isEmpty
            ? Center(child: poppinsText(text: "No Bookings Yet!"))
            : Expanded(
                child: ListView.builder(
                  itemCount: bookingsFromFirebase.length,
                  padding: const EdgeInsets.only(bottom: 60),
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final vacation = bookingsFromFirebase[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: VacationCard(vacation: vacation),
                      ),
                    );
                  },
                ),
              );
  }
}

class VacationCard extends StatelessWidget {
  final dynamic vacation;

  const VacationCard({Key? key, required this.vacation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String imageUrl = vacation['imageUrl'];
    final String packageName = vacation['packageName'];
    final String destination = vacation['destination'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                poppinsText(
                  text: packageName,
                  size: 20.0,
                  fontBold: FontWeight.w500,
                ),
                const SizedBox(height: 15),
                poppinsText(
                  text: destination,
                  size: 14.0,
                ),
                const SizedBox(height: 10),
              ],
            )
          ],
        ),
      ],
    );
  }
}
