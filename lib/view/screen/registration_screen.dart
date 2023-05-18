import 'package:balghny/view/widget/defaultBtn.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';


class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

  Future<void> signInWithFacebookAndSaveToFirestore() async {
  try {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final AuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Sign in with the credential
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

    // Get the user's data from Facebook
    final userData = await FacebookAuth.instance.getUserData(fields: 'name,email,picture');

    // Save the user's data to Firestore
   FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
      'name': userData['name'],
      'email': userData['email'],
      'photoUrl': userData['picture']['data']['url'],
    });
  } on FirebaseAuthException catch (e) {
    if (e.code == 'account-exists-with-different-credential') {
      // Handle account linking here
      print('The account already exists with a different credential');
    } else if (e.code == 'invalid-credential') {
      print('Error validating credentials');
    }
  } catch (e) {
    print('Error: $e');
  }
}

////////////////////////////////////////////
/// signInWithGoogle
final FirebaseAuth _auth = FirebaseAuth.instance;

Future<void> signInWithGoogle() async {
  // Create a GoogleSignInAccount object
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Exchange the GoogleSignInAccount for a GoogleSignInAuthentication object
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Get a credential from the authentication object
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Sign in to Firebase with the credential
  final UserCredential userCredential = await _auth.signInWithCredential(credential);

  // Write the user data to Firestore
  await _saveUserDataToFirestore1(userCredential.user);
}


  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _signOutWithGoogle(BuildContext context) async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    await _googleSignIn.disconnect();

    // Navigate back to the previous screen.
    Navigator.pop(context);
  }

Future<void> _saveUserDataToFirestore(User? user) async {
  if (user != null) {
    String userId = user.uid;
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'email': user.email,
      'name': userName.text,
      'photoUrl': user.photoURL?.isEmpty,
    });
  }
}



Future<void> _saveUserDataToFirestore1(User? user) async {
  if (user != null) {
    String userId = user.uid;

    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'email': user.email,
      'name': user.displayName,
      'photoUrl' : user.photoURL,
      

    });
  }
}
 // sign up
