import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../Backend/API.dart';
import '../Constants.dart';

class MovieDetails extends StatefulWidget {
   MovieDetails({super.key,
     required this.id,
    required this.title, required this.backdrop, required this.poster_path, required this.overview,
    required this.ratings, required this.votes, required this.genres,
  });
   final String title;
   final String backdrop;
   final String poster_path;
   final String overview;
   final double ratings;
   final int votes;
   final List genres;
   final int id;

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  var genreNames="";
  bool dataLoaded=false;

  @override
  void initState() {
    // TODO: implement initState
    getGenreNames();
    LoadData();
    checkFav();
    super.initState();
  }
  final Box=Hive.box("localDatabase");
  var FavMovies=[];
  bool isFav=false;
  void checkFav()
  {
    if(FavMovies.any((element) => element["title"]==widget.title))
    {
        setState(() {
          isFav=true;
        });
    }
    else
      setState(() {
        isFav=false;
      });
  }
  void LoadData() {
    if (Box.get('Fav') == null)
      FavMovies = [];
    else {
      FavMovies = Box.get('Fav');
    }
  }
  Future<void> getGenreNames() async
  {
    var items;
    var count=1;
    for (items in widget.genres) {
      var Data = await GetData(
          Uri.parse("http://$ipaddress/genre?GenreId=$items"));
      var DecodedData = jsonDecode(Data);
      setState(() {
        if(count%4==0)
          genreNames=genreNames+DecodedData["name"].toString()+", \n";
        else if(widget.genres.length==count)
          genreNames=genreNames+DecodedData["name"].toString();
        else
        genreNames=genreNames+DecodedData["name"].toString()+", ";
        count++;
      });
      }
    setState(() {
      dataLoaded=true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 39, 40, 41),
          title: Text("Details",style: GoogleFonts.montserrat(color: Color.fromARGB(255, 82, 113, 255),fontSize: 40,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Image.asset('lib/assets/logo.png'),
            ),
          ),

        ),
        backgroundColor: Color.fromARGB(255, 39, 40, 41),
        body:dataLoaded?SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  child: Image.network(widget.backdrop,scale:0.1,height: 250,width: MediaQuery.of(context).size.width,),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(//mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 120,
                            height: 170,
                            color: Colors.grey,
                            child: Image.network(widget.poster_path,scale: 0.1,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.title,style: GoogleFonts.montserrat(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                                  SizedBox(height: 20,),
                                  Text("Rating: ${widget.ratings}",style: GoogleFonts.montserrat(fontSize: 15,color: Colors.white),),
                                  Text("Votes: ${widget.votes}",style: GoogleFonts.montserrat(fontSize: 15,color: Colors.white),),
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Add to Favorites",style: GoogleFonts.montserrat(color: Colors.white,fontSize: 15),),
                                      IconButton(onPressed: (){
                                        if(isFav)
                                          {
                                            FavMovies.removeWhere((element) => element["title"]==widget.title);
                                            Box.put("Fav",FavMovies);
                                            setState(() {
                                              isFav=!isFav;
                                            });
                                          }
                                        else
                                          {
                                            Map<String,dynamic> newItem={"id":widget.id,"title":widget.title,"imageUrl":widget.poster_path,"overview":widget.overview,"ratings":widget.ratings};
                                            FavMovies.add(newItem);
                                            Box.put("Fav",FavMovies);
                                            setState(() {
                                              isFav=!isFav;
                                            });
                                          }

                                      }, icon:isFav ?
                                      Icon(Icons.favorite,color: Colors.red,size: 30,):
                                        Icon(Icons.favorite,color: Colors.grey,size: 30,)
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child:Row(
                        children: [
                          Text("Genre:",style: GoogleFonts.montserrat(fontWeight:FontWeight.bold,fontSize: 20,color: Colors.white),),
                        ],
                      ),
                    ),
                    SizedBox(height: 12,),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child:Row(
                        children: [
                          SizedBox(height: 15,),
                          Text(genreNames,style: GoogleFonts.montserrat(fontSize: 15,color: Colors.white),),
                        ],
                      ),
                    ),
                    SizedBox(height: 12,),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Row(
                        children: [
                          SizedBox(height: 12,),
                          Text("OverView: ",style: GoogleFonts.montserrat(fontWeight:FontWeight.bold,fontSize: 20,color: Colors.white),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.overview,style: GoogleFonts.montserrat(color: Colors.white),),
                    )
                  ],
                ),
              ),
        
            ],
          ),
        ),
      ):Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.orange, size: 20))
    );
  }
}
