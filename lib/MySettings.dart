import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:meal_app/MyDrawer.dart';
import 'package:meal_app/ThemeProvider.dart';
import 'package:provider/provider.dart';

import 'language_provider.dart';

class MySettings extends StatelessWidget {
  static const routeName = 'MySettings';
final bool fromOnboarding;
MySettings({this.fromOnboarding=false});
  Widget Choose(
      BuildContext ctx, String title, IconData icon, ThemeMode themeval) {
    return RadioListTile(
      activeColor:Theme.of(ctx).secondaryHeaderColor,
      secondary: Icon(
        icon,
        color: Theme.of(ctx).secondaryHeaderColor,
      ),
      value: themeval,
      groupValue: Provider.of<ThemeProvider>(ctx).tm,
      onChanged: (newThemeval) => Provider.of<ThemeProvider>(ctx, listen: false)
          .ThemeModeChange(newThemeval),
      title: Text(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    ListTile ChooseColor(BuildContext ctx, txt) {
      var primarycolor = Provider.of<ThemeProvider>(ctx).primaryColor;
      var accentcolor = Provider.of<ThemeProvider>(ctx).accentColor;

      return ListTile(
        title: Text("${lan.getTexts(txt)}"),
        trailing: CircleAvatar(
          backgroundColor: txt == 'primary' ? primarycolor : accentcolor,
        ),
        onTap: () {
          showDialog(
              context: ctx,
              builder: (BuildContext context) {
                return AlertDialog(
                  elevation: 4,
                  titlePadding: EdgeInsets.all(0),
                  contentPadding: EdgeInsets.all(0),
                  content: SingleChildScrollView(
                    child: ColorPicker(
                      pickerColor: txt == "primary"
                          ? Provider.of<ThemeProvider>(context).primaryColor
                          : Provider.of<ThemeProvider>(context).accentColor!,
                      onColorChanged: (newColor) =>
                          Provider.of<ThemeProvider>(ctx, listen: false)
                              .Onchange(newColor, txt == "primary" ? 1 : 2),
                      colorPickerWidth: 300,
                      enableAlpha: false,
                      displayThumbColor: true,
                      showLabel: false,
                    ),
                  ),
                );
              });
        },
      );
    }


    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
          appBar:fromOnboarding?AppBar(elevation:0,backgroundColor:Theme.of(context).canvasColor,): AppBar(
            title: Text(
              "${lan.getTexts("drawer_item3")}",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          drawer:fromOnboarding?null: MyDrawer(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 100,
                  alignment: Alignment.center,
                  child: Text(
                    "${lan.getTexts("theme_screen_title")}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Choose(context, "${lan.getTexts("System_default_theme")}",
                    Icons.system_update, ThemeMode.system),
                Choose(context, "${lan.getTexts("light_theme")}",
                    Icons.wb_sunny_outlined, ThemeMode.light),
                Choose(context, "${lan.getTexts("dark_theme")}",
                    Icons.nights_stay_outlined, ThemeMode.dark),
                ChooseColor(context, 'primary'),
                ChooseColor(context, 'accent'),
                Divider(
                  height: 10,
                  color: Colors.black54,
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "${lan.getTexts("drawer_switch_title")}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child:   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${lan.getTexts('drawer_switch_item2')}",
                          style: Theme.of(context).textTheme.titleMedium),
                      Switch(
                        value: lan.isEn,
                        onChanged: (newValue) {
                          Provider.of<LanguageProvider>(context,
                              listen: false)
                              .changeLan(newValue);
                        },
                      ),
                      Text("${lan.getTexts('drawer_switch_item1')}",
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ),
                Divider(
                  height: 10,
                  color: Colors.black54,
                ),
                SizedBox(height:fromOnboarding?80:0,)
              ],
            ),
          )),
    );
  }
}
