import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/const/theme_data.dart';
import 'package:flutter_application/inner_screen/on_sale_screen.dart';
import 'package:flutter_application/provider/auth.dart';
import 'package:flutter_application/provider/dark_theme_provider.dart';
import 'package:flutter_application/screens/btm_bar.dart';
import 'package:flutter_application/screens/cart.dart';
import 'package:flutter_application/screens/detail.dart';
import 'package:flutter_application/screens/home_screen.dart';
import 'package:flutter_application/splashcreen.dart';
import 'package:flutter_application/service/dark_theme_prefs.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/provider/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme = 
    await themeChangeProvider.darkThemePrefs.getTheme();
  }
  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(
        //   create: (ctx) => AuthCus()
        // ),
        ChangeNotifierProvider(create: (_){
          return themeChangeProvider;
        })
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, child) {
          
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            debugShowMaterialGrid: false,
            title: 'Flutter Demo',
            theme: Styles.themeData(themeProvider.getDarkTheme, context),
            home: SplashScreen(),
            routes: {
              OnSaleScreen.routeName : (ctx) => const OnSaleScreen(),
              CartScreen.routeName : (ctx) => const CartScreen(),
              // DetailScreen.routeName : (ctx) => const DetailScreen(),
            },
          );
        }
      ),
    );
  }
}