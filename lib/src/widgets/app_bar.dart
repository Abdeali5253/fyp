
import 'package:flutter/material.dart';
import 'package:fyp/src/views/signup.dart';
import '../views/home_screen.dart';
import '../views/emergency_num_screen.dart';
import '../views/settings.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;
  final bool showHomeIcon;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.showHomeIcon = false,
  }) : preferredSize = const Size.fromHeight(60.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dynamic gradient based on app theme
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final gradientColors = isDarkMode
        ? [Colors.blueGrey.shade800, Colors.black87]
        : [Colors.lightBlue.shade300, Colors.blue.shade400];

    return AppBar(
      title: Text(title, style: TextStyle(color: isDarkMode ? Colors.white : Colors.white)),
      backgroundColor: Colors.transparent, // Making AppBar background transparent
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
        ),
      ),
      actions: <Widget>[
        if (showHomeIcon)
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (Route<dynamic> route) => false,
            ),
          ),
        if(title == 'Flood Alert App')
        IconButton(
          icon: const Icon(Icons.login, color: Colors.white),
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const SignUpScreen()),
                (Route<dynamic> route) => false,
          ),
        ),
        if (title == 'Settings' || title == 'Flood Alert App' || title == 'Sign Up')
          IconButton(
            icon: const Icon(Icons.contact_phone, color: Colors.white),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const EmergencyNumScreen())),
          ),
        if (title == 'Emergency Contacts' || title == 'Flood Alert App')
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SettingsScreen())),
          ),
      ],
      elevation: 10.0, // Adds shadow for depth
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30), // Rounded bottom edges
        ),
      ),
    );
  }
}
