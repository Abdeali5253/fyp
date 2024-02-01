import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Numbers'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Police: 100'),
            onTap: () => _makePhoneCall('100'),
          ),
          ListTile(
            title: const Text('Ambulance: 102'),
            onTap: () => _makePhoneCall('102'),
          ),
          ListTile(
            title: const Text('Fire: 101'),
            onTap: () => _makePhoneCall('101'),
          ),
        ],
      ),
    );
  }
}
