
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mrs/Screens/ForYou.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:mrs/Backend/API.dart';
import 'package:mrs/Screens/MovieDetails.dart';
import 'package:mrs/Screens/searchscreen.dart';
import 'dart:convert';
import 'package:mrs/Constants.dart';
import 'package:mrs/Screens/trending.dart';
import 'dart:math';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  final Box=Hive.box("localDatabase");
  var favorites=[];
  void LoadData() {
    if (Box.get('Fav') == null)
      favorites = [];
    else {
      favorites = Box.get('Fav');
    }
  }late int n1,n2,n3,n4;
  String Hinttext="Search";
  var searchtext;
  bool searchMode=false;
  List<dynamic> DecodedObjects=[];
  List<dynamic> DecodedRecommendations=[];
  bool gotTrendingData=false;
  bool gotRecommendationgData=false;
  @override
  void initState(){
    // TODO: implement initState
    LoadData();
    getTrendingData();
    getRecommendationData();
    generateRandomNumbers();
    if(n1==n2 || n1==n3 || n1==n4 || n2==n4  || n2==n3 || n3==n4)
      {
        generateRandomNumbers();
      }
    super.initState();
  }
  void getTrendingData() async
  {
    String url="http://$ipaddress/trending";
    var Data=await GetData(Uri.parse(url));
    DecodedObjects=jsonDecode(Data);
    setState(() {
      gotTrendingData=true;
      print(gotTrendingData);

    });
  }
  void getRecommendationData() async
  { String url;
    if(favorites.isEmpty) {

      url = "http://$ipaddress/recommendation?MovieId=872585";
    }else {
      int index=Random().nextInt(favorites.length);

      url = "http://$ipaddress/recommendation?MovieId=" +
          favorites[index]["id"].toString();
    }var Data=await GetData(Uri.parse(url));
    DecodedRecommendations=jsonDecode(Data);
    setState(() {
      gotRecommendationgData=true;
      print(gotRecommendationgData);
    });
  }
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
      body:Center(
        child: (gotTrendingData && gotRecommendationgData)?SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: ()
                  {
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>SearchScreen(),));},
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Search",style: GoogleFonts.abel(color: Colors.white,fontSize: 20),),
                      IconButton(onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>SearchScreen(),));},icon: Icon(Icons.search_outlined,color: Colors.white,),),
                    ],
                  ),
                ),
              ),
              ),
              Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:8.0,bottom: 8.0,left: 16),
                        child: Container(
                            child: Text('For You',style: GoogleFonts.nunito(fontSize: 25,color:Colors.white,fontWeight: FontWeight.bold),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0,bottom: 8.0,right: 16),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>ForYou(),));
                          },
                          child: CircleAvatar(
                            backgroundColor:Color.fromARGB(255, 82, 113, 255),
                            child: Icon(Icons.arrow_forward_ios,color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                              SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  MovieCard(DecodedRecommendations[n1]["id"],DecodedRecommendations[n1]["title"],DecodedRecommendations[n1]["backdrop_path"], DecodedRecommendations[n1]["poster_path"],DecodedRecommendations[n1]["overview"],DecodedRecommendations[n1]["vote_count"],DecodedRecommendations[n1]["vote_average"],DecodedRecommendations[n1]["genre_ids"]),
                  MovieCard(DecodedRecommendations[n2]["id"],DecodedRecommendations[n2]["title"],DecodedRecommendations[n2]["backdrop_path"], DecodedRecommendations[n2]["poster_path"],DecodedRecommendations[n2]["overview"],DecodedRecommendations[n2]["vote_count"],DecodedRecommendations[n2]["vote_average"],DecodedRecommendations[n2]["genre_ids"]),
                  MovieCard(DecodedRecommendations[n3]["id"],DecodedRecommendations[n3]["title"],DecodedRecommendations[n3]["backdrop_path"], DecodedRecommendations[n3]["poster_path"],DecodedRecommendations[n3]["overview"],DecodedRecommendations[n3]["vote_count"],DecodedRecommendations[n3]["vote_average"],DecodedRecommendations[n3]["genre_ids"]),
                  MovieCard(DecodedRecommendations[n4]["id"],DecodedRecommendations[n4]["title"],DecodedRecommendations[n4]["backdrop_path"], DecodedRecommendations[n4]["poster_path"],DecodedRecommendations[n4]["overview"],DecodedRecommendations[n4]["vote_count"],DecodedRecommendations[n4]["vote_average"],DecodedRecommendations[n4]["genre_ids"]),
                ],
              ),),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:8.0,bottom: 8.0,left: 16),
                  child: Container(
                      child: Text('Trending',style: GoogleFonts.nunito(fontSize: 25,color:Colors.white,fontWeight: FontWeight.bold),)),
                ),
                GestureDetector(
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Trending()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top:8.0,bottom: 8.0,right: 16),
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 82, 113, 255),
                      child: Icon(Icons.arrow_forward_ios,color:Colors.white),
                    ),
                  ),
                )
              ],
                              ),
                              SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  MovieCard(DecodedObjects[n1]["id"],DecodedObjects[n1]["title"],DecodedObjects[n1]["backdrop_path"], DecodedObjects[n1]["poster_path"],DecodedObjects[n1]["overview"],DecodedObjects[n1]["vote_count"],DecodedObjects[n1]["vote_average"],DecodedObjects[n1]["genre_ids"]),
                  MovieCard(DecodedObjects[n2]["id"],DecodedObjects[n2]["title"],DecodedObjects[n2]["backdrop_path"], DecodedObjects[n2]["poster_path"],DecodedObjects[n2]["overview"],DecodedObjects[n2]["vote_count"],DecodedObjects[n2]["vote_average"],DecodedObjects[n2]["genre_ids"]),
                  MovieCard(DecodedObjects[n3]["id"],DecodedObjects[n3]["title"],DecodedObjects[n3]["backdrop_path"], DecodedObjects[n3]["poster_path"],DecodedObjects[n3]["overview"],DecodedObjects[n3]["vote_count"],DecodedObjects[n3]["vote_average"],DecodedObjects[n3]["genre_ids"]),
                  MovieCard(DecodedObjects[n4]["id"],DecodedObjects[n4]["title"],DecodedObjects[n4]["backdrop_path"], DecodedObjects[n4]["poster_path"],DecodedObjects[n4]["overview"],DecodedObjects[n4]["vote_count"],DecodedObjects[n4]["vote_average"],DecodedObjects[n4]["genre_ids"]),
                ],
              ),
                              ),]
              ),
             ],

          ),
        ):LoadingAnimationWidget.staggeredDotsWave(color:Colors.white, size: 50),
      )
    );
  }
  void generateRandomNumbers()
  {
    n1=Random().nextInt(19);
    n2=Random().nextInt(19);
    n3=Random().nextInt(19);
    n4=Random().nextInt(19);
  }
  Widget Moviecard()
  {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),

          ),
          height: 200,
          width: 150,

          child: Column(
            children:
            [
              Text("Game of Thrones")

            ],
          )
      ),
    );
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
                          Map<String,dynamic> newItem={"id":id,"title":movieName,"imageUrl":imageUrl,"overview":overview,"ratings":ratings};
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
