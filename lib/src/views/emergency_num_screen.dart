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

  Widget _buildEmergencyTile(String title, String number, IconData icon, Color color) {
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
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Numbers'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          _buildEmergencyTile('Police', '15', Icons.local_police, Colors.blue),
          _buildEmergencyTile('Ambulance', '115', Icons.local_hospital, Colors.red),
          _buildEmergencyTile('Fire', '16', Icons.local_fire_department, Colors.orange),
          _buildEmergencyTile("Rescue Service", "1122", Icons.local_taxi_rounded, Colors.redAccent)
        ],
      ),
    );
  }
}
