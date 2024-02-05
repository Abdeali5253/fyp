import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'src/utils/theme.dart';
import 'src/utils/constants.dart';
import 'src/views/home_screen.dart';
import 'src/utils/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> initState() async {
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    await Permission.location.request();
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      //Permission.callPhone,
    ].request();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(AppTheme.lightTheme),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppConstants.appName,
            theme: themeProvider.getTheme(),
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
