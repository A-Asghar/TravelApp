import 'package:flutter/material.dart';
import 'package:fyp/Constants.dart';
import 'package:fyp/widgets/poppinsText.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: poppinsText(text: "Help", size: 24.0, fontBold: FontWeight.w500),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                  color: Constants.secondaryColor,
                ),
              ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              poppinsText(
                text: 'ExploreEase Help Center',
                size: 24.0,
                fontBold: FontWeight.bold,
              ),
              SizedBox(height: 16.0),
              poppinsText(
                text:
                    'Welcome to the ExploreEase Help Center. Here, you\'ll find guides on how to use our application, troubleshoot common problems, and get the most out of your travel planning. Please refer to the relevant sections based on your queries.',
              ),
              SizedBox(height: 24.0),
              poppinsText(
                text: 'Getting Started',
                fontBold: FontWeight.bold,
                size: 18.0,
              ),
              SizedBox(height: 8),
              poppinsText(
                text: 'Creating an Account',
                fontBold: FontWeight.bold,
              ),
              poppinsText(text: 'Open the ExploreEase app.'),
              poppinsText(text: 'Tap "Sign Up".'),
              poppinsText(
                  text: 'You can sign up using your email or through Gmail.'),
              poppinsText(
                  text: 'Enter the necessary details and tap "Register".'),
              SizedBox(height: 16.0),
              poppinsText(
                text: 'Logging In',
                fontBold: FontWeight.bold,
              ),
              poppinsText(text: 'Open the ExploreEase app.'),
              poppinsText(text: 'Tap "Login".'),
              poppinsText(
                  text:
                      'Enter your registered email and password or login through Gmail.'),
              SizedBox(height: 16.0),
              poppinsText(
                text: 'Managing Account',
                fontBold: FontWeight.bold,
              ),
              poppinsText(text: 'For managing your account, click here.'),
              SizedBox(height: 24.0),
              poppinsText(
                text: 'Forgot Password?',
                fontBold: FontWeight.bold,
              ),
              poppinsText(
                  text:
                      'If you forgot your password, click here for a step-by-step guide to reset it.'),
              SizedBox(height: 24.0),
              poppinsText(
                text: 'Traveler Guide',
                fontBold: FontWeight.bold,
                size: 18.0,
              ),
              SizedBox(height: 8),
              poppinsText(
                text: 'Booking a Hotel',
                fontBold: FontWeight.bold,
              ),
              poppinsText(
                  text:
                      'Follow these simple steps to find and book a hotel that suits your needs. For a detailed walkthrough, click here.'),
              SizedBox(height: 16.0),
              poppinsText(
                text: 'Booking a Flight',
                fontBold: FontWeight.bold,
              ),
              poppinsText(
                  text:
                      'Finding and booking a flight has never been easier. For a detailed guide on how to book a flight, click here.'),
              SizedBox(height: 16.0),
              poppinsText(
                text: 'Booking a Vacation',
                fontBold: FontWeight.bold,
              ),
              poppinsText(
                  text:
                      'Discover, compare, and book vacation packages with our handy guide. Click here to learn more.'),
              SizedBox(height: 16.0),
              poppinsText(
                text: 'Managing Bookings',
                fontBold: FontWeight.bold,
              ),
              poppinsText(
                  text:
                      'For a guide on how to view, edit, and cancel your bookings, click here.'),
              SizedBox(height: 24.0),
              poppinsText(
                text: 'Travel Agency Guide',
                fontBold: FontWeight.bold,
                size: 18.0,
              ),
              SizedBox(height: 8),
              poppinsText(
                text: 'Creating an Account',
                fontBold: FontWeight.bold,
              ),
              poppinsText(
                  text:
                      'To create a travel agency account, click here for a step-by-step guide.'),
              SizedBox(height: 16.0),
              poppinsText(
                text: 'Managing Packages',
                fontBold: FontWeight.bold,
              ),
              poppinsText(
                  text:
                      'Learn how to create, update, and delete travel packages. For a detailed guide, click here.'),
              SizedBox(height: 16.0),
              poppinsText(
                text: 'Managing Bookings',
                fontBold: FontWeight.bold,
              ),
              poppinsText(
                  text:
                      'Find out how to accept, update, and cancel bookings, and communicate with customers. Click here to learn more.'),
              SizedBox(height: 24.0),
              poppinsText(
                text: 'Troubleshooting',
                fontBold: FontWeight.bold,
                size: 18.0,
              ),
              SizedBox(height: 8),
              poppinsText(
                  text:
                      'If you encounter any issues while using the app, visit our Troubleshooting page.'),
              SizedBox(height: 24.0),
              poppinsText(
                text: 'Contact Us',
                fontBold: FontWeight.bold,
                size: 18.0,
              ),
              SizedBox(height: 8),
              poppinsText(
                  text:
                      'Still can\'t find what you\'re looking for? Our Customer Service Team is available 24.0/7 to assist you. Click here to get in touch.'),
            ],
          ),
        ),
      ),
    );
  }
}
