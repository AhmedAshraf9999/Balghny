import 'package:balghny/l10n/app_localizations.dart';
import 'package:balghny/view/screen/login_screen.dart';
import 'package:balghny/view/screen/profile.dart';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;

  var myEmail = "";
  var myName = "";
  var myPhotoUrl; // add this variable to store the user's photo URL

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  Future<void> _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        setState(() {
          myEmail = ds.data()!["email"] ?? "";
          myName = ds.data()!["name"] ?? "";
          myPhotoUrl = ds.data()!["photoUrl"] ?? ""; // get the user's photo URL
        });
        // get the user's photo URL
        print(myEmail);
        print(myName);
      }).catchError((e) {
        print(e);
      });
    }
  }

  late File file;
  var imagePicker = ImagePicker();
  uploadimage() async {
    // ignore: deprecated_member_use
    var imgpicked = await imagePicker.getImage(source: ImageSource.camera);

    if (imgpicked != null) {
      file = File(imgpicked.path);

      var refstorge = FirebaseStorage.instance.ref("imagesflnameimage");
      await refstorge.putFile(file);
      var url = refstorge.getDownloadURL();
      print("url : $url");
    }
  }

  int currentTab = 0;
  final List<Widget> screens = [
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage(),
  ];

  Widget currentScreen = HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.only(top: 0, left: 2, right: 2),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: 240,
                  padding: EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color: Colors.green[200], // Background color
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(120),
                      bottomRight: Radius.circular(120),
                    ),
                  ),
                  child: Container(
                    height: 5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.green[200],
                    ),
                    child: CircleAvatar(
                        backgroundImage: AssetImage("assets/images/logo.jpg")),
                  ),
                ),
              ),

              Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.my_profile),
                          leading: Icon(Icons.person),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileScreen()),
                            );
                          },
                        ),
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.homepage),
                          leading: Icon(Icons.home),
                          onTap: () {
                            Navigator.of(context).pushNamed("home");
                          },
                        ),
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.about_us),
                          leading: Icon(Icons.dataset),
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed('AboutPage');
                          },
                        ),
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.emergency),
                          leading: Icon(Icons.emergency),
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed('Emergency');
                          },
                        ),
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.hospitals),
                          leading: Icon(Icons.local_hospital_rounded),
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed('Hospitals');
                          },
                        ),
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.contact_us),
                          leading: Icon(Icons.mail),
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed('ContactUs');
                            //Navigator.of(context).pushReplacementNamed('AccordionPage');
                          },
                        ),
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.helps_faqs),
                          leading: Icon(Icons.help_center),
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed('AccordionPage');
                          },
                        ),
                      ],
                    ),
                  )),

              // SizedBox(height: 20,),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          FirebaseAuth.instance.signOut();
                          await FirebaseAuth.instance.signOut();
                          // Sign out of Google
                          await GoogleSignIn().signOut();
                          // Sign out of Facebook
                          //await FacebookAuth.instance.logOut();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));

                          // await signOutGoogle();
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          width: 130,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Color(0xFF1ABC00),
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //Icon(Icons.power_settings_new),
                              Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 14,
                                    backgroundColor: Colors.white,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(left: 2),
                                    child: Icon(Icons.power_settings_new,
                                        color: Color(0xFF1ABC00)),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                AppLocalizations.of(context)!.log_out,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 40,
                            height: 40,
                            margin: EdgeInsets.only(
                              left: 5,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Builder(builder: (context) {
                              return IconButton(
                                  onPressed: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                  icon: Icon(
                                    Icons.menu,
                                    color: Colors.black,
                                    size: 15,
                                  ));
                            })),
                        Expanded(
                          child: Column(
                            children: [],
                          ),
                        ),
                        Text(AppLocalizations.of(context)!.home_msg,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25)),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: GestureDetector(
                                onTap: () {},
                                //  onTap: _pickImageAndUpload, // Call the method to pick an image and upload it to Firebase
                                child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            myPhotoUrl ??
                                                'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y',
                                          ),
                                        )))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(AppLocalizations.of(context)!.categories,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () => Navigator.of(context)
                                      .pushNamed("Cam_Fire"),
                                  child: Container(
                                      //margin: EdgeInsets.only(bottom: 20),
                                      // padding: EdgeInsets.all(5),
                                      height: 220,
                                      width: 170,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Image.asset(
                                              "assets/images/fire.jpg",
                                              width: double.infinity,
                                              height: 150,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          //   Image.asset("assets/images/r1.jpg",width: 150,height: 130,fit: BoxFit.fill,),
                                          Container(

                                              margin:
                                                  EdgeInsets.only(right: 0),
                                              child: Center(
                                                child: Text(

                                                  AppLocalizations.of(context)!
                                                      .fire_disaster,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                              )),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () =>
                                      Navigator.of(context).pushNamed("cam2"),
                                  child: Container(
                                      //margin: EdgeInsets.only(bottom: 20),
                                      // padding: EdgeInsets.all(5),
                                      height: 220,
                                      width: 170,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Image.asset(
                                              "assets/images/water.jpg",
                                              width: double.infinity,
                                              height: 150,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          //   Image.asset("assets/images/r1.jpg",width: 150,height: 130,fit: BoxFit.fill,),
                                          Container(
                                              margin:
                                                  EdgeInsets.only(right: 0),
                                              child: Center(
                                                child: Text(
                                                  AppLocalizations.of(context)!
                                                      .water_disaster,
                                                  textAlign: TextAlign.center,

                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                              )),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () =>
                                      Navigator.of(context).pushNamed("cam3"),
                                  child: Container(
                                      //margin: EdgeInsets.only(bottom: 20),
                                      // padding: EdgeInsets.all(5),
                                      height: 220,
                                      width: 170,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Image.asset(
                                              "assets/images/Infra.jpg",
                                              width: double.infinity,
                                              height: 150,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          //   Image.asset("assets/images/r1.jpg",width: 150,height: 130,fit: BoxFit.fill,),
                                          Expanded(
                                            child: Container(

                                                child: Center(
                                                  child: Text(
                                                    AppLocalizations.of(context)!
                                                        .infrastructure_disaster,
                                                    textAlign: TextAlign.center,

                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                )),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () =>
                                      Navigator.of(context).pushNamed("cam4"),
                                  child: Container(
                                      //margin: EdgeInsets.only(bottom: 20),
                                      // padding: EdgeInsets.all(5),
                                      height: 220,
                                      width: 170,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Image.asset(
                                              "assets/images/acc.jpg",
                                              width: double.infinity,
                                              height: 150,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          //   Image.asset("assets/images/r1.jpg",width: 150,height: 130,fit: BoxFit.fill,),
                                          Container(
                                              margin:
                                                  EdgeInsets.only(right: 0),
                                              child: Center(
                                                child: Text(
                                                  AppLocalizations.of(context)!
                                                      .car_accidents,
                                                  textAlign: TextAlign.center,

                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                              )),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () =>
                                      Navigator.of(context).pushNamed("cam"),
                                  child: Container(
                                      //margin: EdgeInsets.only(bottom: 20),
                                      // padding: EdgeInsets.all(5),
                                      height: 200,
                                      width: 170,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Image.asset(
                                              "assets/images/r1.jpg",
                                              width: double.infinity,
                                              height: 150,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          //   Image.asset("assets/images/r1.jpg",width: 150,height: 130,fit: BoxFit.fill,),
                                          Container(
                                              margin:
                                                  EdgeInsets.only(right: 20),
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .new_category,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              )),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () =>
                                      Navigator.of(context).pushNamed("cam2"),
                                  child: Container(
                                      //margin: EdgeInsets.only(bottom: 20),
                                      // padding: EdgeInsets.all(5),
                                      height: 200,
                                      width: 170,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Image.asset(
                                              "assets/images/r1.jpg",
                                              width: double.infinity,
                                              height: 150,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          //   Image.asset("assets/images/r1.jpg",width: 150,height: 130,fit: BoxFit.fill,),
                                          Container(
                                              margin:
                                                  EdgeInsets.only(right: 20),
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .new_category,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              )),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () =>
                                      Navigator.of(context).pushNamed("cam"),
                                  child: Container(
                                      //margin: EdgeInsets.only(bottom: 20),
                                      // padding: EdgeInsets.all(5),
                                      height: 200,
                                      width: 170,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Image.asset(
                                              "assets/images/r1.jpg",
                                              width: double.infinity,
                                              height: 150,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          //   Image.asset("assets/images/r1.jpg",width: 150,height: 130,fit: BoxFit.fill,),
                                          Container(
                                              margin:
                                                  EdgeInsets.only(right: 20),
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .new_category,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              )),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () =>
                                      Navigator.of(context).pushNamed("cam2"),
                                  child: Container(
                                      //margin: EdgeInsets.only(bottom: 20),
                                      // padding: EdgeInsets.all(5),
                                      height: 200,
                                      width: 170,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Image.asset(
                                              "assets/images/r1.jpg",
                                              width: double.infinity,
                                              height: 150,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          //   Image.asset("assets/images/r1.jpg",width: 150,height: 130,fit: BoxFit.fill,),
                                          Container(
                                              margin:
                                                  EdgeInsets.only(right: 20),
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .new_category,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              )),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ))),
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
