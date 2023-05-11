import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String _text = '';
  AssetImage _image = AssetImage('assets/default.png');

  void _setText(String text) {
    setState(() {
      _text = text;
    });
  }

  void _setImage(AssetImage image) {
    setState(() {
      _image = image;
    });
  }

  void _sendToSecondPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondPage(_text, _image)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('First Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: _setText,
              decoration: InputDecoration(
                hintText: 'Enter text',
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                _setImage(AssetImage('assets/image.png'));
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: _image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _sendToSecondPage,
              child: Text('Send to Second Page'),
            ),
          ],
        ),
      ),
    );
  }
}

class Post {
  final String text;
  final AssetImage image;

  Post({required this.text, required this.image});
}

class SecondPage extends StatefulWidget {
  final String text;
  final AssetImage image;

  SecondPage(this.text, this.image);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  List<Post> _list = [];

  void _addItem() {
    setState(() {
      _list.add(Post(text: widget.text, image: widget.image));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Second Page')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _list.length,
              itemBuilder: (context, index) {
                final post = _list[index];
                return ListTile(
                  leading: CircleAvatar(backgroundImage: post.image),
                  title: Text(post.text),
                );
              },
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _addItem,
            child: Text('Add Item'),
          ),
        ],
      ),
    );
  }
}
