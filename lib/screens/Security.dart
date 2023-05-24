import 'package:flutter/material.dart';
import 'package:fyp/widgets/poppinsText.dart';

class SecurityPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: poppinsText(text: 'ExploreEase Security Page', size: 24.0, fontBold: FontWeight.w500),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ExploreEase Security Page',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'At ExploreEase, we prioritize the security and privacy of our users. We have stringent security measures in place to protect user data and ensure secure transactions on our platform. Below are the various ways we work to keep your information safe.',
            ),
            SizedBox(height: 16),
            Text(
              'User Data Protection',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Account Security',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '1. Strong Password Policy: We require our users to create a password with a minimum of 8 characters, including at least one uppercase letter, one special symbol, and one numeric character.',
            ),
            Text(
              '2. Multiple Login Attempts: To prevent unauthorized access, three consecutive unsuccessful login attempts will disable the user\'s account. You will need to follow our account recovery process to regain access.',
            ),
            Text(
              '3. Automatic Logout: For your safety, we automatically log out all users after a period of inactivity. This is to prevent unauthorized access to your account should you forget to log out.',
            ),
            SizedBox(height: 16),
            Text(
              'Privacy',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '1. User Privacy: Privacy is of utmost importance to us. We ensure that no user can gain improper access to another\'s profile. All user data and account details are strictly confidential.',
            ),
            Text(
              '2. Cookie Management: We value your privacy and ensure that our system does not leave any cookies on your computer containing your password or any confidential information.',
            ),
            SizedBox(height: 16),
            Text(
              'System Security',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '1. Exception Handling: Our system is equipped with advanced exception handling techniques to ensure our platform remains stable and secure. We strive to prevent any crashes or disruptions to our service.',
            ),
            Text(
              '2. Backup Facility: We regularly create copies of our database and have a backup facility to prevent data loss in the case of database failure.',
            ),
            Text(
              '3. Closed Source System: Our application is closed source to prevent malicious tampering and maintain the integrity and security of our system.',
            ),
            SizedBox(height: 16),
            Text(
              'Performance and Usability',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '1. Quick Processing: We understand the value of your time. Our system is designed for speedy processing of operations, with quick loading and updating of the user interface, and seamless inter-application communication.',
            ),
            Text(
              '2. User-friendly Interaction: Our application is designed following HCI principles for a user-friendly interaction, ensuring a pleasant user experience.',
            ),
            SizedBox(height: 16),
            Text(
              'Contacting Us',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'In case of any security concerns or if you observe any suspicious activity, please contact our customer support immediately. Our dedicated team strives to fix any system errors within 24 hours to ensure a seamless and safe user experience.',
            ),
            SizedBox(height: 16),
            Text(
              'Responsible Usage',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'We encourage all users to use our platform responsibly. Keep your account details secure, avoid sharing personal information with others, and ensure you log out of your account when you\'re done. For more tips on safe usage, please visit our Help page.',
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}