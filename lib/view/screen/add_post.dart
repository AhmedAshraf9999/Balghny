import 'package:flutter/material.dart';

class Add_post extends StatelessWidget {
  const Add_post({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Center(child: Text('Create New Post')),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50,),
              Center(
                child: Stack(
                  children: [

                    Center(child:
                    Image.asset("assets/images/my.jpg",width: 150,
                      height: 150,
                      fit:BoxFit.fill,),)
                    
                   /* Container(
                        margin: EdgeInsets.only(left: 45,top: 70),
                        child: IconButton(onPressed: (){},
                        icon: Icon(Icons.add,color: Colors.green),)),
                    Container(
                        margin: EdgeInsets.only(left: 33,top: 40),
                        child: Image.asset("assets/images/Add photo.png")),
                    Image.asset("assets/images/Rectangle 1027.png"),*/
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Column(
                children: [
                  Row(
                    children: [
                       Container(
                           margin: EdgeInsets.only(left: 20),
                           child: Text("Title")),
                    ],
                  ),
                  SizedBox(height: 5),
                  SizedBox(width: 350,
                    child: TextFormField(
                        decoration: InputDecoration(border: OutlineInputBorder())),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text("Description")),
                    ],
                  ),
                  SizedBox(height: 5),
                  SizedBox(width: 350,
                    child: TextFormField(
                        decoration: InputDecoration(border: OutlineInputBorder())),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)))),
                    child: Text(
                      'Post',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
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