var password = TextEditingController() , 
    userName =TextEditingController() , 
    emailAddress = TextEditingController(),
    Confirmpassword = TextEditingController();

  GlobalKey<FormState>formstate = new GlobalKey<FormState>();

  signup() async {
   var formData = formstate.currentState;
   if (formData!.validate()) {

     formData.save();
    try {
   UserCredential usercredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: emailAddress.text,
    password: password.text,
    
  );
   User? user = usercredential.user;
    if (user != null) {
      await _saveUserDataToFirestore(user);
    }

  return usercredential ;

} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    AwesomeDialog(context: context,title: "this is Erorr",body: Text('The password provided is too weak'))..show();
  
        print('The password provided is too weak');
        } else if (e.code == 'email-already-in-use') {
          AwesomeDialog(context: context,title: "this is Erorr",body: Text('The account already exists for that email'))..show();
          print('The account already exists for that email');   
    
  }
} catch (e) {
  print(e);
}

   }else{
   }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                children: [
                  Stack(children: [
                    Container(child: Image.asset('assets/images/111.png',width: 120,height: 125,)),
                    Container(
                        margin: EdgeInsets.only(left: 2,top: 3),
                        child: Image.asset('assets/images/22.png',width: 110,height: 110,)),
                  ],),
                ],
              ),

              Text("Create Your Account",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

           /*   Column(
                children: [
                  Stack(
                    children: [
                      Center(
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/profile1.jpg'),
                          radius: 50,
                        ),
                      ),
                      InkWell(onTap: (){},
                        child: Container(margin: EdgeInsets.only(top: 70),
                            child: Center(child: Icon(Icons.add_circle,color: Colors.grey,))),
                      ),
                    ],
                  ),

                ],
              ),*/
              SizedBox(height: 15,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: formstate,
                  child: Column(children: [
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: userName,
                            validator: (val) {
                              if (val!.length > 50) {
                                return ("can not to be large then 50");                              
                              }
                              if (val.length < 2){
                                return("can not to be small then 2");
                              }
                            },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your name here',
                        labelText: 'User Name',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),
                    SizedBox(height: 15,),
                    SizedBox(height: 50,
                      child: TextFormField(
                         validator: (val) {
                              if (val!.length > 50) {
                                return ("can not to be large then 50");                              
                              }
                              if (val.length < 2){
                                return("can not to be small then 2");
                              }
                            },
                            controller: emailAddress,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter your email here',
                            labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    SizedBox(height: 50,
                      child: TextFormField(
                        controller: password,
                             validator: (val) {
                              if (val!.length > 50) {
                                return ("can not to be large then 50");                              
                              }
                              if (val.length < 4){
                                return("can not to be small then 4");
                              }
                            },
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter your password here',
                            labelText: 'Password',
                          suffixIcon: Icon(Icons.remove_red_eye)
                
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    SizedBox(height: 50,
                      child: TextFormField(
                        controller: Confirmpassword,
                
                         validator: (val) {
                            if (val!.length > 50) {
                              return ("can not to be large then 50");                              
                              }
                            if (val.length < 4){
                              return("can not to be small then 4");
                              }
                            },
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Confirm Password here',
                            labelText: 'Confirm Password',
                          suffixIcon: Icon(Icons.remove_red_eye)
                        ),
                      ),
                    ),
                              ],),
                ),),
              SizedBox(height: 40),
          Container(child: Column(children: [

            Row(
              children: [
                 Expanded(
                        
                        child: 
                        Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          height: 40,
                          child: 
                          ElevatedButton(
                            onPressed: () async {
                            UserCredential response = await signup();
                            if (response!= null) {
                               Navigator.of(context).pushReplacementNamed("/");
 
                            }else{
                              print('sign up faild');
                            }
                            print(response.user!.email);
                          },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.green),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)))),
                            child: Text(
                              'Sign',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      ),
                
              ],
            ),
            SizedBox(height: 6,),
            Row(children: [
              Expanded(child:  Center(child: Text("Or Sign up with",style: TextStyle(color: Colors.grey),)))
            ],),
            SizedBox(height: 6,),
            Stack(
              children: [
                Row(
                  children: [
                     Expanded(
                        
                        child: 
                        Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          height: 40,
                          child: 
                          ElevatedButton(
                            onPressed: () async {
                                  try {
                                    await signInWithGoogle();
                                    Navigator.of(context).pushReplacementNamed('home');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Sign in success!')),
                                      
                                    );
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Error signing in.')),
                                    );

                                  }
                                },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.green),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)))),
                            child: Text(
                              'Continue with Google',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 15,top: 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset("assets/images/google (1).png",width: 50,height: 40,) ,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15,),
            Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: 
                        Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          height: 40,
                          child: 
                          ElevatedButton(
                            onPressed: ()async {
                              await signInWithFacebookAndSaveToFirestore();
                              Navigator.of(context).pushReplacementNamed('home');

                              print("Facebook");},
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.green),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)))),
                            child: Text(
                              'Continue with Facebook',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      ),
                  ],
                ),

                Container(
                  margin: EdgeInsets.only(left: 15,top: 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset("assets/images/face1.png",width: 50,height: 40,) ,
                  ),
                ),
                /*
                Container(
                  margin: EdgeInsets.only(left: 20,top: 5),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/Face.png'),
                    radius: 20,

                  ),
                ),
                 */
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("     Already have an account?",style: TextStyle(fontSize: 15),),
              SizedBox(width: 10,),
              InkWell( onTap: (){
                Navigator.of(context).pushNamed("login");
              },
                  child: Text("Sign in",style: TextStyle(color: Colors.green,fontSize: 15),))
            ],),

          ],),),
              SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(children: [
                    Container(child: Image.asset('assets/images/33.png',width: 120,height: 125,)),
                    Container(
                        margin: EdgeInsets.only(left: 10,top: 15),
                        child: Image.asset('assets/images/44.png',width: 110,height: 110,)),
                  ],),


                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
}
