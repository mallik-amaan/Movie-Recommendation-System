import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import '../Backend/API.dart';
import '../Constants.dart';
import 'MovieDetails.dart';
class PlotSearch extends StatefulWidget {
  const PlotSearch({super.key});

  @override
  State<PlotSearch> createState() => _PlotSearchState();
}

class _PlotSearchState extends State<PlotSearch> {
  final Box=Hive.box("localDatabase");
  bool isSearched=false;
  var favorites=[];
  void LoadData() {
    if (Box.get('Fav') == null)
      favorites = [];
    else {
      favorites = Box.get('Fav');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    LoadData();
    super.initState();
  }
  var plot=new TextEditingController();
  var DecodedRecommendations;
  bool gotRecommendationgData=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 39, 40, 41),
        title: Text("MRS",style: GoogleFonts.montserrat(color: Color.fromARGB(255, 82, 113, 255),fontSize: 40,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Image.asset('lib/assets/logo.png'),
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 39, 40, 41),
      body:SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: Container(
                height: 150,
                width: 300,
                child: TextFormField(
                  controller: plot,
                  maxLines: 5,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 15
                  ),
                  decoration: InputDecoration(
                    labelText: 'Enter Plot Here',
                    labelStyle: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green,strokeAlign: BorderSide.strokeAlignOutside),
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 82, 113, 255)
              ),
              child: TextButton(
                onPressed: (){
                  searchPLot(plot.text);
                },
                child: Text("Search",style: GoogleFonts.montserrat(fontSize: 15,color: Colors.white),),
              ),
            ),
            isSearched?Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MovieCard(DecodedRecommendations[0]["id"],DecodedRecommendations[0]["title"],DecodedRecommendations[0]["backdrop_path"], DecodedRecommendations[0]["poster_path"],DecodedRecommendations[0]["overview"],DecodedRecommendations[0]["vote_count"],DecodedRecommendations[0]["vote_average"],DecodedRecommendations[0]["genre_ids"]),
                    MovieCard(DecodedRecommendations[1]["id"],DecodedRecommendations[1]["title"],DecodedRecommendations[1]["backdrop_path"], DecodedRecommendations[1]["poster_path"],DecodedRecommendations[1]["overview"],DecodedRecommendations[1]["vote_count"],DecodedRecommendations[1]["vote_average"],DecodedRecommendations[1]["genre_ids"]),

                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MovieCard(DecodedRecommendations[2]["id"],DecodedRecommendations[2]["title"],DecodedRecommendations[2]["backdrop_path"], DecodedRecommendations[2]["poster_path"],DecodedRecommendations[2]["overview"],DecodedRecommendations[2]["vote_count"],DecodedRecommendations[2]["vote_average"],DecodedRecommendations[2]["genre_ids"]),
                    MovieCard(DecodedRecommendations[3]["id"],DecodedRecommendations[3]["title"],DecodedRecommendations[3]["backdrop_path"], DecodedRecommendations[3]["poster_path"],DecodedRecommendations[3]["overview"],DecodedRecommendations[3]["vote_count"],DecodedRecommendations[3]["vote_average"],DecodedRecommendations[3]["genre_ids"]),

                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MovieCard(DecodedRecommendations[4]["id"],DecodedRecommendations[4]["title"],DecodedRecommendations[4]["backdrop_path"], DecodedRecommendations[4]["poster_path"],DecodedRecommendations[4]["overview"],DecodedRecommendations[4]["vote_count"],DecodedRecommendations[4]["vote_average"],DecodedRecommendations[4]["genre_ids"]),
                    MovieCard(DecodedRecommendations[5]["id"],DecodedRecommendations[5]["title"],DecodedRecommendations[5]["backdrop_path"], DecodedRecommendations[5]["poster_path"],DecodedRecommendations[5]["overview"],DecodedRecommendations[5]["vote_count"],DecodedRecommendations[5]["vote_average"],DecodedRecommendations[5]["genre_ids"]),

                  ],
                ),
              ],
            ):Row()
          ],
        ),
      ),
    );
  }

  void searchPLot(String plot) async
  {
    String url="http://$ipaddress/plotsearch?Plot=$plot";
    var Data=await GetData(Uri.parse(url));
    DecodedRecommendations=jsonDecode(Data);
    setState(() {
      print(DecodedRecommendations);
      gotRecommendationgData=true;
      print(gotRecommendationgData);
      isSearched=true;
    });
  }
  Widget MovieCard(int id,String movieName, String backdrop,String imageUrl,String overview,int votings,double ratings,List genres) {

    var saveicon=AssetImage("lib/assets/beforesave.png");
    Color savecolor=Colors.white;
    bool favorite;
    if(favorites.any((element) => element["title"]==movieName))
    {
      favorite=true;
    }
    else
    {
      favorite=false;
    }
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>
            MovieDetails(title: movieName,
              id: id,
              poster_path: imageUrl,
              overview: overview,
              backdrop: backdrop,
              ratings: ratings,
              votes: votings,
              genres: genres,
            )
        ));
      },

      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: 370,
          width: 150,
          child: Column(
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(imageUrl,scale: 1)),
                ),
                child: Row(crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(child: IconButton(onPressed: ()
                    {
                      setState(() {
                        if(favorite)
                        {
                          favorites.removeWhere((element) => element["title"]==movieName);
                          Box.put("Fav",favorites);
                        }
                        else
                        {
                          Map<String,dynamic> newItem={"title":movieName,"imageUrl":imageUrl,"overview":overview};
                          favorites.add(newItem);
                          Box.put("Fav",favorites);
                        }
                        favorite=!favorite;

                        print(favorite);
                        print(favorites);
                      });
                    },
                      icon: favorite?Icon(Icons.favorite,color: Colors.red,size:30 ,):Icon(Icons.favorite,color: Colors.grey,size: 30,),
                    ),)

                  ],
                ),
              ),
              Text(movieName,style: GoogleFonts.nunito(color: Colors.white),textAlign: TextAlign.center,),
            ],
          ),
        ),
      ),
    );
  }
}
