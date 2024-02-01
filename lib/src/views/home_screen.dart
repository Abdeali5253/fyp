import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../utils/constants.dart';
import '../utils/responsive.dart';

class HomeScreen extends StatelessWidget {
  final Function toggleTheme;

  const HomeScreen({Key? key, required this.toggleTheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int crossAxisCount = ResponsiveUtil.responsiveValue(
      context: context,
      mobile: 2,
      tablet: 4,
    ).round();

    return Scaffold(
      appBar: CustomAppBar(toggleTheme: toggleTheme),
      body: GridView.count(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 1,
        children: List.generate(choices.length, (index) {
          return Center(
            child: SelectCard(choice: choices[index]),
          );
        }),
      ),
    );
  }
}


class Choice {
  const Choice({required this.title, required this.icon});
  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Alerts', icon: Icons.warning),
  const Choice(title: 'Map', icon: Icons.map),
  const Choice(title: 'Safety', icon: Icons.security),
  const Choice(title: 'Settings', icon: Icons.settings),
];

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(child: Icon(choice.icon, size: 50.0, color: Colors.blue)),
            Text(choice.title, style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}