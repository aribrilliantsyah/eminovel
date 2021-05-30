import 'dart:async';
import 'package:eminovel/pages/app.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
 
class SplashScreen extends StatefulWidget{
  @override
  _SplashScreen createState() => _SplashScreen();
}
 
class _SplashScreen extends State<SplashScreen>{
  final LocalStorage storage = new LocalStorage('profile_data.json');
  String username = 'admin123';
  String name = 'Admin';
  String description = 'This is admin account';
  String photo_url = 'https://www.showflipper.com/blog/images/default.jpg';

  void get_profile() async{
    await storage.ready;
    setState(() {
      username = storage.getItem('username') != null ? storage.getItem('username') : username;
      name = storage.getItem('name') != null ? storage.getItem('name') : name;
      description = storage.getItem('description') != null ? storage.getItem('description') : description;
      photo_url = storage.getItem('photo_url') != null ? storage.getItem('photo_url') : photo_url;
    });
  }

  void initState(){
    super.initState();
    startSplashScreen();
  }
 
  startSplashScreen() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return App();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: new Image.asset(
                "assets/images/logo.png",
                width: 250.0,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 24),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "©ARI 2021",
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}