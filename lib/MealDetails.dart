import 'package:flutter/material.dart';
import 'package:meal_app/Data.dart';
import 'package:meal_app/MyProvider.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:provider/provider.dart';

import 'language_provider.dart';

class MealDetails extends StatelessWidget {
  static const routeName = 'MealDetails';

  Widget BoxName(BuildContext context, String text) {
    return Container(
      alignment: Alignment.center,
      height: 80,
      width: 300,
      child: Text(
        text,
        style: Theme
            .of(context)
            .textTheme
            .titleMedium,
      ),
    );
  }

  Widget BoxView(Widget child) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 180,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white70,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute
        .of(context)
        ?.settings
        .arguments as String;
    final MealD = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    var isLandScape =
        MediaQuery
            .of(context)
            .orientation == Orientation.landscape;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    List liIngredientLi = lan.getTexts('ingredients-$mealId') as List<String>;
    List liStepsLi = lan.getTexts('steps-$mealId') as List<String>;
    var liIngredients = ListView.builder(
      itemBuilder: (ctx, index) =>
          Card(
            color: Theme
                .of(ctx)
                .primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                liIngredientLi[index],
                style: Theme
                    .of(context)
                    .textTheme
                    .titleSmall,
                textAlign: TextAlign.center,
              ),
            ),
          ),
      itemCount: liIngredientLi.length,
    );
    var liSteps = ListView.builder(
      itemBuilder: (ctx, index) =>
          Column(children: [
            ListTile(
              leading: Text(
                '#${index + 1}',
                style: Theme
                    .of(context)
                    .textTheme
                    .titleSmall,
              ),
              title: Text(
                liStepsLi[index],
                style: Theme
                    .of(context)
                    .textTheme
                    .titleSmall,
              ),
            ),
            const Divider(
              thickness: 3,
              color: Colors.grey,
              indent: 5.0,
              endIndent: 5.0,
            ),
          ]),
      itemCount: liStepsLi.length,
    );
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(title: Text(
                "${lan.getTexts('meal-$mealId')}",
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineMedium,
              ),
                  background: Hero(
                      tag: mealId,
                      child: InteractiveViewer(
                        child: FadeInImage(
                          placeholder: AssetImage('images/a2.png'),
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            MealD.imageUrl,
                          ),
                        ),
                      ),
                    ),
                  ),
              ),
            SliverList(delegate: SliverChildListDelegate([

              if (isLandScape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        BoxName(context, "${lan.getTexts('Ingredients')}"),
                        BoxView(liIngredients),
                      ],
                    ),
                    Column(
                      children: [
                        BoxName(context, "${lan.getTexts('Steps')}"),
                        BoxView(liSteps),
                      ],
                    ),
                  ],
                ),
              if (!isLandScape) BoxName(
                  context, "${lan.getTexts('Ingredients')}"),
              if (!isLandScape) BoxView(liIngredients),
              if (!isLandScape) BoxName(context, "${lan.getTexts('Steps')}"),
              if (!isLandScape) BoxView(liSteps),
              const SizedBox(
                height: 60,
              ),
            ]))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor:Theme.of(context).primaryColor,
          onPressed: () =>
              Provider.of<MyProvider>(context, listen: false)
                  .FavouriteMeal1(mealId),
          child: Icon(
            Provider.of<MyProvider>(context).isFavourite(mealId)
                ? Icons.star
                : Icons.star_border,
            color: ThemeMode == ThemeMode.light ? Colors.black : Colors.white70,
          ),
        ),
      ),
    );
  }
}
