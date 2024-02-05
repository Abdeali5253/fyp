import 'package:flutter/material.dart';
import 'package:fyp/src/services/auth_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/responsive.dart';
import '../widgets/app_bar.dart';

class EmergencyNumScreen extends StatelessWidget {
  const EmergencyNumScreen({Key? key}) : super(key: key);

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildEmergencyTile(String title, String number, IconData icon,
      Color color, BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4.0,
      shadowColor: color.withOpacity(0.5),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(number, style: TextStyle(color: Colors.grey[600])),
        trailing: Icon(Icons.call, color: Colors.green[700]),
        onTap: () => _makePhoneCall(number),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              ResponsiveUtil.responsiveButtonCornerRadius(context)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthService auth = AuthService();
    final user = auth.checkUser();
    final loggedIn = user != null ? true : false;
    return Scaffold(
      appBar: CustomAppBar(
          title: 'Emergency Contacts',
          showHomeIcon: true,
          isUserLoggedIn: loggedIn),
      body: ListView(
        padding: EdgeInsets.all(ResponsiveUtil.responsivePadding(context)),
        children: <Widget>[
          _buildEmergencyTile(
              'Police', '15', Icons.local_police, Colors.blue, context),
          _buildEmergencyTile(
              'Ambulance', '115', Icons.local_hospital, Colors.red, context),
          _buildEmergencyTile('Fire', '16', Icons.local_fire_department,
              Colors.orange, context),
          _buildEmergencyTile("Rescue Service", "1122",
              Icons.local_taxi_rounded, Colors.redAccent, context)
        ],
      ),
    );
  }
}
