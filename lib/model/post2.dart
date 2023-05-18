
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