import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mrs/Backend/API.dart';
import 'dart:convert';

import 'package:mrs/Constants.dart';
class ForYou extends StatefulWidget {
  const ForYou({super.key});

  @override
  State<ForYou> createState() => _ForYouState();
}

class _ForYouState extends State<ForYou> {
  List<dynamic> DecodedData=[];

  bool gotData=false;
  final Box=Hive.box("localDatabase");
  var favorites=[];
  void LoadData() {
    if (Box.get('Fav') == null)
      favorites = [];
    else {
      favorites = Box.get('Fav');
    }
  }
  @override
  void initState(){
    // TODO: implement initState
    LoadData();
    getData();
    super.initState();
  }
  void getData() async
  { String url;
    if(favorites.isEmpty) {

    url = "http://$ipaddress/recommendation?MovieId=872585";
  }else {
    int index=Random().nextInt(favorites.length);

    url = "http://$ipaddress/recommendation?MovieId=" +
        favorites[index]["id"].toString();
  }
  var Data=await GetData(Uri.parse(url));
    DecodedData=jsonDecode(Data);
    print(DecodedData[0]["title"]);
    setState(() {
      gotData=true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 39, 40, 41),
        title: Text("For You",style: GoogleFonts.montserrat(color: Color.fromARGB(255, 82, 113, 255),fontSize: 40,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Image.asset('lib/assets/logo.png'),
          ),
        ),

      ),
      backgroundColor: Color.fromARGB(255, 39, 40, 41),
      body:
      gotData?Container(
      child:Expanded(
        child: ListView.builder(itemCount: (DecodedData.length/2).floor(),itemBuilder:(context,index)
        { int mid=(DecodedData.length/2).floor();
        var movie1=DecodedData[index]["title"];
        movie1=movie1.toString().isNotEmpty?movie1:"Not Found";
        var movie2=DecodedData[index+mid]["title"];
        movie2=movie2.toString().isNotEmpty?movie2:"Not Found";
        return MovieCard(DecodedData[index]["poster_path"] ,movie1,DecodedData[index]["vote_average"].toString()
            , DecodedData[index+mid]["poster_path"],movie2,DecodedData[index+mid]["vote_average"].toString()
        );
        }
        ))):Center(child:LoadingAnimationWidget.staggeredDotsWave(size: 50,color: Colors.white)),
    );
  }
  Widget MovieCard(var imageUrl1, var movieName1,var Rate1,var imageUrl2, var movieName2,var Rate2) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.network(
                    imageUrl1,
                    height: 200,
                    width: 180,
                  ),
                ),
                Text(
                  movieName1,
                  style: GoogleFonts.oswald(
                    fontSize: movieName1.length<25?15:07,
                    color: Colors.orange,
                  ),
                ),
                Text(
                  "Rating:  $Rate1",
                  style: GoogleFonts.oswald(
                    fontSize: 12,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.network(
                    imageUrl2,
                    height: 200,
                    width: 180,
                  ),
                ),
                Text(
                  movieName2,
                  style: GoogleFonts.oswald(
                    fontSize: movieName2.length<25?15:07,
                    color: Colors.orange,
                  ),
                ),
                Text(
                  "Rating:  $Rate2",
                  style: GoogleFonts.oswald(
                    fontSize: 12,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }

}
