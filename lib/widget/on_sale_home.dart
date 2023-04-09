import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/inner_screen/on_sale_screen.dart';
import 'package:flutter_application/screens/detail.dart';
import 'package:flutter_application/widget/price_widget.dart';
import 'package:flutter_application/widget/text_widget.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_application/service/global_metods.dart';

import '../service/utils.dart';

class OnSaleHome extends StatefulWidget {

  final nama;
  final harga;
  final images;
  final alamat;
  final keys;

  const OnSaleHome({super.key, required this.nama, required this.harga, required this.images,  required this.alamat, required this.keys});

  @override
  State<OnSaleHome> createState() => _OnSaleHomeState(nama, harga, images, alamat, keys);
}

class _OnSaleHomeState extends State<OnSaleHome> {



  final nama;
  final harga;
  final images;
  final alamat;
  final keys;
  _OnSaleHomeState(this.nama, this.harga, this.alamat, this.images, this.keys);

  Future<void> saveLike() async {
    var userId = await FirebaseAuth.instance.currentUser!.uid;
    await FirebaseDatabase.instance.ref().child('user').child(userId).child('like').child(keys).set({
      'name' : nama,
      'harga' : harga,
      'images' : alamat,
      'alamat' : images,
      'keys' : keys
    });
  }

  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    final themeState = Utils(context).getTheme;
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
    GlobalMethods globalMethods = GlobalMethods();
    return Material(
      color: Theme.of(context).cardColor.withOpacity(0.9),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: (){
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => DetailScreen(keys: keys,))
            );
        },
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                  Image.network(  alamat!,
                  width: size.width * 0.95,
                  height: size.width * 0.30,
                  fit: BoxFit.fill),
                ],
                ),
              ]
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5, top: 5 ),
                  child: Text(nama, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5, top: 4),
                  child: Column(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: (){
                          saveLike();
                          showLogoutDialog();
                        },
                        child: Icon(
                          IconlyLight.heart,
                          size: 22,
                          color: color, ),
                      )
                    ],
                  )
                ],
              ),
                ),
              
            ],),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5, top: 5 ),
                  child: Text(harga!.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.green)),
                ),
              ]
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 350,
                  margin: EdgeInsets.only(left: 5, top: 10 ),
                  child: Text(images!,maxLines: 1,
                  overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 15)),
                ),
              ]
            )
          ],),
          ),
      ),
    );
  }

  Future <void > showLogoutDialog() async{
    await showDialog(
      context: context,
      builder: (context){
              return AlertDialog(
              title: Row(children: [
                Image.asset(
                  'assets/images/warning-sign.png',
                  height: 20,
                  width: 20,
                  fit: BoxFit.fill
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text('Success!!')
              ]),
              content: const Text('Success save like'),
              actions: [
                TextButton(onPressed: () {
                  if(Navigator.canPop(context)){
                    Navigator.pop(context);
                  }
                }, child: TextWidget(
                  color: Colors.cyan,
                  text: 'OK',
                  textSize: 18,
                ),
                ),
              ],
              );
      }
    );
  }
}