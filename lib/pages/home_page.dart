import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:minimal_social_media_app_firebase/components/my_drawer.dart";
import "package:minimal_social_media_app_firebase/components/my_post_button.dart";
import "package:minimal_social_media_app_firebase/components/my_list_tile.dart";
import "package:minimal_social_media_app_firebase/components/my_textfield.dart";
import "package:minimal_social_media_app_firebase/database/firestore.dart";

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // firestore database access
  final FirestoreDatabase database = FirestoreDatabase();

  // text controller
  TextEditingController newPostController = TextEditingController();

  // post message
  void postMessage() {
    // only post if the text field is not empty
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }

    // clear the controller after posting
    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Center(
          child: const Text("W A L L"),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          // textfield box for user to type
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Row(
              children: [
                // text field
                Expanded(
                  child: MyTextField(
                    hintText: "Say something..",
                    obscureText: false,
                    controller: newPostController,
                  ),
                ),

                // post button
                PostButton(
                  onTap: postMessage,
                ),
              ],
            ),
          ),

          // Posts list
          StreamBuilder(
              stream: database.getPostsStream(),
              builder: (context, snapshot) {
                // showing loading circle
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // get all posts
                final posts = snapshot.data!.docs;

                // no data?
                if (snapshot.data == null || posts.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(25.0),
                      child: Text(
                        "No posts yet. Be the first to post!",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                }

                // return as a list
                return Expanded(
                  child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        // get each individual post
                        final post = posts[index];

                        // get the data from each post
                        String message = post['PostMessage'];
                        String userEmail = post['UserEmail'];
                        String timestamp =
                            post['Timestamp'].toDate().toString();

                        // return as a list tile
                        return MyListTile(
                          title: message,
                          subtitle: userEmail,
                        );
                      }),
                );
              })
        ],
      ),
    );
  }
}
