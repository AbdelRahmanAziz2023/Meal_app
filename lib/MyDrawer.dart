import 'package:flutter/material.dart';
import 'package:meal_app/CategoryScreen.dart';
import 'package:meal_app/MyFilters.dart';
import 'package:meal_app/MySettings.dart';
import 'package:meal_app/main.dart';
import 'package:provider/provider.dart';

import 'language_provider.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  Widget Option(String text, IconData icon,Function() effect) {
    return ListTile(

      iconColor:ThemeMode==ThemeMode.light?Colors.black:Colors.white70,
      title: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      leading: Icon(icon),
      onTap:effect,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn?TextDirection.ltr:TextDirection.rtl,
      child: Drawer(
        child: Column(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              width: double.infinity,
              height: 200,
              alignment: Alignment.center,
              child: Text(
                "${lan.getTexts("drawer_name")}",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Option( "${lan.getTexts("drawer_item1")}", Icons.restaurant, () {
              Navigator.of(context).pushReplacementNamed(MyHomePage.routeName);
            }),
            Option( "${lan.getTexts("drawer_item2")}", Icons.filter_list,() {
              Navigator.of(context).pushReplacementNamed(MyFilters.routeName);
            }),
            Option( "${lan.getTexts("drawer_item3")}", Icons.settings,() {
              Navigator.of(context).pushReplacementNamed(MySettings.routeName);
            }),
          ],
        ),
      ),
    );
  }
}
