import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

import '../Backend/API.dart';
import '../Constants.dart';

class GuessTheMovie extends StatefulWidget {
  const GuessTheMovie({super.key});

  @override
  State<GuessTheMovie> createState() => _GuessTheMovieState();
}

class _GuessTheMovieState extends State<GuessTheMovie> {
  bool gotMovieDetails=false;
  bool detailssettled=false;
  bool correctanswer=false;
  bool wronganswer=false;
  Map<String,dynamic> DecodedObjects={};
  @override
  void initState() {
    // TODO: implement initState
    getGuessingMovie();
    super.initState();
  }
  String actor='';
  String director='';
  String moviename='';
  String overview='';
  String characters='';
  void setDetails()
  {
    List<dynamic> actors=DecodedObjects["actors"];
    for(var i in actors)
      {
        setState(()
        {
          actor=actor+i.toString()+', ';
        });
      }
    List<dynamic> character=DecodedObjects["characters"];
    for(var i in actors)
    {
      setState(()
      {
        characters=characters+i.toString()+', ';
      });
    }
    List<dynamic> directors=DecodedObjects["director"];
    for(var i in directors)
    {
      setState(()
      {
          director=director+i.toString()+', ';

      });
    }
    overview=DecodedObjects["overview"];
    moviename=DecodedObjects["title"];
    setState(() {
      detailssettled=true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 39, 40, 41),
        title: Text("Guess The Movie",style: GoogleFonts.montserrat(color: Color.fromARGB(255, 82, 113, 255),fontSize: 27,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Image.asset('lib/assets/logo.png'),
          ),
        ),

      ),
      backgroundColor: Color.fromARGB(255, 39, 40, 41),
      body: (gotMovieDetails && detailssettled)?SingleChildScrollView(
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Lottie.asset("lib/assets/ThinkingAnimation.json",height: 300,width: 300,repeat: false),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text("Director:",style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left:36.0,right: 36.0),
              child: Text("$director",style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 15
              ),),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text("Actors:",style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left:36.0,right:36.0),
              child: Text("$actor",style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 15
              ),),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text("Characters:",style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left:36.0,right: 36.0),
              child: Text("$characters"
                ,style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 15
                ),),
            ),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text("Plot:",style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left:36.0,right: 36.0),
              child: Text("$overview"
                ,style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 15
                ),),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: TextButton(
                  onPressed: ()=>GetMovieName(),
                  child: Text("Guess",style: GoogleFonts.montserrat(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                ),
              ),
            ),
          ],
        ),
      ):Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.white, size: 50),),
    );
  }
  Widget GetMovieName() {
    var EnteredMovieName=new TextEditingController();
    showDialog(

      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 200,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 20),
                  child: TextFormField(
                    controller: EnteredMovieName,
                    decoration: InputDecoration(
                        labelText: 'Enter Movie Name',
                        hintStyle: GoogleFonts.oswald(fontSize: 20,color: Color.fromARGB(255, 82, 113, 255)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:35.0,left: 10,right: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {
                        if(EnteredMovieName.text.toLowerCase()==moviename.toLowerCase())
                        {
                          setState(() {
                            correctanswer=true;
                          });

                        }
                        else
                        {
                          setState(() {
                            wronganswer=true;
                          });
                        }
                        //
                        Navigator.of(context).pop(); // Close the dialog
                        ShowAnimation();
                      },
                      child: Text("OK",style: GoogleFonts.montserrat(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.white),),
                    ),
                  ),
                ),
              ],

            ),
          ),
          );
      },
    );

    // Return an empty container or null as showDialog will handle the UI
    return Container();
  }

  Widget ShowAnimation()
  {
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        actions: [
          correctanswer?Container(
            child: Lottie.asset("lib/assets/correctanswer.json",height: 300,width: 300)):(
      wronganswer?Container(
      child: Lottie.asset("lib/assets/wronganswer.json",height: 300,width: 300)
      ):Row()
          )
        ],
      );
    });
    return Container();
  }
Future<void> getGuessingMovie()
async {
  String url="http://$ipaddress/guessinggame";
  var Data=await GetData(Uri.parse(url));
  DecodedObjects=jsonDecode(Data);
  setState(() {
    gotMovieDetails=true;
    print(DecodedObjects);
    setDetails();
  });
}

}
