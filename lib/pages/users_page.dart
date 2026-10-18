import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minimal_social_media_app_firebase/components/my_back_button.dart';
import 'package:minimal_social_media_app_firebase/components/my_list_tile.dart';
import 'package:minimal_social_media_app_firebase/helper/helper_function.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context, snapshot) {
          // any error
          if (snapshot.hasError) {
            displayMessageToUser("Something went wrong", context);
          }

          // show loading circle
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data == null) {
            return const Text('No Data');
          }

          // get all users
          final users = snapshot.data!.docs;

          return Column(
            children: [
              // back button
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  top: 50,
                ),
                child: Row(
                  children: [
                    MyBackButton(),
                  ],
                ),
              ),

              // list of users in the app
              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  padding:
                      const EdgeInsets.only(top: 10, left: 10, right: 10),
                  itemBuilder: (context, index) {
                    // get individual user
                    final user = users[index];

                    // get data from user
                    final username = user['username'];
                    final userEmail = user['email'];

                    return MyListTile(
                      title: username,
                      subtitle: userEmail,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
