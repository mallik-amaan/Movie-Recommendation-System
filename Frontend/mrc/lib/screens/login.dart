import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
       
      body:Center(
        child: Padding(
          padding: EdgeInsets.only(top:MediaQuery.sizeOf(context).height*0.1
          ,bottom:MediaQuery.sizeOf(context).height*0.1),
          child: Container(
            width: MediaQuery.of(context).size.width*0.6,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
              image:const DecorationImage(image:AssetImage('web/assets/login.png'))
            ),
            child: Padding(
              padding: EdgeInsets.only(top:180),
              child: Column(
                children: [
                 Container(
                    width: 300,
                    decoration:BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                    child:Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(fontSize: 20),
                          
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Container(
                      width: 300,
                      decoration:BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                  
                      ),
                      child:Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(fontSize: 20),
                            
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    
                    decoration: BoxDecoration(
                    color: Colors.black12,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(onPressed: (){}, 
                    child:Text(
                      'Login',
                      style: GoogleFonts.oswald(
                        fontSize: 20,
                        color: Colors.red,
                        
                      ),
                    )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.25,
                        height: 2,
                        color: Colors.red,
                      ),
                      Container(
                    width: MediaQuery.of(context).size.width*0.25,
                    height: 2,
                    color: Colors.red,
                  )
                    ],
                  )
                ,Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Sign Up',
                  style: GoogleFonts.oswald(
                    fontSize: 20,
                    color: Colors.white,
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
                    child: ListTile(
                      title: Text('Signup with Google',
                      style: GoogleFonts.oswald(
                        fontSize: 20,
                        color: Colors.black
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
                    child: ListTile(
                      title: Text('Signup with Email',
                      style: GoogleFonts.oswald(
                        fontSize: 20,
                        color: Colors.black
                      ),
                      ),
                    ),
                                  ),
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}