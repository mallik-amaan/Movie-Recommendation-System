import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mrs/Screens/Signup.dart';

import '../Navigation.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var con_password=new TextEditingController();
  var email=new TextEditingController();
  var isLoggingin=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          child: Image.asset('lib/assets/logo.png'),
        ),
        backgroundColor: Color.fromARGB(255, 39, 40, 41),
        title: Text("MRS",style: GoogleFonts.montserrat(color: Color.fromARGB(255, 82, 113, 255),fontSize: 40,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
      ),
        backgroundColor: Color.fromARGB(255, 39, 40, 41),

        body:SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // decoration:  BoxDecoration(
            //   image: DecorationImage(
            //     image: NetworkImage("https://image.tmdb.org/t/p/w300//8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg",scale: 0.01
            //     )
            //   )
            // ),
            child: Padding(
              padding: EdgeInsets.only(top:164),
              child: Container(
                decoration: BoxDecoration(
                  // image: DecorationImage(
                  //   image: NetworkImage("https://image.tmdb.org/t/p/w300//8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg")
                  // )
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 35.0,right: 35.0,top: 20),
                      child: TextFormField(
                        controller: email,
                        style: GoogleFonts.montserrat(
                            fontSize: 20,
                            color: Colors.white
                        ),

                        decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: GoogleFonts.montserrat(fontSize: 20,color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 35.0,right: 35.0,top: 20),
                      child: TextFormField(
                        obscureText: true,
                        obscuringCharacter: '*',
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          color: Colors.white
                        ),
                        controller: con_password,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: GoogleFonts.montserrat(fontSize: 20,color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(onPressed: (){
                          setState(() {
                            isLoggingin=true;
                          });
                         signinwithemail(email.text, con_password.text);
                        },
                            child:!isLoggingin?Text(
                              'Login',
                              style: GoogleFonts.oswald(
                                fontSize: 20,
                                color: Color.fromARGB(255, 82, 113, 255),
          
                              ),
                            ):LoadingAnimationWidget.hexagonDots(color: Color.fromARGB(255, 82, 113, 255), size: 20)),
                      ),
                    ),
          
                    Padding(
                      padding: const EdgeInsets.only(top:45,bottom: 0),
                      child: Container(
                        height: 295,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 82, 113, 255),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40),
                          )
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:20.0),
                              child: Text('Sign Up',
                                style: GoogleFonts.oswald(
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width*0.25,
                                  height: 5,
                                  color: Colors.white,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.25,
                                  height: 5,
                                  color: Colors.white,
                                )
                              ],
                            ),
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                width: 300,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: GestureDetector(
                                  onTap:(){
                                    createwithGoogle();
          
                                  } ,
                                  child: ListTile(
                                    leading: Container(height: 30,width: 30,child: Image.asset("lib/assets/google.png"),),
                                    title: Text('Signup with Google',
                                      style: GoogleFonts.oswald(
                                          fontSize: 20,
                                          color: Colors.black
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 300,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=>SignUp()));
                                  },
                                  child: ListTile(
                                    leading: Container(height: 30,width: 30,child: Image.asset("lib/assets/mail.png"),),
                                    title: Text('Signup with Email',
                                      style: GoogleFonts.oswald(
                                          fontSize: 20,
                                          color: Colors.black
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
          
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
  void signinwithemail(String email,String password)
  {
    var mAuth=FirebaseAuth.instance;
    mAuth.signInWithEmailAndPassword(email: email, password: password).then((value)
    {
      setState(() {
        isLoggingin=false;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Navigation()));
    }).onError((error, stackTrace){
      setState(() {
        isLoggingin=false;
      });
      print(error);
    });
  }

  void createwithGoogle() async
  {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    FirebaseAuth mAuth=FirebaseAuth.instance;
    mAuth.signInWithCredential(credential);
  }

}