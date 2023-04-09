import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    
    return Scaffold(
      body: Center(
        child: SwitchListTile(
        title: Text('Theme'),
        secondary: Icon(themeState.getDarkTheme ? Icons.dark_mode_outlined : Icons.light_mode_outlined),
        onChanged: (bool value){
          setState(() {
            themeState.setDarkTheme = value;
          });
        }, 
        value: themeState.getDarkTheme,
        )),
    );
    
  }
}