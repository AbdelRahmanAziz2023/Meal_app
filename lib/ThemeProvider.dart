import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  var primaryColor = Colors.brown;
  var accentColor = Colors.deepOrangeAccent[100];
  var tm = ThemeMode.system;
String themetext='s';
  Onchange(newColor, n) async {
    n == 1
        ? primaryColor = SetColor(newColor.hashCode)
        : accentColor = SetColor(newColor.hashCode);
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('primary', primaryColor.value);
    pref.setInt('accent', accentColor!.value);
  }
  getPrefColor()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    primaryColor=SetColor(pref.getInt('primary')??0xFF795548);
    accentColor=SetColor(pref.getInt('accent')??0xFFFF9E80);
    notifyListeners();
  }
  MaterialColor SetColor(colorval) {
    return MaterialColor(
      colorval,
      <int, Color>{
        50: Color(0xFFEFEBE9),
        100: Color(0xFFD7CCC8),
        200: Color(0xFFBCAAA4),
        300: Color(0xFFA1887F),
        400: Color(0xFF8D6E63),
        500: Color(colorval),
        600: Color(0xFF6D4C41),
        700: Color(0xFF5D4037),
        800: Color(0xFF4E342E),
        900: Color(0xFF3E2723),
      },
    );
    notifyListeners();
  }

  void ThemeModeChange(newThemeval) async {
    tm = newThemeval;
    getThemeText(tm);
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('theme', themetext);
  }
  getPref()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    themetext=pref.getString('theme')??'s';
    if(themetext=='d'){tm=ThemeMode.dark;}
    else if(themetext=='l'){tm=ThemeMode.light;}
    else if(themetext=='s'){tm=ThemeMode.system;}
    notifyListeners();
  }
  getThemeText(theme){
    if(tm==ThemeMode.dark){themetext='d';}
    else if(tm==ThemeMode.light){themetext='l';}
    else if(tm==ThemeMode.system){themetext='s';}
  }
}
