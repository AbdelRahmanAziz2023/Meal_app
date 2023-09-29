import 'package:flutter/material.dart';
import 'package:meal_app/Data.dart';
import 'package:meal_app/MealDetails.dart';
import 'package:provider/provider.dart';

import 'language_provider.dart';

class MealItem extends StatelessWidget {
  Meal meal;
  MealItem(this.meal);

  void Smeal(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(MealDetails.routeName, arguments: meal.id);
  }

  String get complexityText {
    switch (meal.complexity) {
      case Complexity.Simple:
        return 'Simple';
        break;
      case Complexity.Challenging:
        return 'Challenging';
        break;
      case Complexity.Hard:
        return 'Hard';
        break;
      default:
        return 'Unknown';
    }
  }

  String get affordabilityText {
    switch (meal.affordability) {
      case Affordability.Affordable:
        return 'Affordable';
        break;
      case Affordability.Luxurious:
        return 'Luxurious';
        break;
      case Affordability.Pricey:
        return 'Pricey';
        break;
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return InkWell(
      onTap: ()=>Smeal(context),
      borderRadius: BorderRadius.circular(20),
      child: Card(
        color:ThemeMode==ThemeMode.light?Colors.white70:Colors.white70,
        elevation: 20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: Hero(
                    tag: meal.id,
                    child: InteractiveViewer(
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200,
                        placeholder: AssetImage('images/a2.png'),
                        image:NetworkImage(
                          meal.imageUrl,

                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 0,
                  child: Container(
                    width: 220,
                    color: Colors.black54,
                    child: Text(
                      "${lan.getTexts('meal-${meal.id}')}",
                      style: Theme.of(context).textTheme.titleLarge,
                      overflow: TextOverflow.fade,
                      softWrap: true,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.timer),
                      const SizedBox(
                        width: 4,
                      ),
                      Text('${meal.duration} ${lan.getTexts('min')}'),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.work),
                      const SizedBox(
                        width: 4,
                      ),
                      Text("${lan.getTexts('${meal.complexity}')}"),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.money),
                      const SizedBox(
                        width: 4,
                      ),
                      Text("${lan.getTexts('${meal.affordability}')}"),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
