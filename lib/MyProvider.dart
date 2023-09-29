import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Data.dart';
import 'dummy_data.dart';

class MyProvider with ChangeNotifier {
  Map<String, bool> SaveFilters = {
    'GlutenFree': false,
    'Vegan': false,
    'Vegetarian': false,
    'LactoseFree': false,
  };

  List<Meal> EditList = DUMMY_MEALS;
  List<Meal> FavouriteMeal = [];
  List<String> PrefMealId = [];
  List<Category> EditCategory = [];

  void SetFilters() async {
    EditList = DUMMY_MEALS.where((meal) {
      if (SaveFilters['GlutenFree']! && !meal.isGlutenFree) {
        return false;
      }
      if (SaveFilters['Vegan']! && !meal.isVegan) {
        return false;
      }
      if (SaveFilters['Vegetarian']! && !meal.isVegetarian) {
        return false;
      }
      if (SaveFilters['LactoseFree']! && !meal.isLactoseFree) {
        return false;
      }
      return true;
    }).toList();

    List<Category> ac = [];
    EditList.forEach((meal) {
      meal.categories.forEach((catId) {
        DUMMY_CATEGORIES.forEach((cat) {
          if (cat.id == catId) {
            if (!ac.any((cat) => cat.id == catId)) ac.add(cat);
          }
        });
      });
    });
    EditCategory = ac;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('GlutenFree', SaveFilters['GlutenFree']!);
    pref.setBool('Vegan', SaveFilters['Vegan']!);
    pref.setBool('Vegetarian', SaveFilters['Vegetarian']!);
    pref.setBool('LactoseFree', SaveFilters['LactoseFree']!);
    notifyListeners();
  }

  void getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    SaveFilters['GlutenFree'] = pref.getBool('GlutenFree')??false;
    SaveFilters['Vegan'] = pref.getBool('Vegan')??false;
    SaveFilters['Vegetarian'] = pref.getBool('Vegetarian')??false;
    SaveFilters['LactoseFree'] = pref.getBool('LactoseFree')??false;
    PrefMealId = pref.getStringList('PrefMealId')??[];
    SetFilters();
    for (var Mid in PrefMealId!) {
      final Mealindex = FavouriteMeal.indexWhere((meal) => Mid == meal.id);
      if (Mealindex < 0) {
        FavouriteMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id == Mid));
      }
    }
    notifyListeners();
  }

  void FavouriteMeal1(String Mid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final Mealindex = FavouriteMeal.indexWhere((meal) => Mid == meal.id);
    if (Mealindex >= 0) {
      FavouriteMeal.removeAt(Mealindex);
      PrefMealId.removeAt(Mealindex);
    }
    if (Mealindex < 0) {
      FavouriteMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id == Mid));
      PrefMealId.add(Mid);
    }
    pref.setStringList('PrefMealId', PrefMealId);
    notifyListeners();
  }

  bool isFavourite(String id) {
    return FavouriteMeal.any(((meal) => meal.id == id));
    notifyListeners();
  }
}
