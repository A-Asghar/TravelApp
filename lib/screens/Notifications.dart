import 'package:flutter/material.dart';

class TravelAgencyNotificationsPage extends StatelessWidget {
  final List<String> customerNames = [
    'Ahmed Khan',
    'Fatima Ali',
    'Muhammad Raza',
    'Aisha Siddiqui',
    'Hassan Zaidi',
    'Sara Hassan',
    'Usman Hussain',
    'Hira Ali',
    'Ali Sana',
    'Zainab Qureshi'
  ];

  final List<String> descriptions = [
    "Payment received: Ahmed Khan has successfully paid for the Bali package.",
    "New booking request: Fatima Ali is interested in booking our Bali package. Respond promptly.",
    "Package cancellation: Muhammad Raza has canceled their Dubai tour package.",
    "Payment received: Aisha Siddiqui has successfully paid for the Maldives package.",
    "New booking request: Hassan Zaidi is interested in booking our Thailand package. Respond promptly.",
    "Package cancellation: Sara Hassan has canceled their Europe tour package.",
    "Payment received: Usman Hussain has successfully paid for the Istanbul package.",
    "New booking request: Hira Ali is interested in booking our London package. Respond promptly.",
    "Package cancellation: Ali Sana has canceled their Singapore tour package.",
    "Payment received: Zainab Qureshi has successfully paid for the Paris package."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0), // Add padding around each notification
        child: buildNotificationsList(),
      ),
    );
  }

  Widget buildNotificationsList() {
    return ListView.builder(
      itemCount: descriptions.length,
      itemBuilder: (BuildContext context, int index) {
        final String description = descriptions[index];
        final String customerName = customerNames[index];
        return Container(
          margin: EdgeInsets.only(bottom: 8.0), // Add margin at the bottom of each notification
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.grey[200],
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0), // Add equal horizontal padding
            leading: Container(
              width: 38, // Set a fixed width for the container
              child: Icon(Icons.notifications),
            ),
            title: Text(
              customerName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(description),
            onTap: () {
              // Implement your notification handling logic here
            },
          ),

        );

      },
    );
  }
}