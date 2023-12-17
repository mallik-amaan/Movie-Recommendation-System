import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:mrs/Screens/Favourites.dart';
import 'package:mrs/Screens/Profile.dart';
import 'package:mrs/Screens/homescreen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final List<Widget> _screens = const [
    HomeScreen(),
    Favourites(),
    Account(),
  ];

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 39, 40, 41),
        bottomNavigationBar: CurvedNavigationBar(
          animationCurve: Curves.easeIn,
          animationDuration: Duration(milliseconds: 200),
          backgroundColor: Colors.transparent,
          color: Color.fromARGB(255, 82, 113, 255),

          items: [
            Container(child:Image.asset("lib/assets/home.png",color: Colors.white,),height:30,width: 30,),
            Container(child:Image.asset("lib/assets/heart.png",color: Colors.white,),height:30,width: 30,),
            Container(child:Image.asset("lib/assets/user.png",color: Colors.white,),height:30,width: 30,),
        ],
        onTap: (value){
            setState(() {
              currentindex=value;
            });
        },
        ),
        body: Center(
          child: _screens[currentindex],
        ));
  }
}