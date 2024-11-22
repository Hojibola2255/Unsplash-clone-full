import 'package:flutter/material.dart';
import 'package:ngdemo16/pages/sign_up_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  _callSignUpPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return SignUpPage();
    }));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80),
                Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 40),
        
                // Email Field
                TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.white54, fontSize: 12),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                
                SizedBox(height: 20),
                
                TextField(
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.white54, fontSize: 12),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                ),
        
                SizedBox(height: 20,),
                MaterialButton(
                  onPressed: (){
                    _callSignUpPage();
                  },
                color: Colors.white,
                  height: 40,
                  minWidth: double.infinity,
                  child: Text("Log In", style: TextStyle(color: Colors.black),),
                ),
        
                Center(child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("Forgot your password?", style: TextStyle(color: Colors.white, fontSize: 12),),
                )),
        
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?", style: TextStyle(color: Colors.white),),

                      GestureDetector(
                        onTap: (){
                          _callSignUpPage();
                        },
                          child: Text("  Join", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
