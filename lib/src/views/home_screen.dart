import 'package:flutter/material.dart';
import 'package:fyp/src/services/auth_service.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';
import '../utils/responsive.dart';
import '../utils/theme_provider.dart';
import '../widgets/app_bar.dart';
import '../widgets/floatingButton.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService auth = AuthService();
    final user = auth.checkUser();
    final loggedIn = user != null ? true : false;
    String greetingName = user?.displayName ?? user?.email ?? 'Guest';

    final themeProvider = Provider.of<ThemeProvider>(context);
    final int crossAxisCount = ResponsiveUtil.responsiveValue(
      context: context,
      mobile: 2,
      tablet: 3,
    ).round();

    return SafeArea(
      child: Scaffold(
        appBar:
            CustomAppBar(title: 'Flood Alert App', isUserLoggedIn: !loggedIn),
        floatingActionButton: const EmergencyFloatingActionButton(),
        body: Column(
          children: [
            Center(
              child: Padding(
                padding:
                    EdgeInsets.all(ResponsiveUtil.responsivePadding(context)),
                child: Text(
                  'Welcome $greetingName',
                  style: AppConstants.titleStyle(context),
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 1,
                children: List.generate(choices.length, (index) {
                  return Center(
                    child: SelectCard(choice: choices[index]),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Choice {
  const Choice({required this.title, required this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = <Choice>[
  Choice(title: 'Alerts', icon: Icons.warning),
  Choice(title: 'Map', icon: Icons.map),
  Choice(title: "Complain", icon: Icons.comment)
];

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ResponsiveUtil.responsivePadding(context)),
      child: Card(
        color: Colors.white,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Icon(choice.icon,
                      size: ResponsiveUtil.responsiveIconSize(context),
                      color: Colors.blue)),
              Text(choice.title,
                  style: TextStyle(
                      fontSize: ResponsiveUtil.responsiveFontSize(context),
                      color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
