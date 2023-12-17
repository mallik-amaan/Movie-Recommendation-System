import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mrs/Constants.dart';

import '../Backend/API.dart';
import 'MovieDetails.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> DecodedData = [];
  String Hinttext = "Search";
  var searchtext = new TextEditingController();
  bool searchMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 39, 40, 41),
        title: Text("Search",style: GoogleFonts.montserrat(color: Color.fromARGB(255, 82, 113, 255),fontSize: 40,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Image.asset('lib/assets/logo.png'),
          ),
        ),

      ),
      backgroundColor: Color.fromARGB(255, 39, 40, 41),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 35.0,right: 35,top: 10,bottom: 10),
            child: TextFormField(
              controller: searchtext,
              onTap: () {
                setState(() {
                  searchMode = true;
                });
              },
              onChanged: (value) async {
                String url =
                    "http://$ipaddress/search?Query=" + value.toString();
                var Data = await GetData(Uri.parse(url));
                setState(() {
                  DecodedData = jsonDecode(Data);
                  //DecodedData.sort((a, b) => b["vote_average"].compareTo(a["vote_average"]));
                });
              },
              style: GoogleFonts.montserrat(fontSize: 20, color: Colors.white),
              decoration: InputDecoration(

                fillColor: Colors.green,
                filled: false,
                prefixIcon: Icon(Icons.search,color: Colors.white,),
                labelText: Hinttext,
                labelStyle:
                GoogleFonts.montserrat(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  gapPadding: 10,
                  borderSide: BorderSide(
                    color: Colors.yellow,
                    width: 20,
                  ),
                ),
              ),
            ),
          ),
          !DecodedData.isEmpty?Expanded(
            child: ListView.builder(itemCount: (DecodedData.length/2).floor(),itemBuilder:(context,index)
            { int mid=(DecodedData.length/2).floor();
              var movie1=DecodedData[index]["title"];
              movie1=movie1.toString().isNotEmpty?movie1:"Not Found";
              var movie2=DecodedData[index+mid]["title"];
            movie2=movie2.toString().isNotEmpty?movie2:"Not Found";
              return MovieCard(
                  DecodedData[index]["id"],DecodedData[index+mid]["id"],
                  DecodedData[index]["poster_path"] ,movie1,DecodedData[index]["vote_average"],DecodedData[index]["backdrop_path"],
                  DecodedData[index]["vote_count"],DecodedData[index]["genre_ids"],DecodedData[index]["overview"],
                  DecodedData[index+mid]["poster_path"],movie2,DecodedData[index+mid]["vote_average"],
                DecodedData[index+mid]["backdrop_path"],DecodedData[index+mid]["vote_count"],DecodedData[index+mid]["genre_ids"],
                DecodedData[index+mid]["overview"]
              );
            }
            ),
          ):Row()
        ],
      ),
    );
  }

  Widget MovieCard(var id1,var id2,var imageUrl1, var movieName1,var Rate1,var backdrop1,var votes1,List genres1,var overview1,var imageUrl2, var movieName2,var Rate2,var backdrop2,var votes2,List genres2,var overview2) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: ()
          {
            Navigator.push(context,MaterialPageRoute(builder: (context)=>
                MovieDetails(title: movieName1,
                  id: id1,
                  poster_path: imageUrl1,
                  overview: overview1,
                  backdrop: backdrop1,
                  ratings: Rate1,
                  votes: votes1,
                  genres: genres1,
                )
            ));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 320,
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
        ),
        GestureDetector(
          onTap: ()
          {
            Navigator.push(context,MaterialPageRoute(builder: (context)=>
                MovieDetails(title: movieName2,
                  id: id2,
                  poster_path: imageUrl2,
                  overview: overview2,
                  backdrop: backdrop2,
                  ratings: Rate2,
                  votes: votes2,
                  genres: genres2,
                )
            ));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 320,
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
        ),

      ],
    );
  }
}
