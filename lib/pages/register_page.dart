// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimal_social_media_app_firebase/components/my_button.dart';
import 'package:minimal_social_media_app_firebase/components/my_textfield.dart';
import 'package:minimal_social_media_app_firebase/helper/helper_function.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text controller
  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController comfirmPwController = TextEditingController();

  // register method
  void registerUser() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // make sure passwords match
    if (passwordController.text != comfirmPwController.text) {
      // pop loading circle
      Navigator.pop(context);

      // show error message to user
      displayMessageToUser("Password don't match!!", context);
    }
    // if password do match
    else {
      // try creating the user
      try {
        // create the user
        UserCredential? userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // create a user document and add to firestore
        createUserDocument(userCredential);

        // pop loading circle
        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        // pop loading circle
        Navigator.pop(context);

        // display error message to user
        displayMessageToUser(e.code, context);
      }
    }
  }

  // create a user document and collect them in firestore
  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'username': usernameController.text,
      });
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

              // username textfield
              MyTextField(
                hintText: "Username",
                obscureText: false,
                controller: usernameController,
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

              // Comfirm Password textfield
              MyTextField(
                hintText: "Comfirm Password",
                obscureText: true,
                controller: comfirmPwController,
              ),

              SizedBox(height: 20),

              // sign in button
              MyButton(
                text: "Register",
                onTap: registerUser,
              ),

              SizedBox(height: 20),

              // don't have an account? register here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Login Here",
                      style: TextStyle(
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
    );
  }
}
