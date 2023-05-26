import 'dart:io';

import 'package:balghny/view/screen/com.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Add_post extends StatefulWidget {


final File img;
  const Add_post({Key? key,required this.img}) : super(key: key);

  @override
  State<Add_post> createState() => _Add_postState();
}

class _Add_postState extends State<Add_post> {

  String location ='Null, Press Button';
  String Address = 'search';


  
  TextEditingController addpost = TextEditingController();
  bool isloading =false ;
  var img_url;

  //////////location fun
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }



  Future<void> GetAddressFromLatLong(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address = ' ${place.street},  ';
    setState(()  {
    });


    //${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}
  }
  ////////////

  ///


Future<void> _saveUserDataToFirestore(String? post_body) async {


    //////////
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
        'Address': Address,


      }
    );
    print('Post added to Firestore.');
  } else {
    // User document does not exist in the 'users' collection
    print('User document not found in the users collection. Cannot add post.');
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
            icon: Icon(Icons.arrow_back)),
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
                    )
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
                    child:  Container(margin:EdgeInsets.only(left: 30,top: 5),
//"Fire-Disaster"
                        child: Text('${Address}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
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
                    width: 330,height: 100,
                    child: TextFormField(
                      controller: addpost,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 60,horizontal: 10),
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

                      //////////

                      if (Address.isNotEmpty) {
                        Position position = await _getGeoLocationPosition();
                        location ='Lat: ${position.latitude} , Long: ${position.longitude}';
                        GetAddressFromLatLong(position);
                        setState(() {
                          GetAddressFromLatLong(position);
                        });
                        /////
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
