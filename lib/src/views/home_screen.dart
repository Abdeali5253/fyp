import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../utils/responsive.dart';
import 'package:provider/provider.dart';
import '../utils/theme_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final int crossAxisCount = ResponsiveUtil.responsiveValue(
      context: context,
      mobile: 2,
      tablet: 4,
    ).round();

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: 'Flood Alert App',),
        body: GridView.count(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 1,
          children: List.generate(choices.length, (index) {
            return Center(
              child: SelectCard(choice: choices[index]),
            );
          }),
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
];

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
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
      ),
    );
  }
}
