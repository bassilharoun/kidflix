import 'package:flutter/material.dart';
import 'package:kidflix_app/app/styles/color.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({Key? key}) : super(key: key);

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(Icons.privacy_tip_outlined,
                  size: 55, color: AppColors.purble),
              const SizedBox(height: 15),
              const Text(
                "Privacy Policy",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
              const SizedBox(height: 15),
              const Text(
                "Welcome to Kidflix App!\n\n"
                "Our top priority is ensuring a safe and enjoyable experience for children while respecting the privacy of all users. This Privacy Policy outlines the types of information we collect, how we use it, and how we keep it secure.\n\n"
                "1. **Data Collection**\n"
                "We collect only the minimal necessary information to enhance user experience. For users under 13, we do not knowingly collect personal information such as name, email, or location data.\n\n"
                "2. **Information Usage**\n"
                "Any data we collect is strictly used to improve app performance, provide better content recommendations, and understand app functionality. We may use analytics to improve the app, but this data is anonymized.\n\n"
                "3. **Third-Party Links and Content**\n"
                "This app may contain links to child-friendly third-party content. We are not responsible for the content or privacy practices of third-party services. Parents are encouraged to review any external content before allowing children to access it.\n\n"
                "4. **Security Measures**\n"
                "We take appropriate security measures to protect data within the app. However, please note that no data transmission over the internet is entirely secure, so we encourage parents to supervise their children's use of the app.\n\n"
                "5. **Parental Controls**\n"
                "Parents can monitor and control various app features. We recommend that parents use these tools to help protect their child's privacy and maintain a safe experience.\n\n"
                "6. **Changes to Privacy Policy**\n"
                "We may update our Privacy Policy periodically. Parents will be notified of any significant changes through app updates or notifications within the app.\n\n"
                "7. **Contact Us**\n"
                "If you have any questions about our Privacy Policy, please contact us at support@kidflix.com.\n\n"
                "By using Kids Video App, you agree to our Privacy Policy and practices described above. Thank you for helping us provide a safe environment for all children.\n",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
