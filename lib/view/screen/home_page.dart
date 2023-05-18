import 'package:balghny/view/screen/login_screen.dart';
import 'package:balghny/view/screen/profile.dart';
import 'package:balghny/view/widget/defaultBtn.dart';
import 'package:balghny/view/widget/notification_widget.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:balghny/model/user_notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  User? user = FirebaseAuth.instance.currentUser;

 Future<void> _pickImageAndUpload() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Get a reference to the Firebase Storage location
      final storageRef = FirebaseStorage.instance.ref()
          .child('profile_images')
          .child(FirebaseAuth.instance.currentUser!.uid + '.jpg');

      // Upload the file to Firebase Storage
      await storageRef.putFile(File(pickedFile.path));

      // Update the user's photo URL in Firestore
      final photoUrl = await storageRef.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'photoUrl': photoUrl});
      
      setState(() {
        myPhotoUrl = photoUrl;
      });
    }
  }

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
          myPhotoUrl = ds.data()!["photoUrl"]?? "";  // get the user's photo URL

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
  uploadimage()async {
    
    // ignore: deprecated_member_use
    var imgpicked = await imagePicker.getImage(source: ImageSource.camera);

    if (imgpicked != null) {

      file =File(imgpicked.path );

      var refstorge = FirebaseStorage.instance.ref("imagesflnameimage") ;
      await refstorge.putFile(file) ;
      var url = refstorge.getDownloadURL() ;
      print("url : $url") ; 
    }
    
  }
  int currentTab = 0;
  final List<Widget> screens = [
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage(),
  ];

  Widget currentScreen =  HomePage();


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.only(top: 0,left: 2,right: 2),
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
                    child:
                    CircleAvatar(backgroundImage: AssetImage("assets/images/logo.jpg")),
                  ),
                ),
              ),

               /*  Container(
                child: UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: (AssetImage("assets/images/my.jpg")),
                  ),
                  accountName: Text("Ahmed Ashraf"),
                  accountEmail: Text("ahmedashraf@gmail.com"),
                ),
              ),*/
              Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    child: Column(children: [

                      SizedBox(height: 20,),

                ListTile(
                    title: Text("My Profile"),
                    leading: Icon(Icons.person),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ProfileScreen()),
                          );
                    },
                ),
                      ListTile(
                        title: Text("HomePage"),
                        leading: Icon(Icons.home),
                        onTap: () {
                          Navigator.of(context).pushNamed("home");
                        },
                      ),
                      ListTile(
                        title: Text("About Us"),
                        leading: Icon(Icons.dataset),
                        onTap: () { Navigator.of(context).pushReplacementNamed('AboutPage');},
                      ),
                      ListTile(
                        title: Text("resault"),
                        leading: Icon(Icons.dataset),
                        onTap: () { Navigator.of(context).pushReplacementNamed('r');},
                      ),


                ListTile(
                    title: Text("Contact Us"),
                    leading: Icon(Icons.mail),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('ContactUs');
                      //Navigator.of(context).pushReplacementNamed('AccordionPage');
                    },
                ),
                ListTile(
                    title: Text("Helps & FAQs"),
                    leading: Icon(Icons.help_center),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('AccordionPage');
                    },
                ),
              ],),
                  )),

              // SizedBox(height: 20,),
              Expanded(
                flex: 1,
                child: Row(children: [
                 InkWell( onTap: ()async{
                          FirebaseAuth.instance.signOut();
                          await FirebaseAuth.instance.signOut();
                          // Sign out of Google 
                          await GoogleSignIn().signOut();
                          // Sign out of Facebook
                          //await FacebookAuth.instance.logOut();
                          Navigator.push(context,MaterialPageRoute(builder: (context) => Login()));
                          
                          // await signOutGoogle();
                        },child: Container(
                    padding: EdgeInsets.all(5),
                    width: 110,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Icon(Icons.power_settings_new),
                        Stack(children: [
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.white,
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: 2),
                            child: Icon(
                                Icons.power_settings_new,color: Colors.deepOrangeAccent),
                          )
                        ],),
                        SizedBox(width: 10,),
                        Text("Log Out",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)

                      ],),
                  ),)
                ],),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(10),
        child:  Column(children: [
            SizedBox(height: 10,),
          Expanded(
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 40,
                    height: 40,
                    margin: EdgeInsets.only(left: 5,),

                    // margin: EdgeInsets.only(left: 20, top: 30),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Builder(
                        builder: (context) {
                          return IconButton(
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                              icon: Icon(
                                Icons.menu,
                                color: Colors.black,
                                size: 15,
                              ));
                        }
                    )),

                Expanded(
                  child: Column(children: [

                  ],),
                ),
                Text('Choose your report',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),
                SizedBox(width: 30,),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: GestureDetector(
                          onTap: _pickImageAndUpload, // Call the method to pick an image and upload it to Firebase
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image:  NetworkImage(
                                  myPhotoUrl ?? 'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y',
                                  ),
                              )
                              )
                              )
                              ),
                  ),
                ),
              ],),
          ),
      /*    Row(children: [
            Expanded(flex: 1,child: Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.only(left: 10, top: 10),

                // margin: EdgeInsets.only(left: 20, top: 30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Builder(
                    builder: (context) {
                      return IconButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: Icon(
                            Icons.menu,
                            color: Colors.black,
                            size: 15,
                          ));
                    }
                )),),
            Expanded(flex: 5,child: Container()),
            Expanded(flex: 1,child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset("assets/images/my.jpg",width: 40,height: 40,) ,
            ),)
          ],),
*/
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 20),
              child: Column(children: [
                SizedBox(height: 20,),
          /*      Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Choose your report',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),
                  ],
                ),*/
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Categories',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),
                    ],
                  ),
                ),

                //Text('بلاغك',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
              ],),
            ),
          ),

     Expanded(
       flex: 7,
       child: SingleChildScrollView(
         scrollDirection: Axis.vertical,
         child: Column(
           children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
               Expanded(
                 child: InkWell(
                  // onTap: ()=> Navigator.of(context).pushNamed("Cam_Fire"),
                   onTap: ()=> Navigator.of(context).pushNamed("Cam_Fire"),
                   child: Container(
                       //margin: EdgeInsets.only(bottom: 20),
                       // padding: EdgeInsets.all(5),
                       height: 180,
                       width: 170,
                       decoration: BoxDecoration(
                           color: Colors.grey[200],
                           borderRadius: BorderRadius.circular(10)
                       ),
                       child:
                       Column(
                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children: [
                           ClipRRect(
                             borderRadius: BorderRadius.circular(10.0),
                             child: Image.asset("assets/images/r1.jpg",width:double.infinity,height: 145,fit: BoxFit.fill,) ,
                           ),
                           SizedBox(height: 5,),
                           //   Image.asset("assets/images/r1.jpg",width: 150,height: 130,fit: BoxFit.fill,),
                           Container(
                               margin: EdgeInsets.only(right: 20),
                               child: Text("Fire Disaster",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                           SizedBox(height: 5,),
                         ],
                       )),
                 ),
               ),
               SizedBox(width: 20,),
               Expanded(
                 child: InkWell(
                   onTap: ()=> Navigator.of(context).pushNamed("cam2"),
                   child: Container(
                     //margin: EdgeInsets.only(bottom: 20),
                     // padding: EdgeInsets.all(5),
                       height: 180,
                       width: 170,
                       decoration: BoxDecoration(
                           color: Colors.grey[200],
                           borderRadius: BorderRadius.circular(10)
                       ),
                       child:
                       Column(
                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children: [
                           ClipRRect(
                             borderRadius: BorderRadius.circular(10.0),
                             child: Image.asset("assets/images/r1.jpg",width:double.infinity,height: 145,fit: BoxFit.fill,) ,
                           ),
                           SizedBox(height: 5,),
                           //   Image.asset("assets/images/r1.jpg",width: 150,height: 130,fit: BoxFit.fill,),
                           Container(
                               margin: EdgeInsets.only(right: 20),
                               child: Text("Water disaster",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                           SizedBox(height: 5,),
                         ],
                       )),
                 ),
               ),
             ],),

             SizedBox(height: 20,),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Expanded(
                   child: InkWell(
                     onTap: ()=> Navigator.of(context).pushNamed("cam3"),
                     child: Container(
                       //margin: EdgeInsets.only(bottom: 20),
                       // padding: EdgeInsets.all(5),
                         height: 180,
                         width: 170,
                         decoration: BoxDecoration(
                             color: Colors.grey[200],
                             borderRadius: BorderRadius.circular(10)
                         ),
                         child:
                         Column(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             ClipRRect(
                               borderRadius: BorderRadius.circular(10.0),
                               child: Image.asset("assets/images/r1.jpg",width:double.infinity,height: 145,fit: BoxFit.fill,) ,
                             ),
                             SizedBox(height: 5,),
                             //   Image.asset("assets/images/r1.jpg",width: 150,height: 130,fit: BoxFit.fill,),
                             Container(
                                 margin: EdgeInsets.only(right: 20),
                                 child: Text("Infrastructure",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                             SizedBox(height: 5,),
                           ],
                         )),
                   ),
                 ),
                 SizedBox(width: 20,),
                 Expanded(
                   child: InkWell(
                     onTap: ()=> Navigator.of(context).pushNamed("cam4"),
                     child: Container(
                       //margin: EdgeInsets.only(bottom: 20),
                       // padding: EdgeInsets.all(5),
                         height: 180,
                         width: 170,
                         decoration: BoxDecoration(
                             color: Colors.grey[200],
                             borderRadius: BorderRadius.circular(10)
                         ),
                         child:
                         Column(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             ClipRRect(
                               borderRadius: BorderRadius.circular(10.0),
                               child: Image.asset("assets/images/r1.jpg",width:double.infinity,height: 145,fit: BoxFit.fill,) ,
                             ),
                             SizedBox(height: 5,),
                             //   Image.asset("assets/images/r1.jpg",width: 150,height: 130,fit: BoxFit.fill,),
                             Container(
                                 margin: EdgeInsets.only(right: 20),
                                 child: Text("Accidents",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                             SizedBox(height: 5,),
                           ],
                         )),
                   ),
                 ),
               ],),
             SizedBox(height: 20,),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Expanded(
                   child: InkWell(
                     onTap: ()=> Navigator.of(context).pushNamed("cam"),
                     child: Container(
                       //margin: EdgeInsets.only(bottom: 20),
                       // padding: EdgeInsets.all(5),
                         height: 180,
                         width: 170,
                         decoration: BoxDecoration(
                             color: Colors.grey[200],
                             borderRadius: BorderRadius.circular(10)
                         ),
                         child:
                         Column(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             ClipRRect(
                               borderRadius: BorderRadius.circular(10.0),
                               child: Image.asset("assets/images/r1.jpg",width:double.infinity,height: 145,fit: BoxFit.fill,) ,
                             ),
                             SizedBox(height: 5,),
                             //   Image.asset("assets/images/r1.jpg",width: 150,height: 130,fit: BoxFit.fill,),
                             Container(
                                 margin: EdgeInsets.only(right: 20),
                                 child: Text("New Category",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                             SizedBox(height: 5,),
                           ],
                         )),
                   ),
                 ),
                 SizedBox(width: 20,),
                 Expanded(
                   child: InkWell(
                     onTap: ()=> Navigator.of(context).pushNamed("cam2"),
                     child: Container(
                       //margin: EdgeInsets.only(bottom: 20),
                       // padding: EdgeInsets.all(5),
                         height: 180,
                         width: 170,
                         decoration: BoxDecoration(
                             color: Colors.grey[200],
                             borderRadius: BorderRadius.circular(10)
                         ),
                         child:
                         Column(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             ClipRRect(
                               borderRadius: BorderRadius.circular(10.0),
                               child: Image.asset("assets/images/r1.jpg",width:double.infinity,height: 145,fit: BoxFit.fill,) ,
                             ),
                             SizedBox(height: 5,),
                             //   Image.asset("assets/images/r1.jpg",width: 150,height: 130,fit: BoxFit.fill,),
                             Container(
                                 margin: EdgeInsets.only(right: 20),
                                 child: Text("New Category",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                             SizedBox(height: 5,),
                           ],
                         )),
                   ),
                 ),
               ],),
             SizedBox(height: 20,),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Expanded(
                   child: InkWell(
                     onTap: ()=> Navigator.of(context).pushNamed("cam"),
                     child: Container(
                       //margin: EdgeInsets.only(bottom: 20),
                       // padding: EdgeInsets.all(5),
                         height: 180,
                         width: 170,
                         decoration: BoxDecoration(
                             color: Colors.grey[200],
                             borderRadius: BorderRadius.circular(10)
                         ),
                         child:
                         Column(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             ClipRRect(
                               borderRadius: BorderRadius.circular(10.0),
                               child: Image.asset("assets/images/r1.jpg",width:double.infinity,height: 145,fit: BoxFit.fill,) ,
                             ),
                             SizedBox(height: 5,),
                             //   Image.asset("assets/images/r1.jpg",width: 150,height: 130,fit: BoxFit.fill,),
                             Container(
                                 margin: EdgeInsets.only(right: 20),
                                 child: Text("New Category",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                             SizedBox(height: 5,),
                           ],
                         )),
                   ),
                 ),
                 SizedBox(width: 20,),
                 Expanded(
                   child: InkWell(
                     onTap: ()=> Navigator.of(context).pushNamed("cam2"),
                     child: Container(
                       //margin: EdgeInsets.only(bottom: 20),
                       // padding: EdgeInsets.all(5),
                         height: 180,
                         width: 170,
                         decoration: BoxDecoration(
                             color: Colors.grey[200],
                             borderRadius: BorderRadius.circular(10)
                         ),
                         child:
                         Column(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             ClipRRect(
                               borderRadius: BorderRadius.circular(10.0),
                               child: Image.asset("assets/images/r1.jpg",width:double.infinity,height: 145,fit: BoxFit.fill,) ,
                             ),
                             SizedBox(height: 5,),
                             //   Image.asset("assets/images/r1.jpg",width: 150,height: 130,fit: BoxFit.fill,),
                             Container(
                                 margin: EdgeInsets.only(right: 20),
                                 child: Text("New Category",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                             SizedBox(height: 5,),
                           ],
                         )),
                   ),
                 ),
               ],),
           ],
         ),
       ),
     ),





        ],)
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
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.dark_mode_rounded,
                    color: currentTab == 1
                        ? const Color(0xFF1ABC00)
                        : Colors.black),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("post");
                },
                icon: Icon(Icons.groups_outlined,
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

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationWidget(notification:  null),
                    ),
                  );
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
