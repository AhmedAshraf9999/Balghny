// ignore_for_file: non_constant_identifier_names

import 'package:balghny/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AccordionPage extends StatefulWidget {
  @override
  _AccordionPageState createState() => _AccordionPageState();
}

class _AccordionPageState extends State<AccordionPage> {

  // var q_one=AppLocalizations.of(context)!.q_one;
  List<Map<String, dynamic>> _items = [
    {
      'title': "what is BL3'ny ?",
      'description':
          'It is an application that helps in reaching the places of accidents, broken roads, and streets that have broken lights, and sends them to the competent authorities to solve the problem.',
    },
    {
      'title': 'what is Benefits ?',
      'description': 'The App can quickly detect disaster situations through photos or images captured by a camera, providing real-time monitoring and timely updates to the users and emergency services. This technology is cost-effective, easy to use, and can improve the accuracy of disaster detection, potentially saving lives and minimizing damage.',
    },
    {
      'title': 'How do I use the app to take a picture ?',
      'description': "1-Open the mobile app on your device and navigate to the section that allows you to take a picture of potential disasters.\n2-Once you take a picture, the app's machine learning algorithm will analyze the image to determine if it contains any signs of a disaster.\n3-If the algorithm detects a disaster, the app will display an alert message indicating the type of disaster .\n4-you can then post the picture to the app's community forum to alert others and help spread awareness of the disaster.\n5-The app may also prompt you to contact emergency services if necessary based on the severity of the disaster.",},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
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
                height: 5,
              ),
              Text(AppLocalizations.of(context)!.faqs,
                  style: TextStyle(
                      wordSpacing: 2, fontSize: 30, fontWeight: FontWeight.bold)),
                      SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  width: 400,
                  height: 350,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: _items.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = _items[index];
                      return ExpansionTile(
                        title: Text(item['title'],
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.green,
                                fontWeight: FontWeight.bold)),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(item['description'],
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                )),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
