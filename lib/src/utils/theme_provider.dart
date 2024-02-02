import 'package:flutter/material.dart';
import 'theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData;

  ThemeProvider(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  toggleTheme() {
    if (_themeData == AppTheme.lightTheme) {
      setTheme(AppTheme.darkTheme);
    } else {
      setTheme(AppTheme.lightTheme);
    }
  }
}
