import 'package:flutter/material.dart';
import 'package:meal_app/Data.dart';
import 'package:meal_app/MyProvider.dart';
import 'package:provider/provider.dart';
import 'MealItem.dart';
import 'language_provider.dart';

class FaviroutsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    List<Meal> fMeal=Provider.of<MyProvider>(context).FavouriteMeal;
    var isLandScape=MediaQuery.of(context).orientation==Orientation.landscape;
    var dw =MediaQuery.of(context).size.width;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    if (fMeal.isEmpty) {
      return Directionality(
        textDirection: lan.isEn?TextDirection.ltr:TextDirection.rtl,
        child:Scaffold(
          body: Center(
            child: Text("${lan.getTexts('favorites_text')}"),
          ),
        ),
      );
    } else {
      return Directionality(
        textDirection: lan.isEn?TextDirection.ltr:TextDirection.rtl,
        child: Scaffold(
          body: GridView.builder(
            itemBuilder: (ctx, index) {
              return MealItem(fMeal[index]);
            },
            itemCount: fMeal.length, gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent:dw<=400?400:500,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            childAspectRatio:isLandScape?dw /(dw*0.73):dw/(dw*0.7),),
          ),
        ),
      );
    }
  }
}
