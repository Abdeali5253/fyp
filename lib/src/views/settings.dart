import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import '../utils/constants.dart';
import '../utils/theme.dart';
import '../utils/theme_provider.dart';
import '../widgets/app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService auth = AuthService();
    final user = auth.checkUser();
    final loggedIn = user != null ? true : false;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
            title: 'Settings', showHomeIcon: true, isUserLoggedIn: loggedIn),
        body: ListView(
          children: <Widget>[
            // Dark Mode toggle with thematic styling
            SwitchListTile(
              title: Text('Dark Mode',
                  style: AppConstants.titleTextStyle(context)),
              subtitle: Text(
                'Toggle between light and dark theme',
                style: AppConstants.subtitleTextStyle(context),
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

            const Divider(),

            ListTile(
              leading: Icon(Icons.location_on,
                  color: Theme.of(context).iconTheme.color),
              title: Text('Manage Location Permission',
                  style: AppConstants.titleTextStyle(context)),
              subtitle: Text(
                'Open app settings to manage location permission',
                style: AppConstants.subtitleTextStyle(context),
              ),
              onTap: () => _handlePermissions(context),
            ),
            ListTile(
              leading:
                  Icon(Icons.phone, color: Theme.of(context).iconTheme.color),
              title: Text('Manage Phone Call Permission',
                  style: AppConstants.titleTextStyle(context)),
              subtitle: Text(
                'Open app settings to manage phone call permission',
                style: AppConstants.subtitleTextStyle(context),
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
