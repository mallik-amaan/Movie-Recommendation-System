import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mrs/Screens/homescreen.dart';
import 'package:mrs/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var email=new TextEditingController();
  var password=new TextEditingController();
  var name=new TextEditingController();
  var con_password=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 39, 40, 41),
    title: Text("SignUp",style: GoogleFonts.montserrat(color: Color.fromARGB(255, 82, 113, 255),fontSize: 40,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
    leading: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
    child: Image.asset('lib/assets/logo.png'),
    ),
    ),

    ),

      backgroundColor: Color.fromARGB(255, 39, 40, 41),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding:EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 35.0,right: 35.0,top: 20),
                  child: TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      labelText: 'Name',
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
                    controller: email,
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
                    controller: password,
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
                  padding: const EdgeInsets.only(left: 35.0,right: 35.0,top: 20),
                  child: TextFormField(
                    controller: con_password,
                    decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: GoogleFonts.montserrat(fontSize: 20,color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )
                    ),
                  ),
                ),
               Padding(
                 padding: const EdgeInsets.all(25.0),
                 child: Container(
                   width: MediaQuery.of(context).size.width*0.8,
                   decoration: BoxDecoration(
                     color: Colors.green,
                     borderRadius: BorderRadius.circular(10)
                   ),
                   child: TextButton(onPressed: (){
                     if(name.text.isEmpty || password.text.isEmpty || email.text.isEmpty)
                       {
                         print("error");
                       }
                     else if(password.text!=con_password.text)
                       {
                          print("error");
                       }
                     else
                     {
                       createUserAccount(email.text, password.text);
                     }
                   }, child: Text('SignUp',style: GoogleFonts.montserrat(
                     fontSize: 20,
                     color: Colors.white,
                   ),)),
                 ),
               )
              ],
            ),
          ),
        ),
      ),


    );
  }
  void createUserAccount(String email, String password) async {
    FirebaseAuth mAuth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await mAuth.createUserWithEmailAndPassword(email: email, password: password);
      String? uid = userCredential.user?.uid;

      if (uid != null) {
        final CollectionReference users = FirebaseFirestore.instance.collection('Users');
        Map<String, dynamic> newdata = {
          "Name": name.text,
        };
        await users.doc(uid).set(newdata);
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        // Handle error: UID is null
      }
    } on FirebaseAuthException catch (e) {
      // Handle error: Firebase authentication exception
    }
  }

}
