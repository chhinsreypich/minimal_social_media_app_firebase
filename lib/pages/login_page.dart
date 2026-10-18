// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimal_social_media_app_firebase/components/my_button.dart';
import 'package:minimal_social_media_app_firebase/components/my_textfield.dart';
import 'package:minimal_social_media_app_firebase/helper/helper_function.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controller
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();


  // login method
  void login() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // try sign in 
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // pop loading circle
      if(context.mounted) Navigator.pop(context); 
    } on FirebaseAuthException catch (e){
      //pop loading circle
      Navigator.pop(context);
      displayMessageToUser(e.code, context);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // logo

            children: [
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),

              SizedBox(height: 20),

              // app name
              const Text(
                "M I N I M A L",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),

              SizedBox(height: 20),

              // email textfield
              MyTextField(
                hintText: "Email",
                obscureText: false,
                controller: emailController,
              ),

              SizedBox(height: 20),

              // password textfield
              MyTextField(
                hintText: "Password",
                obscureText: true,
                controller: passwordController,
              ),

              SizedBox(height: 20),

              // forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),

              // sign in button
              MyButton(
                text: "Login",
                onTap: login,
              ),

              SizedBox(height: 20),

              // don't have an account? register here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  GestureDetector(
                    child: Text(
                      "Register Here",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: widget.onTap,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
