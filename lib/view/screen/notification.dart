import 'package:balghny/view/screen/com.dart';
import 'package:balghny/view/screen/home_page.dart';
import 'package:balghny/view/screen/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

import '../../model/post.dart';

class notification extends StatefulWidget {
  const notification({super.key});

  @override
  State<notification> createState() => _notificationState();
}

class _notificationState extends State<notification> {
  int currentTab = 0;
  final List<Widget> screens = [
    ProfileScreen(),
    HomePage(),
    PostListScreen(),
    HomePage(),
  ];

  String img_url = '';
  var myName = "";
  var myPhotoUrl; // add this variable to store the user's photo URL

  Widget currentScreen = notification();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey[100],
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Container(
                  height: 50,
                  child: Center(
                      child: Text(
                        "Notification",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('posts')
                        .orderBy('time', descending: true)
                        .snapshots(),
                    builder:
                        (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
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
                              (doc) =>
                              Post.fromJson(doc.data()! as Map<String,
                                  dynamic>))
                          .toList();
                      return Container(

                         margin: EdgeInsets.only(bottom: 20),
                        child: ListView.separated(

                          separatorBuilder: (context, index) {
                            return Divider(
                              color: Colors.grey[200], thickness: 1,);
                          },
                          itemCount: posts.length,
                          itemBuilder: (BuildContext context, int index) {
                            final post = posts[index];

                            return InkWell(
                              onTap: ()=> Navigator.of(context).pushNamed("post"),
                              child: Container(
                                padding: EdgeInsets.only(top: 10),
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      Container(
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
                                      SizedBox(width: 10),
                                      Container(
                                        //  margin: EdgeInsets.only(right: 140),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Row(
                                              children: [
                                                Text( post.username,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15),),
                                                SizedBox(width: 10),
                                                Text("Upload Post In Community")
                                              ],
                                            ),
                                            Text(post.time.toString(), style: TextStyle(
                                                color: Colors.grey))
                                          ],),
                                      ),
                                    ],),


                                  ],),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),

                  /* PageView(
                children: [
                  listView(),
                ],
              ),*/
                )
              ],
            ),
          )),

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
                    color: currentTab == 2 ? Colors.green : Colors.black),
              ),
              SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: () {
                  // Navigator.of(context).pushNamed("noti");
                },
                icon: Icon(Icons.notifications_active,
                    color: currentTab == 4 ? Colors.green : Colors.black),
              ),

              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("profile");
                },
                icon: Icon(Icons.person,
                    color: currentTab == 5 ? Colors.green : Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


