import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'ExploreEase Help Center',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Welcome to the ExploreEase Help Center. Here, you\'ll find guides on how to use our application, troubleshoot common problems, and get the most out of your travel planning. Please refer to the relevant sections based on your queries.',
              ),
              SizedBox(height: 24),
              Text(
                'Getting Started',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Creating an Account',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Open the ExploreEase app.'),
              Text('Tap "Sign Up".'),
              Text('You can sign up using your email or through Gmail.'),
              Text('Enter the necessary details and tap "Register".'),
              SizedBox(height: 16),
              Text(
                'Logging In',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Open the ExploreEase app.'),
              Text('Tap "Login".'),
              Text('Enter your registered email and password or login through Gmail.'),
              SizedBox(height: 16),
              Text(
                'Managing Account',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('For managing your account, click here.'),
              SizedBox(height: 24),
              Text(
                'Forgot Password?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('If you forgot your password, click here for a step-by-step guide to reset it.'),
              SizedBox(height: 24),
              Text(
                'Traveler Guide',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Booking a Hotel',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Follow these simple steps to find and book a hotel that suits your needs. For a detailed walkthrough, click here.'),
              SizedBox(height: 16),
              Text(
                'Booking a Flight',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Finding and booking a flight has never been easier. For a detailed guide on how to book a flight, click here.'),
              SizedBox(height: 16),
              Text(
                'Booking a Vacation',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Discover, compare, and book vacation packages with our handy guide. Click here to learn more.'),
              SizedBox(height: 16),
              Text(
                'Managing Bookings',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('For a guide on how to view, edit, and cancel your bookings, click here.'),
              SizedBox(height: 24),
              Text(
                'Travel Agency Guide',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Creating an Account',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('To create a travel agency account, click here for a step-by-step guide.'),
              SizedBox(height: 16),
              Text(
                'Managing Packages',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Learn how to create, update, and delete travel packages. For a detailed guide, click here.'),
              SizedBox(height: 16),
              Text(
                'Managing Bookings',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Find out how to accept, update, and cancel bookings, and communicate with customers. Click here to learn more.'),
              SizedBox(height: 24),
              Text(
                'Troubleshooting',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 8),
              Text('If you encounter any issues while using the app, visit our Troubleshooting page.'),
              SizedBox(height: 24),
              Text(
                'Contact Us',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 8),
              Text('Still can\'t find what you\'re looking for? Our Customer Service Team is available 24/7 to assist you. Click here to get in touch.'),
            ],
          ),
        ),
      ),
    );
  }
}