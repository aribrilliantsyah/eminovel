import 'package:eminovel/helpers/constants.dart';
import 'package:eminovel/pages/home.dart';
import 'package:eminovel/pages/favorite.dart';
import 'package:eminovel/pages/login.dart';
import 'package:eminovel/pages/notif.dart';
import 'package:eminovel/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localstorage/localstorage.dart';

class App extends StatefulWidget {
  final int selectedPage;

  const App({Key? key, this.selectedPage = 0}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  final LocalStorage storage = new LocalStorage('profile_data.json');
  String is_auth = 'false';
  int currentIndex = 0;
  late TabController tabController;
  var navItem = [
    {
      "icon": Ionicons.planet,
      "title": "Home",
    },
    {
      "icon": Ionicons.heart,
      "title": "Favorite",
    },
    {
      "icon": Ionicons.notifications,
      "title": "Notif",
    },
    {
      "icon": Ionicons.person,
      "title": "Profile",
    },
  ];

  handleTabSelection() {
    setState(() {
      currentIndex = tabController.index;
    });
  }
  
  @override
  void initState(){
    check_auth();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(handleTabSelection);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void check_auth() async {
    await storage.ready;
    setState(() {
      is_auth = storage.getItem('is_auth') != null ? storage.getItem('is_auth') : is_auth;
    });

    if(is_auth == '' || is_auth == 'false'){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return Login();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        children: [
          Home(storage: storage),
          Favorite(),
          Notif(),
          Profile(storage: storage)
        ],
        controller: tabController,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFFFFFFFF),
        selectedItemColor: Color(0xFFC57BF4),
        unselectedItemColor: Color(0xFF857A8B),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: currentIndex,
        showUnselectedLabels: false,
        onTap: (int index) {
          tabController.animateTo(index);
          setState(() {
            currentIndex = index;
          });
        },
        items: navItem.map((obj) {
          IconData icon = obj['icon'] as IconData;
          return BottomNavigationBarItem(
            icon: Icon(icon),
            title: Container(
              width: 10.0,
              height: 6.0,
              margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: rei_primaryColor,
                borderRadius: new BorderRadius.all(Radius.circular(3)),
              ),
            ),
          );
        }).toList()
      ),
    );
  }

}