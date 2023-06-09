import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:balghny/l10n/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


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

  bool isPasswordValid(String password) {
    final passwordRegex = r'^(?=.?[A-Z])(?=.?[a-z])(?=.*?[0-9]).{8,}$';
    return RegExp(passwordRegex).hasMatch(password);
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
        if (!isPasswordValid(password.text)) {
          AwesomeDialog(
            context: context,
            title: "Error",
            body: Text("The password provided is too weak."),
          ).show();
          return;
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

  bool _obscureText = true;
  bool _obscureText1 = true;
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
              Text(AppLocalizations.of(context)!.sign_up_msg,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
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
                          hintText: AppLocalizations.of(context)!.hintun_text,
                          labelText: AppLocalizations.of(context)!.labeluntext,
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
                          hintText: AppLocalizations.of(context)!.hint_text,
                          labelText: AppLocalizations.of(context)!.labeltext,
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    SizedBox(height: 50,
                      child: TextFormField(
                        obscureText: _obscureText,
                        controller: password,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please enter a password.';
                          }
                          if (!isPasswordValid(val)) {
                            return 'The password provided is too weak.';
                          }
                          return null;
                        },
                        // obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: AppLocalizations.of(context)!.hintp_text,
                            labelText: AppLocalizations.of(context)!.labelptext,
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
                    SizedBox(height: 15,),
                    SizedBox(height: 50,
                      child: TextFormField(
                        controller: Confirmpassword,
                        obscureText: _obscureText1,
                        validator: (val) {
                          if (val!.length > 50) {
                            return ("can not to be large then 50");
                          }
                          if (val != password.text) {
                            return "Passwords do not match";
                          }
                        },
                        // obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: AppLocalizations.of(context)!.hintcp_text,
                            labelText: AppLocalizations.of(context)!.labelptext,
                            suffixIcon: IconButton(
                              icon: Icon(_obscureText1 ? Icons.visibility : Icons.visibility_off),
                              onPressed: (){
                                setState(() {
                                  _obscureText1 = !_obscureText1;
                                });
                              },
                            )
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
                      child:  Container(
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
                              AppLocalizations.of(context)!.sign_in,
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
                  Expanded(child:  Center(child: Text(AppLocalizations.of(context)!.or_sign_up,style: TextStyle(color: Colors.grey),)))
                ],),
                SizedBox(height: 6,),
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
                              SnackBar(content: Text(AppLocalizations.of(context)!.success_sign_in)),

                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(AppLocalizations.of(context)!.success_sign_in)),
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
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.have_account,style: TextStyle(fontSize: 15),),
                    SizedBox(width: 5,),
                    InkWell( onTap: (){
                      Navigator.of(context).pushNamed("login");
                    },
                        child: Text(AppLocalizations.of(context)!.sign_in,style: TextStyle(color: Colors.green,fontSize: 15),))
                  ],),

              ],),),
              SizedBox(height: 10,),

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