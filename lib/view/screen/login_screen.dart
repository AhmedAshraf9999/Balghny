import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {


   var mypassword = TextEditingController() , emailAddress = TextEditingController();

   GlobalKey<FormState>formstate = new GlobalKey<FormState>(); 

  @override
  void dispose() { 
    super.dispose();
    emailAddress . dispose();
    mypassword.dispose();
  }
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
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
final FirebaseAuth _auth = FirebaseAuth.instance;

   Future<void> signInWithGoogle() async {
     // Create a GoogleSignIn object
     final GoogleSignIn googleSignIn = GoogleSignIn();

     // Prompt the user to sign in with their Google account
     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

     if (googleUser != null) {
       // Get the authentication data from the GoogleSignInAccount
       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

       // Create a new credential using the authentication data
       final credential = GoogleAuthProvider.credential(
         accessToken: googleAuth.accessToken,
         idToken: googleAuth.idToken,
       );

       try {
         // Sign in to Firebase with the credential
         final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
         await _saveUserDataToFirestore1(userCredential.user);

         // Do something with the signed-in user...

       } catch (e) {
         print(e.toString());
       }
     }
   }


  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _signOutWithGoogle(BuildContext context) async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    await _googleSignIn.disconnect();

    // Navigate back to the previous screen.
    Navigator.pop(context);
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
 Future signin() async{
  var formData = formstate.currentState;
   if (formData!.validate()) {
    formData.save();
try {
  UserCredential usercredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
     email: emailAddress.text,
     password: mypassword.text
  );

   Navigator.of(context).pushReplacementNamed('home');   

} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
        AwesomeDialog(context: context,title: "this is Erorr",body: Text('No user found for that email'))..show();
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
        AwesomeDialog(context: context,title: "this is Erorr",body: Text('Wrong password provided for that user.'))..show();

    print('Wrong password provided for that user.');
  }
}
   }else{
    return("not valid");
   }
 
        
}
   bool rememberMe = false;
   bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(          scrollDirection: Axis.vertical,
          child: Form(
          key: formstate,
            child:
             Column(
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
                SizedBox(height: 20,),
                Container(child: Text("Login to your account",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                SizedBox(height: 20,),
          
          
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(children: [
          
                    SizedBox(height: 50,
                      child: TextFormField(
                        controller: emailAddress,
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
                          hintText: 'Enter your email here',
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    SizedBox(height: 50,
                      child: TextFormField(
                        obscureText: _obscureText,
                        controller: mypassword,
                              validator: (val) {
                                if (val!.length > 50) {
                                  return ("can not to be large then 50");                              
                                }
                                if (val.length < 4){
                                  return("can not to be small then 4 ");
                                }
                              },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter your password here',
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                              onPressed: (){
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            )
          
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),

                  Row(
                   // crossAxisAlignment: CrossAxisAlignment.end,
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                  /*  CheckboxListTile(
                      title: Text('Remember me'),
                      value: rememberMe,
                      onChanged: (value) {
                        setState(() {
                          rememberMe = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),*/



                     InkWell(
                         onTap: (){},
                         child: Text("Forget Password?",style: TextStyle(color: Colors.red)))
                   ],)

          
                  ],),),
                SizedBox(height: 40,),
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
                            onPressed: ()=> signin(),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.green),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)))),
                            child: Text(
                              'sign in',
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
                  SizedBox(height: 10,),
                  Row(children: [
                    Expanded(child:  Center(child: Text("Or Sign in with",style: TextStyle(color: Colors.grey),)))
                  ],),
                  SizedBox(height: 10,),
                  Row(children: [
                    Expanded(child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //    IconButton(onPressed: (){}, icon:  )
                        InkWell(
                          onTap: () async {
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
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset("assets/images/google (1).png",width: 50,height: 40,) ,
                          ),
                        ),
                        SizedBox(width: 20),
                        InkWell(
                          onTap: ()async {
                            await signInWithFacebookAndSaveToFirestore();
                            Navigator.of(context).pushReplacementNamed('home');
                            print("Facebook");},
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset("assets/images/facebookicon.png",width: 50,height: 40,) ,
                          ),
                        ),
                      ],))
                  ],),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("     Don't have an account?",style: TextStyle(fontSize: 15)),
                      SizedBox(width: 5,),
                      InkWell(
                          onTap: (){
                            Navigator.of(context).pushNamed("register");
                          },
                          child: Text("Sign up",style: TextStyle(color: Colors.green,fontSize: 15),))
                    ],),
                  SizedBox(height: 20,),
          
                ],),),
                SizedBox(height: 40,),
          
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
      ),
    );
  }
}
