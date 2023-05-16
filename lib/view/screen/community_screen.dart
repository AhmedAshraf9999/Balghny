/*
import 'dart:io';

import 'package:balghny/model/post.dart';
import 'package:balghny/view/screen/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';


class Community extends StatefulWidget {
  final List<Post> posts;
  const Community({Key? key,required this.posts}) : super(key: key);

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {

  int currentTab = 0;
  final List<Widget> screens = [
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage(),
  ];

//  Widget currentScreen =  Community(posts: posts);
/////////
  //var profileImageUrl;
 // var  username;

  @override
  void initState() {
    super.initState();
   // _fetch();
    FirebaseAppCheck.instance
        .activate(webRecaptchaSiteKey: 'RECAPTCHA_SITE_KEY');
  }

 /* Future<void> _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        setState(() {
          username = ds.data()!["name"] ?? "";
           profileImageUrl = ds.data()!["photoUrl"]; // get the user's photo URL

        });

        print(username);
        print(username);


      }).catchError((e) {
        print(e);
      });
    }
  }*/
  @override
  Widget build(BuildContext context) {
    return

     /* ListView.builder(
      itemCount: posts.length,
      itemBuilder: (BuildContext context, int index) {
        final post = posts[index];
        return Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage(post.profileImageUrl),
                    radius: 20.0,
                  ),
                  SizedBox(width: 7.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(post.username, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0)),
                      SizedBox(height: 5.0),
                      Text(post.time)
                    ],
                  ),
                ],
              ),

              SizedBox(height: 20.0),

              Text(post.content, style: TextStyle(fontSize: 15.0)),

              SizedBox(height: 10.0),


            ],
          ),
        );
      },
    );*/

    Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Our Community"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [


                    Data(),



              ],
            ),
          ),
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
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.dark_mode_rounded,
                    color: currentTab == 1
                        ? const Color(0xFF1ABC00)
                        : Colors.black),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("scan");
                },
                icon: Icon(Icons.translate_outlined,
                    color: currentTab == 2
                        ? Colors.green
                        : Colors.black),
              ),
              SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: () {
                  // Navigator.of(context).pushNamed("noti");

                 /* Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationWidget(notification:  null),
                    ),
                  );*/
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

class Data extends StatelessWidget {
  const Data({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        child: Column(
          children: [
            Container(height: 600,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) {
                  final post = posts[index];
                  return Container(
                    color: Colors.grey[200],
                   // padding: EdgeInsets.all(15.0),
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: AssetImage(post.profileImageUrl),
                              radius: 20.0,
                            ),
                            SizedBox(width: 7.0),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(post.username, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0)),
                                SizedBox(height: 5.0),
                                Text(post.time)
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: 10.0),

                         Text(post.description, style: TextStyle(fontSize: 15.0)),

                        SizedBox(height: 5.0),
                        Container(width: 200,height: 150,
                        child: Image.asset(post.cateImageUrl,fit: BoxFit.fill,),),

                        SizedBox(height: 5.0),
                        ElevatedButton(onPressed: () async {
                          ByteData imagebyte = await rootBundle.load(post.cateImageUrl);
                          final temp = await getTemporaryDirectory();
                          final path = '${temp.path}/${post.cateImageUrl}';
                          File(path).writeAsBytesSync(imagebyte.buffer.asUint8List());
                         await Share.shareFiles([path], text: post.description);
                          //  await   Share.shareXFiles([XFile(path)], text: post.description);
                        },
                  child: Text(post.share,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)))


                      ],
                    ),
                  );
                },
              ),
            ),

          ],
        ),
      ),



    );
  }
}
*/
