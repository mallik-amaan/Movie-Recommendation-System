import 'dart:convert';
import 'dart:ui';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mrs/Constants.dart';
import '../Backend/API.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mrs/Screens/homescreen.dart';class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  bool dataloaded = false;
  var FavMovies=[];
  var box = Hive.box('localDatabase');
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {

    FavMovies=box.get('Fav');
        setState(() {
      dataloaded = true;
    });
  }
  Future<void> update() async {
    var box = await Hive.box('localDatabase');
    await box.put('Fav',FavMovies);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 39, 40, 41),
    title: Text("Favourites",style: GoogleFonts.montserrat(color: Color.fromARGB(255, 82, 113, 255),fontSize: 40,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
    leading: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
    child: Image.asset('lib/assets/logo.png'),
    ),
    ),

    ),

    backgroundColor: Color.fromARGB(255, 39, 40, 41),
      body: dataloaded
          ? SingleChildScrollView(
            child: Column(
              children: [
                for (int i=0;i<FavMovies.length/2;i++)
                  Row(
                    children: [
                      MovieCard(FavMovies[i]["title"], FavMovies[i]["imageUrl"], FavMovies[i]["overview"],FavMovies[i]["ratings"]),
                      if(i+(FavMovies.length/2).ceil()<FavMovies.length)
                      MovieCard(FavMovies[i+(FavMovies.length/2).ceil()]["title"], FavMovies[i+(FavMovies.length/2).ceil()]["imageUrl"], FavMovies[i+(FavMovies.length/2).ceil()]["overview"],FavMovies[i+(FavMovies.length/2).ceil()]["ratings"]),
                    ],
                  )
              ],
            ),
          )
          : LoadingAnimationWidget.staggeredDotsWave(color: Colors.orange, size: 20),
    );
  }

  Widget MovieCard( String movieName, String imageUrl, String overview,double ratings) {
    bool favorite;
    if(FavMovies.any((element) => element["title"]==movieName))
      {
        favorite=true;
      }
    else
      {
        favorite=false;
      }
   return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 82, 113, 255),
          borderRadius: BorderRadius.circular(20),
          //image: DecorationImage(image: NetworkImage(imageUrl,scale: 2))
        ),
        height: 350,
        width: MediaQuery.of(context).size.width*0.45,
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Image.network(imageUrl,scale: 2.5),
                    ),
                  )
                  ,Text(movieName,style: GoogleFonts.montserrat(color:Colors.white,fontSize: 15,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                          Text("Rating: $ratings",style: GoogleFonts.montserrat(color: Colors.white),),
                  Container(child: IconButton(onPressed: ()
                  {
                    setState(() {
                      if(favorite)
                      {
                        FavMovies.removeWhere((element) => element["title"]==movieName);
                        box.put("Fav",FavMovies);
                      }
                      else
                      {
                        Map<String,dynamic> newItem={"title":movieName,"imageUrl":imageUrl,"overview":overview};
                        FavMovies.add(newItem);
                        box.put("Fav",FavMovies);
                      }
                      favorite=!favorite;
                    });
                  },
                    icon: favorite?Icon(Icons.favorite,color: Colors.red,size:30 ,):Icon(Icons.favorite,color: Colors.grey,size: 30,),
                  ),)

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
