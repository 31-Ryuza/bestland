import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application/service/utils.dart';
import 'package:flutter_application/widget/categories_widget.dart';
import 'package:flutter_application/widget/text_widget.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key? key}) : super(key: key);

List<Color> gridColors = [
    const Color(0xff53B175),
    const Color(0xffF8A44C),
    const Color(0xffF7A593),
    // const Color(0xffD3B0E0),
    // const Color(0xffFDE598),
    // const Color(0xffB7DFF5),
  ];

  List<Map<String, dynamic>> catInfo = [
      {
        'imgPath': 'assets/images/tanah/rumah.png',
        'catText': 'Rumah',
      },
      {
        'imgPath': 'assets/images/tanah/lahan.png',
        'catText': 'Lahan',
      },
      {
        'imgPath': 'assets/images/tanah/sawah.png',
        'catText': 'Sawah',
      },
      // {
      //   'imgPath': 'assets/images/cat/nuts.png',
      //   'catText': 'Nuts',
      // },
      // {
      //   'imgPath': 'assets/images/cat/spices.png',
      //   'catText': 'Spices',
      // },
      // {
      //   'imgPath': 'assets/images/cat/grains.png',
      //   'catText': 'Grains',
      // },
    ];
  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.color;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 1,
          childAspectRatio: 540/270,
          mainAxisSpacing: 10,
          children: List.generate(3, (index) {
            return CategoriesWidget(
              catText: catInfo[index]['catText'],
                imgPath: catInfo[index]['imgPath'],
                passedColor: gridColors[index],
            );
          }
          ),
        )
        
        )
    );
  }
}