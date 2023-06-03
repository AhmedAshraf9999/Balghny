import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:balghny/model/post.dart';
import 'package:balghny/view/screen/home_page.dart';
import 'package:balghny/view/screen/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

//import 'dart:io';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  String img_url = '';
  var myName = "";
  var myPhotoUrl; // add this variable to store the user's photo URL

  int currentTab = 0;
  final List<Widget> screens = [
    ProfileScreen(),
    HomePage(),
    PostListScreen(),
    HomePage(),
  ];

  int postCount = 1;

  void addPostte() {
    setState(() {
      postCount++;
      print('Posts: $postCount');
    });
  }

  void initState() {
    AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
              channelKey: "Basic_channel",
              channelName: "Basic Notification",
              channelDescription: "Notification channel For Basic tests")
        ],
        debug: true);
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
  }

  triggerNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 10,
          channelKey: "Basic_channel",
          title: "simple Notification",
          body: "This is a basic notification"),
    );
  }

/*
AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: "Basic_channel",
            channelName: "Basic Notification",
            channelDescription: "Notification channel For Basic tests")
      ],
      debug: true);
    void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
  }

  triggerNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(id: 10, channelKey: "Basic_channel",
      title: "simple Notification", body: "This is a basic notification"),
    );
  }
*/

  Widget currentScreen = PostListScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          'Community',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
            return Container(
              margin: EdgeInsets.only(bottom: 20),
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.grey[200],
                    thickness: 20,
                  );
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
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        child: CircleAvatar(
                                          //post.photourl != null &&
                                          backgroundImage: post
                                                  .photourl.isNotEmpty
                                              ? NetworkImage(post.photourl)
                                              : NetworkImage(
                                                  'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y'),
                                        )),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(right: 140, top: 10),
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
                                            style:
                                                TextStyle(color: Colors.grey))
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: IconButton(
                                        onPressed: () {
                                          addPostte();
                                          triggerNotification();
                                        },
                                        icon: Icon(
                                          Icons.delete_forever,
                                          color: Colors.red,
                                        )))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Stack(
                                children: [
                                  Positioned(
                                    // top: 0,
                                    //  left: 0,
                                    child: Text("Address: ",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 60),
                                    child: Text(
                                      "${post.Address}",
                                      // maxLines: 2,
                                      //   overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              /*  Row(children: [
                                Expanded(
                                  flex: 1,
                                  child: Text("Address: ",

                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Expanded(flex: 4,
                                  child: Text(
                                    "${post.Address}",
                                   maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],),*/
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Text(post.post_body),
                            ),
                            Center(
                              child: Container(
                                width: 200,
                                child: Image.network(
                                  post.photocate,
                                  fit: BoxFit.cover,
                                  height: 100,
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                child: ElevatedButton(
                                    onPressed: () async {
                                      _shareContent(context);
                                      print("object");
                                      addPostte();
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
                    color: currentTab == 2 ? Colors.green : Colors.black),
              ),
              SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("notification");
                },
                icon: Stack(
                  children: [
                    Icon(Icons.notifications),
                    postCount > 0
                        ? Positioned(
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Text(
                                postCount.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
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
