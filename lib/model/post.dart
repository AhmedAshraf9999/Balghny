import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String post_body;
  final DateTime time;
  final String username;
  final String photourl;
  var photocate;
 
  Post({
    required this.post_body, 
    required this.time,
    required this.username, 
    required this.photourl,
    required this.photocate
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      post_body: json['post_body'] ?? '',
      time: (json['time']).toDate(),
      username: json['username'] ?? '',
      photourl: json['photourl'] ?? '',
      photocate: json['imageUrl'] ??'',
    );
  }
}

class users {
  var name;
  var photourl;
  
 
  users({
    required this.name, 
    
    required this.photourl,
   
  });

  factory users.fromJson(Map<String, dynamic> json) {
    return users(
     
      name: json['name'] ?? '',
      photourl: json['photourl'] ?? '',
    );
  }
}