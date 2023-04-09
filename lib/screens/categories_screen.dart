import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/service/utils.dart';
import 'package:flutter_application/widget/on_sale_home.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../widget/on_sale_widget.dart';
import '../widget/text_widget.dart';

class DetailCategoriesScreen extends StatefulWidget {
  final type;
  const DetailCategoriesScreen({super.key, required this.type});

  @override
  State<DetailCategoriesScreen> createState() => _categoriesState(type);
}

class _categoriesState extends State<DetailCategoriesScreen> {

  final type;
  _categoriesState(this.type);

  final TextEditingController? _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();
  @override
  void dispose() {
    _searchTextController!.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    final fDatabase = FirebaseDatabase.instance.ref().child('tanah').orderByChild('type').equalTo(type);

    // TODO: implement build
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
          text: 'Categories',
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
              child: SizedBox(
                height: kBottomNavigationBarHeight,
                child: TextField(
                  focusNode: _searchTextFocusNode,
                    controller: _searchTextController,
                    onChanged: (valuee) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: Colors.greenAccent, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: Colors.greenAccent, width: 1),
                      ),
                      hintText: "What's in your mind",
                      prefixIcon: const Icon(Icons.search),
                      suffix: IconButton(
                        onPressed: () {
                          _searchTextController!.clear();
                          _searchTextFocusNode.unfocus();
                        },
                        icon: Icon(
                          Icons.close,
                          color: _searchTextFocusNode.hasFocus ? Colors.red : color,
                        ),
                      ),
                    ),
                ),
              ),
            ),

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