import 'package:flutter/material.dart';

import '../utils/responsive.dart';
import '../views/home_screen.dart';
import '../views/settings.dart';
import '../views/signup.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;
  final bool showHomeIcon;
  final bool isUserLoggedIn;

  CustomAppBar({
    Key? key,
    required this.title,
    this.showHomeIcon = false,
    required this.isUserLoggedIn,
  })  : preferredSize = const Size.fromHeight(60.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final gradientColors = isDarkMode
        ? [Colors.blueGrey.shade800, Colors.black87]
        : [Colors.lightBlue.shade300, Colors.blue.shade400];

    return AppBar(
      title: Text(title,
          style: TextStyle(
            color: Colors.white,
            fontSize: ResponsiveUtil.responsiveFontSize(context),
          )),
      centerTitle: true,
      backgroundColor: Colors.transparent,
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
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(Icons.home, color: Colors.white),
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (Route<dynamic> route) => false,
              ),
            ),
          ),
        if (isUserLoggedIn)
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(Icons.login, color: Colors.white),
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const SignUpScreen()),
                (Route<dynamic> route) => false,
              ),
            ),
          ),
        if (title == 'Flood Alert App' || title == 'Sign Up')
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(Icons.settings, color: Colors.white),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SettingsScreen())),
            ),
          ),
      ],
      elevation: 10.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
    );
  }
}
