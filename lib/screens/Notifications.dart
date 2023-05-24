import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  final List<String> names = [
    'Wanderlust Adventures',
    'Dream Destinations',
    'Global Excursions',
    'Paradise Voyagers',
    'Serene Getaways',
    'Epic Explorations',
    'Marvelous Journeys',
    'Blissful Retreats',
    'Enchanting Escapes',
    'Majestic Travels'
  ];

  final List<String> descriptions = [
    "New travel package available: Discover the enchanting beaches of Bali at unbeatable prices!",
    "Exciting news! Our popular tour to the majestic Machu Picchu has limited slots remaining. Book now!",
    "You've received a personalized itinerary for your upcoming trip to Paris. Check it out\!",
    "Attention adventure seekers! Join our thrilling hiking expedition to Everest Base Camp. Limited spots available!",
    "Congratulations! You've earned a special discount on your next booking with us. Don't miss out!",
    "New blog post: Top 10 hidden gems in Italy. Get inspired for your next European adventure!",
    "Thank you for choosing us! We've upgraded your hotel room to a suite for a more luxurious stay.",
    "Exclusive offer for our loyal customers: Enjoy a complimentary spa treatment during your trip to Thailand.",
    "Important travel update: Due to unforeseen circumstances, there has been a slight change in your itinerary. Please review the details.",
    "Looking for unique travel experiences? Explore our curated list of off-the-beaten-path destinations for your next journey.",
  ];

  final List<String> profilePictureUrls = [
    'https://img.freepik.com/free-vector/detailed-travel-logo_23-2148616611.jpg',
    'https://static.vecteezy.com/system/resources/previews/007/874/109/non_2x/travel-logo-design-travel-agency-logo-inspiration-vector.jpg',
    'https://images-platform.99static.com//FGKbEryfX5ZrEwt-z766KwM-_kI=/262x150:795x683/fit-in/590x590/99designs-contests-attachments/42/42603/attachment_42603907',
    'https://cdn4.vectorstock.com/i/1000x1000/44/33/modern-holiday-travel-agency-logo-vector-34694433.jpg',
    'https://imgproxy.epicpxls.com/c8FI8afYYMrAiR26g0wjfa3WfA1KaI6cl8iiqLvRX24/rs:fill:800:600:0/g:no/aHR0cHM6Ly9pdGVt/cy5lcGljcHhscy5j/b20vdXBsb2Fkcy9w/aG90by83ODM1MmU3/NTVkNTYwMWY4MTUy/MDA5MDZiY2E5YjQ3/OA.jpg',
    'https://img.freepik.com/free-vector/creative-minimalist-travel-logo_23-2148611861.jpg?w=2000',
    'https://cdn2.vectorstock.com/i/1000x1000/83/61/modern-plane-travel-agency-logo-vector-46178361.jpg',
    'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/19fa6d83296767.5d381463c5645.jpg',
    'https://png.pngtree.com/png-clipart/20200727/original/pngtree-travel-agency-logo-design-holiday-logo-design-template-png-image_5244975.jpg',
    'https://i.pinimg.com/736x/94/3f/38/943f38fe0890506c1d61e817de73f19a--travel-agency-design-offices-logo-travel-agency.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            final String name = names[index];
            final String description = descriptions[index];
            final String profilePictureUrl = profilePictureUrls[index];

            return Card(
              elevation: 2.0,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(profilePictureUrl),
                ),
                title: Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  description,
                  style: TextStyle(fontSize: 14.0),
                ),
                onTap: () {
                  // Implement your notification handling logic here
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
