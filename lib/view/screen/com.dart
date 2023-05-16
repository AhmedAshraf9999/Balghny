import 'package:balghny/model/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class PostListScreen extends StatefulWidget {
  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  String img_url = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post List'),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                .reversed
                .toList();
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int index) {
                final post = posts[index];
                dynamic x = post.photocate;
                void _shareContent(BuildContext context) async {
                  final String title = 'Check out this photo!';
                  final String description = post.post_body;
                  final String imageUrl = post.photocate;
                  final String shareText =
                      '$title\n\n$description\n\n$imageUrl';
                  await WcFlutterShare.share(
                    text: shareText,
                    subject: title,
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
                                child: Text("Shere",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)))
                          ],
                        ),
                        leading: CircleAvatar(
                            backgroundImage: NetworkImage(post.photourl)),
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
