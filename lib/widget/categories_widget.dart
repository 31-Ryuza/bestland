import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/screens/categories_screen.dart';
import 'package:flutter_application/widget/text_widget.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget(
      {Key? key,
      required this.catText,
      required this.imgPath,
      required this.passedColor})
      : super(key: key);
  final String catText, imgPath;
  final Color passedColor;

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    final themeState = Provider.of<DarkThemeProvider>(context);
    double _screenWidth = MediaQuery.of(context).size.width;
    final Color color = themeState.getDarkTheme? Colors.white : Colors.black;
    return InkWell(
      onTap: (){
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => DetailCategoriesScreen(type: catText))
        );
      },
    child : Container(
      // height: _screenWidth * 0.1,
      decoration: BoxDecoration(
        color: passedColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: passedColor.withOpacity(0.7),
          width: 2
        )
      ),
      child: Column(children: [
        Container(
          margin: EdgeInsets.only(top: 15 ),
          height: _screenWidth * 0.3,
          width: _screenWidth * 0.3,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imgPath,),
              fit: BoxFit.fill
            )),
        ),
        TextWidget(text: catText, color: color, textSize: 20, isTitle: true,)
      ]),
    )    
    );
  }
}