import 'package:card_swiper/card_swiper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application/inner_screen/on_sale_screen.dart';
import 'package:flutter_application/service/global_metods.dart';
import 'package:flutter_application/service/utils.dart';
import 'package:flutter_application/widget/on_sale_widget.dart';
import 'package:flutter_application/widget/text_widget.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class DetailScreen extends StatefulWidget {
  final keys;
  const DetailScreen({Key? key, required this.keys}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState(keys);
}

class _DetailScreenState extends State<DetailScreen> {

  final keys;
  _DetailScreenState(this.keys);

  final List<String> _offerImages = [
    'assets/images/tanah/tanah2.png'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  bool loading = false;

    String? nama;
    String? alamat;
    String? harga;
    String? deskripsi;
    String? images;
    String? type;
    String? sertifikasi;
    String? no_hp;
    String? luas_tanah;

  Future<void> getData() async {

      var fDatabse = FirebaseDatabase.instance.ref().child('tanah').child(keys);

      setState(() {
        loading = true;
      });

      var name = await fDatabse.child('nama').once();
      var lokasi = await fDatabse.child('lokasi').once();
      var price = await fDatabse.child('harga').once();
      var desc = await fDatabse.child('deskripsi').once();
      var image = await fDatabse.child('images').once();
      var typ = await fDatabse.child('type').once();
      var sert = await fDatabse.child('sertifikasi').once();
      var no = await fDatabse.child('no_hp').once();
      var luas = await fDatabse.child('luas').once();


      setState(() {
        nama = name.snapshot.value.toString();
        alamat = lokasi.snapshot.value.toString();
        harga = price.snapshot.value.toString();
        deskripsi = desc.snapshot.value.toString();
        images = image.snapshot.value.toString();
        type = typ.snapshot.value.toString();
        sertifikasi = sert.snapshot.value.toString();
        no_hp = no.snapshot.value.toString();
        luas_tanah = luas.snapshot.value.toString(); 
      });

      setState(() {
        loading = false;
      });
    }  

  @override
  Widget build(BuildContext context) {

    final Utils utils = Utils(context);
    final themeState = Utils(context).getTheme;
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
    GlobalMethods globalMethods = GlobalMethods();
    double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: loading ? Center(child: CircularProgressIndicator(),)
      : SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              leading: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(IconlyLight.arrowLeft2, color: color,),
              ),
              elevation: 0,
              centerTitle: true,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: TextWidget(
                text: 'Detail',
                color: color,
                textSize: 20.0,
                isTitle: true,
              ),
            ),
            SizedBox(
              height: size.height * 0.30,
              child: Swiper(
              itemBuilder: (BuildContext context,int index){
                return Image.network(images!,fit: BoxFit.fill,);
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
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      TextWidget(
                        text: harga ?? '', 
                        color: color, 
                        textSize: 15, 
                        isTitle: true,),
                    ],),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5 ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      TextWidget(
                        text: nama!, 
                        color: color, 
                        textSize: 15,),
                    ],),
                  ),
                  Container(
                     margin: EdgeInsets.only( top: 5, bottom: 5 ),
                    child: Row(
                      children: [
                      TextWidget(
                        text: alamat!, 
                        color: color, 
                        textSize: 15,),
                    ],),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                    height: 10,
                  ),
                  Container(
                     margin: EdgeInsets.only( top: 5, bottom: 5 ),
                    child: Row(
                      children: [
                      TextWidget(
                        text: 'Detail', 
                        color: color, 
                        textSize: 20,
                        isTitle: true,),
                    ],),
                  ),
                  Container(
                     margin: EdgeInsets.only( top: 5, bottom: 5 ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      TextWidget(
                        text: 'Luas Tanah', 
                        color: color, 
                        textSize: 15,),
                        TextWidget(
                        text: luas_tanah!, 
                        color: color, 
                        textSize: 15,
                        isTitle: true,),
                    ],),
                  ),
                  Container(
                     margin: EdgeInsets.only( top: 5, bottom: 5 ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      TextWidget(
                        text: 'Sertifikasi', 
                        color: color, 
                        textSize: 15,),
                        TextWidget(
                        text: sertifikasi!, 
                        color: color, 
                        textSize: 15,
                        isTitle: true,),
                    ],),
                  ),
                  Container(
                     margin: EdgeInsets.only( top: 5, bottom: 5 ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      TextWidget(
                        text: 'Alamat Lokasi', 
                        color: color, 
                        textSize: 15,),
                        TextWidget(
                        text: alamat!, 
                        color: color, 
                        textSize: 15,
                        isTitle: true,),
                    ],),
                  ),
                  Container(
                     margin: EdgeInsets.only( top: 5, bottom: 5 ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      TextWidget(
                        text: 'Tipe', 
                        color: color, 
                        textSize: 15,),
                        TextWidget(
                        text: type!, 
                        color: color, 
                        textSize: 15,
                        isTitle: true,),
                    ],),
                  ),
                  Container(
                     margin: EdgeInsets.only( top: 5, bottom: 5 ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      TextWidget(
                        text: 'No Hp', 
                        color: color, 
                        textSize: 15,),
                        TextWidget(
                        text: no_hp!, 
                        color: color, 
                        textSize: 15,
                        isTitle: true,),
                    ],),
                  ),
                   const Divider(
                    color: Colors.grey,
                    thickness: 1,
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                        deskripsi!,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: color),)
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                    height: 10,
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}