import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

var myName = "";
var myEmail = "";
var myPhotoUrl = "";
var myPhoneNumber = "";
var myCity = "" ;

  @override
void initState() {
  super.initState();
  _fetchUserData();
}
final picker = ImagePicker();

Future<void> _pickImageAndUpload() async {
  final pickedFile = await picker.getImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    final storageRef = FirebaseStorage.instance.ref()
        .child('profile_images')
        .child(FirebaseAuth.instance.currentUser!.uid + '.jpg');

    await storageRef.putFile(File(pickedFile.path));

    final photoUrl = await storageRef.getDownloadURL();
    setState(() {
      myPhotoUrl = photoUrl;
    });
  }
}

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

  final _formKey = GlobalKey<FormState>();

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Edit Profile'),
      backgroundColor: Colors.green,
    ),
    body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  
                children: [
                  Column(
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: _pickImageAndUpload,
                            child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                              border: Border.all(width: 5, color: Colors.grey),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(myPhotoUrl ??
                            'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y'),
                            )
                            )
                        ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: FloatingActionButton(
                      child: Icon(Icons.camera_alt),
                      onPressed: _pickImageAndUpload,
                    ),
                  ),
                ],
            ),
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: myName,
                decoration: InputDecoration(labelText: 'Name',border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    myName = value;
                  });
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                  initialValue: myPhoneNumber,
                  decoration: InputDecoration(labelText: 'Your Phone Number',border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      myPhoneNumber = value;
                    });
                  },
                ),
              
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    initialValue: myCity,
                    decoration: InputDecoration(labelText: 'City',border: OutlineInputBorder(),),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your City';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        myCity = value;
                      });
                    },
                  ),
              ),
              
              SizedBox(height: 35),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Save the updated profile data
                      _editProfileData();
                    }
                  },
                  child: Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Future<void> _editProfileData() async {
final firebaseUser = FirebaseAuth.instance.currentUser!;
await FirebaseFirestore.instance
.collection('users')
.doc(firebaseUser.uid)
.update({
'name': myName,
'email': myEmail,
'photoUrl': myPhotoUrl,
'phoneNumber': myPhoneNumber,
'city': myCity,
});

// Show a snackbar to confirm that the data was saved
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text('Profile updated')),
);
}

}