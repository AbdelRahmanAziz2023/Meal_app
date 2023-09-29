import 'package:flutter/material.dart';
import 'package:meal_app/Data.dart';
import 'package:meal_app/MealItem.dart';
import 'package:meal_app/MyProvider.dart';
import 'package:provider/provider.dart';

import 'language_provider.dart';

class MealScreen extends StatefulWidget {
  static const routename = 'MealScreen';
  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  late List<Meal>CMeal;
  late String cId;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    List <Meal>EditMealList=Provider.of<MyProvider>(context).EditList;
    final routeArg =
    ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      cId = routeArg['id']!;
     CMeal = EditMealList.where((meal) {
      return meal.categories.contains(cId);
    }).toList();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    var isLandScape=MediaQuery.of(context).orientation==Orientation.landscape;
    var dw =MediaQuery.of(context).size.width;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn?TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text( "${lan.getTexts('cat-$cId')}",style:Theme.of(context).textTheme.headlineMedium,),
        ),
        body: GridView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(CMeal[index]);
          },
          itemCount: CMeal.length, gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent:dw<=400?400:500,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            childAspectRatio:isLandScape?dw /(dw*0.73):dw/(dw*0.7),),
        ),
      ),
    );
  }
}
