import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application/service/utils.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../widget/on_sale_widget.dart';
import '../widget/text_widget.dart';

class CartScreen extends StatefulWidget {
  static const routeName = "/CartScreen";
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController? _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();
  @override
  void dispose() {
    _searchTextController!.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  final user = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    bool isEmpety = true;
    final Utils utils = Utils(context);
    final themeState = Utils(context).getTheme;
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
    return Scaffold(
      appBar: AppBar(
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
          text: 'Like',
          color: color,
          textSize: 20.0,
          isTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
            ),

            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: FirebaseAnimatedList(
              defaultChild: Center(child: CircularProgressIndicator()),
              query: FirebaseDatabase.instance.ref().child('user').child(user).child('like'), 
              itemBuilder: ((context, snapshot, animation, index) {
                Map tanah = snapshot.value as Map;
                tanah['key'] = snapshot.key;

                var name = tanah['name'];
                var price = tanah['harga'];
                // var alamat = tanah['alamat'];
                var alamat = tanah['alamat'];
                var image = tanah['images'];
                var keys = tanah['keys'];

                return OnSaleWidget(
                  nama: name, 
                  harga: price, 
                  images: image, 
                  alamat: alamat,
                  keys: keys,
                );
              })
              )
            )



            // GridView.count(
            //     shrinkWrap: true,
            //     physics: const NeverScrollableScrollPhysics(),
            //     crossAxisCount: 1,
            //     childAspectRatio: size.width / (size.height * 0.32),
            //     mainAxisSpacing: 10,
            //     children: List.generate(6, (index) {
            //       return OnSaleWidget();
            //     }
            //     ),
            //   ),
          ],
        ),
      )
    );
  }
}