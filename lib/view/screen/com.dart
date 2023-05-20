import 'package:balghny/model/post.dart';
import 'package:balghny/view/screen/home_page.dart';
import 'package:balghny/view/screen/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';
//import 'dart:io';

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


  int currentTab = 0;
  final List<Widget> screens = [
    ProfileScreen(),
    HomePage(),
    PostListScreen(),
    HomePage(),
  ];

  Widget currentScreen =  PostListScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Community',style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .orderBy('time', descending: true)
              .snapshots(),
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
                .toList();
            return Container(margin: EdgeInsets.only(bottom: 20),
              child: ListView.separated(

                separatorBuilder: (context,index){
                  return Divider(color: Colors.grey[200],thickness: 20,);
                },
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) {
                  final post = posts[index];
                  ////////
                  void _shareContent(BuildContext context) async {
                    final String description = post.post_body;
                    final String imageUrl = post.photocate;
                    dynamic shareText = '$description\n\n$imageUrl';
                    await WcFlutterShare.share(
                      text: shareText,
                      subject: shareText,
                      mimeType: 'text/plain',
                      sharePopupTitle: '',
                    );
                  }
                  return Wrap(
                    children: [
                      Container(
                        padding: EdgeInsets.all(7),
                      //   height: 250,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50.0),
                                        child:

                                        CircleAvatar(
                                          backgroundImage: post.photourl != null && post.photourl!.isNotEmpty
                                              ? NetworkImage(post.photourl!)
                                              : NetworkImage('https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y'),
                                        )

                                        // Image.asset("assets/images/my.jpg",width: 35,height: 35,) ,
                                        ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    margin: EdgeInsets.only(right: 140,top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          post.username,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(post.time.toString(),
                                            style: TextStyle(color: Colors.grey))
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.delete_forever,color: Colors.green,)))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Text(post.post_body),
                            ),
                            Center(
                              child: Container(
                                width: 200,
                                child: Image.network(post.photocate,fit: BoxFit.cover,height: 100,),
                              ),
                            ),
                            Center(
                              child: Container(
                                child: ElevatedButton(
                                    onPressed: () async {
                                      _shareContent(context);
                                      print("object");
                                    },
                                    child: Text("Facebook Share",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold))),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.home),
        onPressed: () {
          Navigator.of(context).pushNamed("home");
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        color: Colors.white, // Set the background color of the bottom bar
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              //Icon("assets/icons/emergency-call.png")

              IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('Emergency');
                },
                icon: Icon(Icons.help_outlined,
                    color: currentTab == 1
                        ? const Color(0xFF1ABC00)
                        : Colors.black),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("post");
                },
                icon: Icon(Icons.groups,
                    color: currentTab == 2
                        ? Colors.green
                        : Colors.black),
              ),
              SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: () {
                   Navigator.of(context).pushNamed("notification");



                },
                icon: Icon(Icons.notifications_active,
                    color: currentTab == 4
                        ? Colors.green
                        : Colors.black),
              ),

              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("profile");

                },
                icon: Icon(Icons.person,
                    color: currentTab == 5
                        ? Colors.green
                        : Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
