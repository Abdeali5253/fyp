import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../views/emergency_num_screen.dart'; // Ensure the path matches your project structure

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final Function toggleTheme;

  const CustomAppBar({Key? key, required this.toggleTheme})
      : preferredSize = const Size.fromHeight(60.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(AppConstants.appName),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.contact_phone),
          onPressed: () {
            // Navigate to EmergencyNumScreen
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => EmergencyNumScreen()));
          },
        ),
        IconButton(
          icon: const Icon(Icons.wb_sunny),
          onPressed: () => toggleTheme(),
        ),
      ],
    );
  }
}
