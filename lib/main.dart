import 'package:flutter/material.dart';
import 'package:meal_app/FaviroutsScreen.dart';
import 'package:meal_app/MealDetails.dart';
import 'package:meal_app/MealScreen.dart';
import 'package:meal_app/MyFilters.dart';
import 'package:meal_app/MyProvider.dart';
import 'package:meal_app/MySettings.dart';
import 'package:meal_app/ThemeProvider.dart';
import 'package:meal_app/language_provider.dart';
import 'package:meal_app/on_boarding_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CategoryScreen.dart';
import 'MyDrawer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Widget homescreen =
      prefs.getBool('watched') ?? false ? MyHomePage() : OnBoardingScreen();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (ctx) => MyProvider()),
      ChangeNotifierProvider(create: (ctx) => ThemeProvider()),
      ChangeNotifierProvider(create: (ctx) => LanguageProvider()),
    ],
    child: MyApp(homescreen),
  ));
}

class MyApp extends StatelessWidget {
  final Widget homescreen;

  MyApp(this.homescreen);

  @override
  Widget build(BuildContext context) {
    var primarycolor = Provider.of<ThemeProvider>(context).primaryColor;
    var accentcolor = Provider.of<ThemeProvider>(context).accentColor;
    var tm = Provider.of<ThemeProvider>(context).tm;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Meal App',
        themeMode: tm,
        theme: ThemeData(
            //primarySwatch: primarycolor,
            primaryColor: primarycolor,
            secondaryHeaderColor: accentcolor,
            textTheme: ThemeData.light().textTheme.copyWith(
                headlineMedium: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                ),
                titleSmall: const TextStyle(
                  fontSize: 15,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                ),
                titleLarge: const TextStyle(
                  fontSize: 30,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                ),
                titleMedium: const TextStyle(
                    fontSize: 22,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold)),
            canvasColor: Colors.deepOrangeAccent[100],
            appBarTheme: AppBarTheme(
              centerTitle: true,
              backgroundColor: primarycolor,
            )),
        darkTheme: ThemeData(
            unselectedWidgetColor: Colors.white70,
            primarySwatch: primarycolor,
            primaryColor: primarycolor,
            secondaryHeaderColor: accentcolor,
            textTheme: ThemeData.dark().textTheme.copyWith(
                headlineMedium: const TextStyle(
                  fontSize: 20,
                  color: Colors.white70,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                ),
                titleSmall: const TextStyle(
                    fontSize: 15,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold,
                    color: Colors.white70),
                titleLarge: const TextStyle(
                  fontSize: 30,
                  color: Colors.white70,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                ),
                titleMedium: const TextStyle(
                    fontSize: 22,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold,
                    color: Colors.white70)),
            canvasColor: Colors.black12,
            drawerTheme:
                DrawerThemeData(elevation: 0, backgroundColor: Colors.black),
            iconTheme: IconThemeData(
              color: Colors.white70,
            ),
            appBarTheme: AppBarTheme(centerTitle: true)),
        //home: MyHomePage()
        routes: {
          '/': (context) => homescreen,
          MyHomePage.routeName: (context) => MyHomePage(),
          MealScreen.routename: (context) => MealScreen(),
          MealDetails.routeName: (context) => MealDetails(),
          MyFilters.routeName: (context) => MyFilters(),
          MySettings.routeName: (context) => MySettings(),
        });
  }
}

class MyHomePage extends StatefulWidget {
  static const routeName = 'MyHome';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List pages;

  var pageindex = 0;

  SelectedPage(int value) {
    setState(() {
      pageindex = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MyProvider>(context, listen: false).getData();
    Provider.of<ThemeProvider>(context, listen: false).getPref();
    Provider.of<ThemeProvider>(context, listen: false).getPrefColor();
    Provider.of<LanguageProvider>(context, listen: false).getLan();

    pages = [
      {
        'page': CategoryScreen(),
        'title':
            "${Provider.of<LanguageProvider>(context, listen: false).getTexts("categories")}"
      },
      {
        'page': FaviroutsScreen(),
        'title':
            "${Provider.of<LanguageProvider>(context, listen: false).getTexts("your_favorites")}"
      },
    ];
  }

  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(pages[pageindex] == pages[0]
              ? "${lan.getTexts('categories')}"
              : "${lan.getTexts('your_favorites')}"),
        ),
        drawer: MyDrawer(),
        body: pages[pageindex]['page'],
        bottomNavigationBar: BottomNavigationBar(
          onTap: SelectedPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor:
              ThemeMode == ThemeMode.light ? Colors.black : Colors.white70,
          selectedItemColor: Theme.of(context).secondaryHeaderColor,
          currentIndex: pageindex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: "${lan.getTexts('categories')}"),
            BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: "${lan.getTexts('your_favorites')}"),
          ],
        ),
      ),
    );
  }
}
