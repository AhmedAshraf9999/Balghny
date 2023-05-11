import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Post2 extends StatefulWidget {
  const Post2({Key? key, required String profileImageUrl, required String username, required String time, required String description, required String cateImageUrl, required String share}) : super(key: key);

  @override
  State<Post2> createState() => _Post2State();
}

class _Post2State extends State<Post2> {

  late final String profileImageUrl;
  late final String username;
  late final String time;
  late final String description;
  late final String cateImageUrl;
  late final String share;

  String myName = "";
  String myEmail = "";
  String myPhotoUrl = "";
  String myPhoneNumber = "";
  String myCity = "" ;

  Future<void> _fetchUserData() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {

        setState(() {
          myName = ds.data()!['name'] ?? '';
          myEmail = ds.data()!['email'] ?? '';
          myPhotoUrl = ds.data()!['photoUrl'] ?? '';
          myPhoneNumber = ds.data()!['phoneNumber'] ?? '';
          myCity = ds.data()!['city'] ?? '';

        });
      }).catchError((e) {
        print(e);
      });
    }
  }

  List<Post2> posts = [
  new Post2(
  profileImageUrl: 'myPhotoUrl',
  username: 'myName',
  time: '5h',
  description:
  'Hey guys whats up, This is Sam Wilson. I am currently in singapore. Came here to make some amazing memories',
  cateImageUrl: 'assets/images/my.jpg',
  share: 'Share',

  ),
  new Post2(
  profileImageUrl: 'assets/images/my.jpg',
  username: 'Sam Wilson',
  time: '5h',
  description:
  'Hey guys whats up, This is Sam Wilson. I am currently in singapore. Came here to make some amazing memories',
  cateImageUrl: 'assets/images/my.jpg',
  share: 'Share',),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [

      ],),
    );
  }
}
