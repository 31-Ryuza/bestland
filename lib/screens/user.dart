import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application/screens/auth_page.dart';
import 'package:flutter_application/screens/cart.dart';
import 'package:flutter_application/widget/text_widget.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';
import '../service/global_metods.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
    final TextEditingController _addressTextController =
      TextEditingController(text: "");
    final TextEditingController _profileTextController =
      TextEditingController(text: "");
  @override
  void dispose() {
    _addressTextController.dispose();
    _profileTextController.dispose();
    super.dispose();
  }

  Future<void> savedProfile() async{
    final userID = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseDatabase.instance.ref().child('user').child(userID).child('profile').child('username').set(_profileTextController.text);
    setState(() {
      username = _profileTextController.text;
    });
  }

  Future<void> savedAddress() async{
    final userID = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseDatabase.instance.ref().child('user').child(userID).child('profile').child('address').set(_addressTextController.text);
    setState(() {
      address = _addressTextController.text;
    });
  }

  String?username;
  String?address;

  Future<void> getProfile() async{
    final userID = FirebaseAuth.instance.currentUser!.uid;
    var usernameSnapShot =  await FirebaseDatabase.instance.ref().child('user').child(userID).child('profile').child('username').once();
    setState(() {
      username = usernameSnapShot.snapshot.value.toString();
    });
  }

  Future<void> getAddress() async{
    final userID = FirebaseAuth.instance.currentUser!.uid;
    var addressSnapShot =  await FirebaseDatabase.instance.ref().child('user').child(userID).child('profile').child('address').once();
    setState(() {
      address = addressSnapShot.snapshot.value.toString();
    });
  }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
    getAddress();
  }
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser!.email;
    return  Scaffold(
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                RichText(
                  text: TextSpan(text: 'Hi,  ', 
                  style: const TextStyle(color: Colors.cyan, fontSize: 27, fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: username == 'null' ? 'Human' : username,
                      style: TextStyle(
                        color: color,
                        fontSize: 25,
                        fontWeight: FontWeight.w600
                      ),
                      recognizer: TapGestureRecognizer()..onTap = (){
                        print('My Name Is Ryuza');
                      }
                    )
                  ]
                  )
                ),
                const SizedBox(
                  height: 5,
                ),
                TextWidget(
                text: user.toString(), 
                color: color, 
                textSize: 10),
                const Divider(
                  thickness: 2,
                ),
                const Divider(
                  height: 20,
                ),
                  _listTiles(
                  title: 'Profile',
                  subtitle: username == 'null' ? 'Human' : username,
                  icon: IconlyBold.profile, 
                  onPressed: () async{
                    await showProfileDialog();
                  },
                  color: color
                  ),
                  _listTiles(
                  title: 'Address',
                  subtitle: address == 'null' ? '' : address,
                  icon: IconlyBold.home, 
                  onPressed: () async{
                    await showAddressDialog();
                  },
                  color: color
                  ),
                  _listTiles(
                  title: 'Like',
                  icon: IconlyBold.heart, 
                  onPressed: (){
                    GlobalMethods.navigateTo(ctx: context, routeName: CartScreen.routeName);
                  },
                  color: color
                  ),
                  SwitchListTile(
                  title: TextWidget(
                    color: color,
                    text: themeState.getDarkTheme ? 'Dark' : 'Light',
                    textSize: 16,
                  ),
                  subtitle: Text(''),
                  secondary: Icon(themeState.getDarkTheme ? Icons.dark_mode_outlined : Icons.light_mode_outlined),
                  onChanged: (bool value){
                    setState(() {
                      themeState.setDarkTheme = value;
                    });
                  }, 
                  value: themeState.getDarkTheme,
                  ),
                  _listTiles(
                  title: 'Logout',
                  icon: IconlyBold.logout, 
                  onPressed: (){
                    showLogoutDialog();
                  },
                  color: Color.fromARGB(255, 0, 0, 0)
                  ),
              ],
            ),
          )
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
                  const Text('Sign Out')
              ]),
              content: const Text('Do you wanna sign out?'),
              actions: [
                TextButton(onPressed: () {
                  if(Navigator.canPop(context)){
                    Navigator.pop(context);
                  }
                }, child: TextWidget(
                  color: Colors.cyan,
                  text: 'Cencel',
                  textSize: 18,
                ),
                ),
                TextButton(onPressed: () async{
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context
                  , MaterialPageRoute(builder: (context) => LoginPage()));
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

  Future <void > showProfileDialog() async{
    await showDialog(
                      context: context, 
                      builder: (context){
                      return AlertDialog(
                        title: const Text('Update'),
                        content: TextField(
                          onChanged: (value) {
                            print('_addressTextController.text ${_profileTextController.text}');
                          },
                          controller: _profileTextController,
                          decoration: InputDecoration(hintText: 'Your profile'),
                        ),
                        actions: [
                          TextButton(onPressed: () {
                            savedProfile();
                            Navigator.pop(context);
                          }, child: Text('Saved Profile'))
                        ],
                      );
                    });
  }

  Future <void > showAddressDialog() async{
    await showDialog(
                      context: context, 
                      builder: (context){
                      return AlertDialog(
                        title: const Text('Update'),
                        content: TextField(
                          onChanged: (value) {
                            print('_addressTextController.text ${_addressTextController.text}');
                          },
                          controller: _addressTextController,
                          decoration: InputDecoration(hintText: 'Your Address'),
                        ),
                        actions: [
                          TextButton(onPressed: () {
                            savedAddress();
                            Navigator.pop(context);
                          }, child: Text('Saved Address'))
                        ],
                      );
                    });
  }

  Widget _listTiles({
    required String title,
    String? subtitle,
    required IconData icon,
    required Function onPressed,
    required Color color,
  }) {
    return ListTile(
      title: Text(
        title,
      ),
      subtitle: TextWidget(
        text: subtitle == null ? "" : subtitle,
        color: color,
        textSize: 10,
      ),
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrowRight2),
      onTap: () {
        onPressed();
      },
    );
  }
}