
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Post {
  final String profileImageUrl;
  final String username;
  final String time;
  final String description;
  final String cateImageUrl;
  final String share;

  Post({
    required this.profileImageUrl,
    required this.username,
    required this.time,
    required this.description,
    required this.cateImageUrl,
    required this.share,
  });

  /////////
// Factory method to convert the map to the object



////////////////
}






List<Post> posts = [
  new Post(
      profileImageUrl: 'assets/images/my.jpg',
      username: 'Ahmed Ashraf',
      time: '5h',
      description:
          'Hey guys whats up, This is Sam Wilson. I am currently in singapore. Came here to make some amazing memories',
      cateImageUrl: 'assets/images/my.jpg',
      share: 'Share',

  ),
  new Post(
      profileImageUrl: 'assets/images/my.jpg',
      username: 'Sam Wilson',
      time: '5h',
      description:
      'Hey guys whats up, This is Sam Wilson. I am currently in singapore. Came here to make some amazing memories',
      cateImageUrl: 'assets/images/my.jpg',
    share: 'Share',),
  new Post(
      profileImageUrl: 'assets/images/my.jpg',
      username: 'Sam Wilson',
      time: '5h',
      description:
      'Hey guys whats up, This is Sam Wilson. I am currently in singapore. Came here to make some amazing memories',
      cateImageUrl: 'assets/images/my.jpg',
    share: 'Share',),
  new Post(
      profileImageUrl: 'assets/images/my.jpg',
      username: 'Sam Wilson',
      time: '5h',
      description:
      'Hey guys whats up, This is Sam Wilson. I am currently in singapore. Came here to make some amazing memories',
      cateImageUrl: 'assets/images/my.jpg',
    share: 'Share',),
  new Post(
      profileImageUrl: 'assets/images/my.jpg',
      username: 'Karim Tarek',
      time: '5h',
      description:
      'Hey guys whats up, This is Sam Wilson. I am currently in singapore. Came here to make some amazing memories',
      cateImageUrl: 'assets/images/my.jpg',
    share: 'Share',),
  new Post(
      profileImageUrl: 'assets/images/my.jpg',
      username: 'Mohamed Hossam',
      time: '5h',
      description:
      'Hey guys whats up, This is Sam Wilson. I am currently in singapore. Came here to make some amazing memories',
      cateImageUrl: 'assets/images/my.jpg',
    share: 'Share',),


];



/*var profileImageUrl;
var  username;

@override
void initState() {
  //super.initState();
  _fetch();
  FirebaseAppCheck.instance
      .activate(webRecaptchaSiteKey: 'RECAPTCHA_SITE_KEY');
}

Future<void> _fetch() async {
  final firebaseUser = await FirebaseAuth.instance.currentUser!;
  if (firebaseUser != null) {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .get()
        .then((ds) {
     // setState(() {
        username = ds.data()!["name"] ?? "";
        profileImageUrl = ds.data()!["photoUrl"]; // get the user's photo URL
    //  });
      print(profileImageUrl);
      print(username);
    }).catchError((e) {
      print(e);
    });
  }
}*/
