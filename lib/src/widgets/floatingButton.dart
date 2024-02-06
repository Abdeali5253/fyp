import 'package:flutter/material.dart';

import '../utils/responsive.dart';
import '../views/emergency_num_screen.dart';

class EmergencyFloatingActionButton extends StatelessWidget {
  const EmergencyFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLargeScreen =
        ResponsiveUtil.isTablet(context) || ResponsiveUtil.isDesktop(context);

    return FloatingActionButton.extended(
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const EmergencyNumScreen()),
      ),
      icon: Icon(Icons.local_hospital, size: isLargeScreen ? 28 : 24),
      // Adjust icon size based on the screen size
      label: isLargeScreen
          ? Text(
              'Emergency Contacts',
              style: TextStyle(
                  fontSize: ResponsiveUtil.responsiveFontSize(context)),
            )
          : const Icon(Icons.arrow_forward),
      // Show text on larger screens
      backgroundColor: Colors.redAccent,
      tooltip: 'Emergency Contacts',
      elevation: isLargeScreen ? 10 : 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(isLargeScreen ? 16 : 12),
      ),
    );
  }
}
