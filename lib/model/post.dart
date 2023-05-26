

class Post {
  final String post_body;
  final DateTime time;
  final String username;
  final String photourl;
  var photocate;
  final String Address;

 
  Post({
    required this.post_body, 
    required this.time,
    required this.username, 
    required this.photourl,
    required this.photocate,
    required this.Address,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      post_body: json['post_body'] ?? '',
      time: (json['time']).toDate(),
      username: json['username'] ?? '',
      Address: json['Address'] ?? '',
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