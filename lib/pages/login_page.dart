import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key,required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    //loading circle
    showDialog(
        context: context,
        builder: (context){
          return Center(child: CircularProgressIndicator());
        },
    );

    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
    );
    Navigator.of(context).pop();
  }
  @override
  void dispose() {
      _emailController.dispose();
      _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.android,size: 100,),
                //Hello again!
                SizedBox(height: 30,),
                Text(
                  "Hello Again!",
                  style: GoogleFonts.bebasNeue(fontSize: 50),
                ),
                SizedBox(height: 10,),
               //welcome
                Text(
                  "Welcome back, you've been missed!",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 35,),
                //Email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left:20.0),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                      ),
                    ),

                  ),
                ),
                //password Field
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left:20.0),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                      ),
                    ),

                  ),
                ),
                SizedBox(height: 10,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(
                                builder: (context){return ForgotPasswordPage();
                                },
                              ),
                          );
                      },
                        child: Text(
                            "Forgot Password?",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                        ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10,),
                //sign in button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: signIn,
                    child: Container(
                      padding: EdgeInsets.all(25),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Center(
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                      )),
                    ),
                  ),
                ),
                SizedBox(height: 20,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Not a member? ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(onTap: widget.showRegisterPage,
                          child: Text(
                            "Register now",
                            style: TextStyle(color: Colors.blue,
                              fontWeight: FontWeight.bold,
                          ),
                          ),
                        ),
                      ],
                    ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
