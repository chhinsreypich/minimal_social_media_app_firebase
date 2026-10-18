import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // drawer header
              DrawerHeader(
                child: Icon(
                  Icons.favorite,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),

              const SizedBox(height: 25),

              // home tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: Text(
                    " H O M E",
                  ),
                  onTap: () {
                    // this is already the home screen so just pop drawer
                    Navigator.pop(context);
                  },
                ),
              ),

              const SizedBox(height: 25),

              // profile tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: Text(
                    "P R O F I L E",
                  ),
                  onTap: () {
                    // this is already the home screen so just pop drawer
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/profile_page');
                  },
                ),
              ),

              const SizedBox(height: 25),

              // user tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: Text("U S E R S "),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/users_page');
                  },
                ),
              ),

              // log out tile
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: Text("L O G O U T "),
              onTap: () {
                Navigator.pop(context);
                // log out
                logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
