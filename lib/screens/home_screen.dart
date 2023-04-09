import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application/inner_screen/on_sale_screen.dart';
import 'package:flutter_application/service/global_metods.dart';
import 'package:flutter_application/service/utils.dart';
import 'package:flutter_application/widget/on_sale_home.dart';
import 'package:flutter_application/widget/on_sale_widget.dart';
import 'package:flutter_application/widget/text_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<String> _offerImages = [
    'assets/images/offres/lh.png',
    'assets/images/offres/rm.png',
    'assets/images/tanah/tanah2.png'
  ];

  final fDatabase = FirebaseDatabase.instance.ref().child('tanah');

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final themeState = Utils(context).getTheme;
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
    GlobalMethods globalMethods = GlobalMethods();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.30,
              child: Swiper(
              itemBuilder: (BuildContext context,int index){
                return Image.asset(_offerImages[index],fit: BoxFit.fill,);
              },
              autoplay: true,
              itemCount: _offerImages.length,
              pagination: const SwiperPagination(
                alignment: Alignment.bottomCenter,
                builder: DotSwiperPaginationBuilder(
                  color: Colors.white, activeColor: Colors.red
                )
              ),
              // control: SwiperControl(),
            ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                TextWidget(
                  text: 'Recommendations', 
                  color: color, 
                  textSize: 20, 
                  isTitle: true,),
                // Spacer(),
                TextButton(onPressed: (){
                  GlobalMethods.navigateTo(ctx: context, routeName: OnSaleScreen.routeName);
                }, 
                child: TextWidget(
                  text: 'Browse All',
                  maxLines: 1,
                  color: Colors.blue,
                  textSize: 15,
                ))
              ],),
            ),
            // GridView.count(
            //   shrinkWrap: true,
            //   physics: const NeverScrollableScrollPhysics(),
            //   crossAxisCount: 1,
            //   childAspectRatio: size.width / (size.height * 0.32),
            //   mainAxisSpacing: 10,
            //   children: List.generate(6, (index) {
            //     return OnSaleWidget();
            //   }
            //   ),
            // )
            
            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: FirebaseAnimatedList(
              defaultChild: Center(child: CircularProgressIndicator()),
              physics: const NeverScrollableScrollPhysics(),
              query: fDatabase, 
              itemBuilder: ((context, snapshot, animation, index) {

                Map tanah = snapshot.value as Map;
                tanah['key'] = snapshot.key;

                var name = tanah['nama'];
                var price = tanah['harga'];
                // var alamat = tanah['alamat'];
                var alamat = tanah['lokasi'];
                var image = tanah['images'];

                return OnSaleHome(
                  nama: name, 
                  harga: price, 
                  images: image, 
                  alamat: alamat,
                  keys: tanah['key'],
                  );
              })
              )
            )

            // SizedBox(
            //   height: 480,
              
            //   child: ListView.builder(
            //     itemCount: 10,
            //     scrollDirection: Axis.vertical,
            //     itemBuilder: (ctx, index){
            //       return OnSaleWidget();
            //     }),
            // )
          ],
        ),
      )
    );
  }
}