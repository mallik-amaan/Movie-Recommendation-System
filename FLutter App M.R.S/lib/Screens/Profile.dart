import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrs/Screens/GuessTheMovie.dart';
import 'package:mrs/Screens/PlotSearch.dart';
class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 39, 40, 41),
          title: Text("Account",style: GoogleFonts.montserrat(color: Color.fromARGB(255, 82, 113, 255),fontSize: 40,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Image.asset('lib/assets/logo.png'),
            ),
          ),

        ),

        backgroundColor: Color.fromARGB(255, 39, 40, 41),
      body:Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("lib/assets/peakpx.png"),
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100)
                    ),
                  ),
                  Text('Amaan',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),)
                ],
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap:()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>GuessTheMovie()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top:8.0,bottom: 8.0,left: 16),
                    child: Container(
                        child: Text('Guess The Movie',style: GoogleFonts.montserrat(fontSize: 20,color:Colors.white,fontWeight: FontWeight.bold),)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:8.0,bottom: 8.0,right: 16),
                  child: Icon(Icons.question_mark_outlined,color:  Color.fromARGB(255, 82, 113, 255),),
                )
              ],
            ), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:8.0,bottom: 8.0,left: 16),
                  child: Container(
                      child: Text('Change Password',style: GoogleFonts.montserrat(fontSize: 20,color:Colors.white,fontWeight: FontWeight.bold),)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:8.0,bottom: 8.0,right: 16),
                  child: Icon(Icons.password,color:  Color.fromARGB(255, 82, 113, 255),),
                )
              ],
            ), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: ()
                  {
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>PlotSearch()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top:8.0,bottom: 8.0,left: 16),
                    child: Container(
                        child: Text('Search with Plot',style: GoogleFonts.montserrat(fontSize: 20,color:Colors.white,fontWeight: FontWeight.bold),)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:8.0,bottom: 8.0,right: 16),
                  child: Icon(Icons.search_outlined,color:  Color.fromARGB(255, 82, 113, 255),),
                )
              ],
            ), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:8.0,bottom: 8.0,left: 16),
                  child: Container(
                      child: Text('Logout',style: GoogleFonts.montserrat(fontSize: 20,color:Colors.white,fontWeight: FontWeight.bold))),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:8.0,bottom: 8.0,right: 16),
                  child: Icon(Icons.logout,color:  Color.fromARGB(255, 82, 113, 255),),
                )
              ],
            ),
                      ],
        ),
      )
    );
  }
}
