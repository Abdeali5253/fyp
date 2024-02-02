import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp/src/utils/theme.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../utils/theme_provider.dart';
import '../widgets/app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Improved visual styling
    TextStyle titleStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.primary,
    );

    TextStyle subtitleStyle = TextStyle(
      fontSize: 16,
      color: Theme.of(context).colorScheme.secondary,
    );

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: 'Settings', showHomeIcon: true),
        body: ListView(
          children: <Widget>[
            // Dark Mode toggle with thematic styling
            SwitchListTile(
              title: Text('Dark Mode', style: titleStyle),
              subtitle: Text(
                'Toggle between light and dark theme',
                style: subtitleStyle,
              ),
              value: themeProvider.getTheme() == AppTheme.darkTheme,
              onChanged: (bool value) {
                themeProvider.toggleTheme();
              },
              secondary: Icon(
                Icons.brightness_6,
                color: Theme.of(context).iconTheme.color,
              ),
            ),

            // Separators for better visual grouping
            Divider(),

            // Permission management with custom styling
            ListTile(
              leading: Icon(Icons.location_on, color: Theme.of(context).iconTheme.color),
              title: Text('Manage Location Permission', style: titleStyle),
              subtitle: Text(
                'Open app settings to manage location permission',
                style: subtitleStyle,
              ),
              onTap: () => _handlePermissions(context),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Theme.of(context).iconTheme.color),
              title: Text('Manage Phone Call Permission', style: titleStyle),
              subtitle: Text(
                'Open app settings to manage phone call permission',
                style: subtitleStyle,
              ),
              onTap: () => _handlePermissions(context),
            ),
          ],
        ),
      ),
    );
  }

  void _handlePermissions(BuildContext context) {
    if (!kIsWeb) {
      openAppSettings();
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Not Available'),
          content: Text('This feature is not available on web.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
