

import 'package:balghny/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:  Padding(
          padding: const EdgeInsets.all(0),
          child: Column(children: [

            Expanded(
              child: Stack(children: [

                Container(
                  height: 300,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.green[200], // Background color
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(250),
                      bottomRight: Radius.circular(250),
                    ),
                  ),
                  child: Center(
                    child: ClipOval(
                      child: Container(
                        height: 212,
                        width: 222,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.white,
                              width: 10.0,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(
                            Radius.circular(120), // Border radius
                          ),
                        ),
                        child:
                        CircleAvatar(backgroundImage: AssetImage("assets/images/logo.jpg")),
                      ),
                    ),
                  ),
                ),

                Row(children: [
                  IconButton(onPressed: (){ Navigator.of(context).pushNamed("home");}, icon: Icon(Icons.arrow_back,color: Colors.white,))
                ],),
              ],),
            ),
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green[50], // Background color
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context)!.contact_us,
                                style:
                                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.green,
                              size: 40,
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.black,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:  [
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.green,
                                size: 40,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  AppLocalizations.of(context)!.loc_city,
                                  style:
                                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 30,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.phone_in_talk_outlined,
                                color: Colors.green,
                                size: 40,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                " 02225478",
                                style:
                                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 30,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.mark_email_unread_outlined,
                                color: Colors.green,
                                size: 40,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "hello@Bal3'ny.com",
                                style:
                                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
      // appBar: AppBar(
      //   leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
      // ),
    );
  }
}
