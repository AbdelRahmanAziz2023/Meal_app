import 'package:flutter/material.dart';
import 'package:meal_app/MyDrawer.dart';
import 'package:meal_app/MyProvider.dart';
import 'package:provider/provider.dart';

import 'language_provider.dart';

class MyFilters extends StatefulWidget {
  static const routeName = 'MyFilters';
  final bool fromOnboarding;
  MyFilters({this.fromOnboarding=false});
  @override
  State<MyFilters> createState() => _MyFiltersState();
}

class _MyFiltersState extends State<MyFilters> {
  get fromOnboarding => true;


  Widget Filter(bool filter, String title, String Stitle, Function(bool) effect) {
    return SwitchListTile(
      value: filter,
      onChanged:effect,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subtitle: Text(Stitle,),
      inactiveTrackColor:ThemeMode==ThemeMode.light?Colors.grey:Colors.white70,
    );
  }

  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    final Map<String,bool>CurrentF=Provider.of<MyProvider>(context,listen: true).SaveFilters;
    return Directionality(
      textDirection: lan.isEn?TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
          appBar:fromOnboarding?AppBar(elevation:0,backgroundColor:Theme.of(context).canvasColor,):AppBar(
            title: Text(
              "${lan.getTexts("filters_appBar_title")}",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          drawer: fromOnboarding?null: MyDrawer(),
          body: Column(
            children: [
              Container(
                width: double.infinity,
                height: 100,
                alignment: Alignment.center,
                child: Text(
                  "${lan.getTexts("filters_screen_title")}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Expanded(
                  child: ListView(
                children: [
                  Filter(CurrentF['GlutenFree']!,"${lan.getTexts("Gluten-free")}",
                      "${lan.getTexts("Gluten-free-sub")}", (value) {
                    setState(() {
                      CurrentF['GlutenFree'] = value;
                    });
                    Provider.of<MyProvider>(context,listen: false).SetFilters();
                  }),
                  Filter(CurrentF['Vegan']!, "${lan.getTexts("Vegan")}", "${lan.getTexts("Vegan-sub")}", (value) {
                    setState(() {
                      CurrentF['Vegan'] = value;
                    });
                    Provider.of<MyProvider>(context,listen: false).SetFilters();
                  }),
                  Filter(
                      CurrentF['Vegetarian']!,"${lan.getTexts("Vegetarian")}","${lan.getTexts("Vegetarian-sub")}",
                      (value) {
                    setState(() {
                      CurrentF['Vegetarian'] = value;
                    });
                    Provider.of<MyProvider>(context,listen: false).SetFilters();
                  }),
                  Filter(CurrentF['LactoseFree']!,"${lan.getTexts("Lactose-free")}",
                      "${lan.getTexts("Lactose-free_sub")}", (value) {
                    setState(() {
                      CurrentF['LactoseFree'] = value;
                    });
                    Provider.of<MyProvider>(context,listen: false).SetFilters();
                  }),
                ],
              )),
              SizedBox(height:fromOnboarding?80:0,)
            ],
          )),
    );
  }
}
