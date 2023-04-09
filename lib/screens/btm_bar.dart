import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application/screens/menu.dart';

import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/screens/cart.dart';
import 'package:flutter_application/screens/categories.dart';
import 'package:flutter_application/screens/home_screen.dart';
import 'package:flutter_application/screens/user.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {

//   App Bar
// App Bar Leading Action
// TabBar Top Bottom

  int _selectedIndex = 1;
  final List<Map<String, dynamic>> _pages = [
    {'page': const HomeScreen(), 'title': "Home Screen"},
    {'page': CategoriesScreen(), 'title': "Categories Screen"},
    {'page': const CartScreen(), 'title': "Cart Screen"},
    {'page': const UserScreen(), 'title': "User Screen"},
    {'page': const MenuScreen(), 'title': "Menu Screen"}
  ];

  void _selectedPage(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool _isDark = themeState.getDarkTheme;
    return DefaultTabController(    
    length: 2,
    child: Scaffold(
      // appBar: AppBar(
      //   backgroundColor: _isDark? Color.fromARGB(255, 0, 0, 0) : Color.fromARGB(255, 255, 255, 255),
      //   title: Text(_pages[_selectedIndex]['title'], style: TextStyle(color: _isDark? Color.fromARGB(255, 255, 255, 255) : Color.fromARGB(255, 0, 0, 0)),),
      //   // bottom: TabBar(
      //   //   unselectedLabelColor: _isDark? Colors.white : Color.fromARGB(255, 0, 0, 0),
      //   //   labelColor: _isDark? Colors.white : Color.fromARGB(255, 0, 0, 0),
      //   //   tabs: [Tab(text: "Grafik"),
      //   //   Tab(text: "Chat")]
      //   // ),
      //   leading: IconButton(icon: const Icon(Icons.menu),
      //   color: _isDark? Color.fromARGB(255, 255, 255, 255) : Color.fromARGB(255, 0, 0, 0), 
      //   onPressed: () { setState(() {
      //     _selectedIndex = 4;
      //   });
      //   },
      //   ),
      //   actions: [
      //     IconButton(
      //     onPressed: () {}, 
      //     icon: const Icon(Icons.search), 
      //     color: _isDark? Color.fromARGB(255, 255, 255, 255) : Color.fromARGB(255, 0, 0, 0),),
      //     IconButton(
      //     onPressed: () {}, 
      //     icon: const Icon(Icons.notifications_active,),
      //     color: _isDark? Color.fromARGB(255, 255, 255, 255) : Color.fromARGB(255, 0, 0, 0),),
      //   ],

      // ),
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: _isDark? Theme.of(context).cardColor : Colors.white,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: _isDark? Colors.white : Color.fromARGB(255, 0, 0, 0),
        selectedItemColor: _isDark? Colors.white : Color.fromARGB(255, 0, 0, 0),
        onTap: _selectedPage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
            label: "Home"
          ),
           BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 1 ? IconlyBold.category : IconlyLight.category),
            label: "Categories"
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 2 ? IconlyBold.heart : IconlyLight.heart),
            label: "Like"
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 3 ? IconlyBold.user2 : IconlyLight.user2),
            label: "User"
          )
        ]
        ),
    )
    );
}
}