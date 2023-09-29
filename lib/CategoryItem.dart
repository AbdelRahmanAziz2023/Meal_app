import 'package:flutter/material.dart';
import 'package:meal_app/MealScreen.dart';
import 'package:provider/provider.dart';
import 'Data.dart';
import 'language_provider.dart';

class CategoryItem extends StatelessWidget {
  final Category item;
  CategoryItem(this.item);

  void category(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(MealScreen.routename,
        arguments: {'id': item.id,});
  }
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return InkWell(
      onTap: ()=> category(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [item.color.withOpacity(0.2), item.color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          color: item.color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
         "${lan.getTexts("cat-${item.id}")}",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
