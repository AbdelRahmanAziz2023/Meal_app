import 'package:flutter/material.dart';
import 'package:meal_app/CategoryItem.dart';
import 'package:meal_app/MyProvider.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:provider/provider.dart';

import 'language_provider.dart';

class CategoryScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn?TextDirection.ltr:TextDirection.rtl,
      child: GridView(
        padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 220,
              mainAxisSpacing: 25,
              crossAxisSpacing: 15,
              childAspectRatio: 3 / 2),
          children: Provider.of<MyProvider>(context).EditCategory.map((item) => CategoryItem(item)).toList()),
    );
  }
}
