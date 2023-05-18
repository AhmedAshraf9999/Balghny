import 'package:balghny/model/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class PostListScreen extends StatefulWidget {
  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  String img_url = '';
  var myName = "";
  var myPhotoUrl; // add this variable to store the user's photo URL
  
  @override
  void initState() {
    super.initState();
  }
Future<void> _fetch() async {
  final firebaseUser = await FirebaseAuth.instance.currentUser!;
  if (firebaseUser != null) {
    await FirebaseFirestore.instance.collection('users')
      .doc(firebaseUser.uid)
      .get()
      .then((ds) {
        setState(() {
          myName = ds.data()!["name"] ?? "";
          myPhotoUrl = ds.data()!["photoUrl"]; // get the user's photo URL
        });        
        print(myName);
        print(myPhotoUrl);
      }).catchError((e) {
        print(e);
      });
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post List'),
      ),
      body: SafeArea(child: StreamBuilder<QuerySnapshot>(
        stream:
       FirebaseFirestore.instance.collection('posts').orderBy('time' ,descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
            // Build the list of posts using the retrieved data
            final List<Post> posts = snapshot.data!.docs
                .map(
                    (doc) => Post.fromJson(doc.data()! as Map<String, dynamic>))
                .toList()
                ;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int index) {
                final post = posts[index];
                void _shareContent(BuildContext context) async {
                  final String description = post.post_body;
                  final String imageUrl = post.photocate;
                  dynamic shareText ='$description\n\n$imageUrl';
                  await WcFlutterShare.share(
                    text: shareText,
                    subject: shareText,
                    mimeType: 'text/plain',
                    sharePopupTitle: '',
                  );
                }
                return Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                      ),
                      child: ListTile(
                        title: Text(post.username),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(post.post_body),
                            SizedBox(
                              height: 10,
                            ),
                            //Text(post.photocate),
                            Image.network(post.photocate),
                            ElevatedButton(
                                onPressed: () async {
                                  _shareContent(context);
                                  print("object");
                                },
                                child: Text("Share",
                                    style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)))
                          ],
                        ),
                        leading: CircleAvatar(
                            backgroundImage: NetworkImage(post.photourl ?? 'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y')),
                        trailing: Text(post.time.toString()),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
