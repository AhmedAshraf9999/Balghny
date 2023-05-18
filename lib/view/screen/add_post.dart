import 'dart:io';
import 'package:balghny/model/post.dart';
import 'package:balghny/view/auth.dart';
import 'package:balghny/view/screen/com.dart';
import 'package:balghny/view/screen/community_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Add_post extends StatefulWidget {


final File img;
  const Add_post({Key? key,required this.img}) : super(key: key);

  @override
  State<Add_post> createState() => _Add_postState();
}

class _Add_postState extends State<Add_post> {
  
  TextEditingController addpost = TextEditingController();
  bool isloading =false ;
  var img_url;
  
Future<void> _saveUserDataToFirestore(String? post_body) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String? myPhotoUrl = FirebaseAuth.instance.currentUser?.photoURL;
  Reference storageRef = FirebaseStorage.instance.ref().child("images_cate/${DateTime.now().toString()}");
  UploadTask uploadTask = storageRef.putFile(widget.img);
  TaskSnapshot snapshot = await uploadTask;
  String imageUrl = await snapshot.ref.getDownloadURL();
  //final String? userName = FirebaseAuth.instance.currentUser?.displayName;

  // Retrieve additional data from the 'users' collection
  DocumentSnapshot userSnapshot = await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.uid.toString()).get();

  if (userSnapshot.exists) {
    // User document exists in the 'users' collection
    final userData = userSnapshot.data() as Map<String, dynamic>;
    final String? username = userData['name'];
    final String? userPhotoUrl = userData['photourl'];

    // Add document to 'posts' collection
    DocumentReference postDocRef = await firestore.collection('posts').add(
      {
        'post_body': post_body,
        'time': DateTime.now(),
        'username': username,
        'photourl': userPhotoUrl,
        'imageUrl': imageUrl,
      }
    );
    print('Post added to Firestore.');
  } else {
    // User document does not exist in the 'users' collection
    print('User document not found in the users collection. Cannot add post.');
}
}
Future<void> _fetchUserData() async {
  final firebaseUser = await FirebaseAuth.instance.currentUser!;
  if (firebaseUser != null) {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(firebaseUser.uid)
        .get()
        .then((ds) {
          
      setState(() {
        img_url = ds.data()!['imageurl'] ?? '';
      });
    }).catchError((e) {
      print(e);
    });
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text('Create New Post'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50,),
              Center(
                child: Stack(
                  children: [

                    Center(child: Image.file(widget.img,width: 200, height: 200, fit:BoxFit.fill),

                 //       Image.asset("assets/images/my.jpg",width: 150, height: 150, fit:BoxFit.fill,)
                    )

                   /* Container(
                        margin: EdgeInsets.only(left: 45,top: 70),
                        child: IconButton(onPressed: (){},
                        icon: Icon(Icons.add,color: Colors.green),)),
                    Container(
                        margin: EdgeInsets.only(left: 33,top: 40),
                        child: Image.asset("assets/images/Add photo.png")),
                    Image.asset("assets/images/Rectangle 1027.png"),*/
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Column(
                children: [
                  Row(
                    children: [
                       Container(
                           margin: EdgeInsets.only(left: 20),
                           child: Text("Title",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                    ],
                  ),
                  SizedBox(height: 5),
                  SizedBox(width: 350,
                    child:  Text("Fire-Disaster",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text("Description",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
                    ],
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 350,height: 100,
                    child: TextFormField(
                      controller: addpost,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 60),
                            border: OutlineInputBorder()),

                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 40,
                  child: 
                  isloading ? Center(child: CircularProgressIndicator(),):
                  ElevatedButton(
                    onPressed: () async{
                      if (addpost.value.text.isNotEmpty) {
                        _saveUserDataToFirestore(addpost.text);
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PostListScreen()),
                        );
                      }
                       },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)))),
                    child: Text(
                      'Post',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
