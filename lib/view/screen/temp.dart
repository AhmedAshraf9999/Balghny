import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:balghny/view/screen/result.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Cam extends StatefulWidget {
  const Cam({Key? key}) : super(key: key);

  @override
  State<Cam> createState() => _CamState();
}

class _CamState extends State<Cam> {

  var myPhotoUrl = "";

  String result = "";
  File? _image;
  var image;
  String? _imagepath;
  String i = "assets/images/my.jpg";
  late ImagePicker imagePicker;

  //TODO declare detector
  dynamic objectDetector;

  late List<DetectedObject> objects;




  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
    //TODO initialize detector
    createObjectDetection();
  }

  @override
  void dispose() {
    super.dispose();
    objectDetector.close();
  }



  //final picker = ImagePicker();

  Future<void> _pickImageAndUpload() async {
    // final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    var pickedFile = _image.toString();
    if (pickedFile != null) {
      final storageRef = FirebaseStorage.instance.ref()
          .child('profile_images')
          .child(FirebaseAuth.instance.currentUser!.uid + '.jpg');

      await storageRef.putFile(File(pickedFile as String));

      final photoUrl = await storageRef.getDownloadURL();
      setState(() {
        myPhotoUrl = photoUrl;
      });
    }
  }
  //TODO capture image using camera
  late File _image1;
  final picker = ImagePicker();
  Future<void> getImage1() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image1 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
  /* void getImage({required ImageSource source}) async {
    XFile? file = await ImagePicker().pickImage(
          //file = await ImagePicker().pickImage(
       source: source,
       // source: ImageSource.camera,
        maxWidth: 640,
        maxHeight: 480,
        imageQuality: 70 //0 - 100
    );
    if (file?.path != null) {
      setState(() {
        _image = File(file!.path);
        doObjectDetection();
      });
    }
  }*/

  //TODO face detection code here



  Future<String> _getModel(String assetPath) async {
    if (Platform.isAndroid) {
      return 'flutter_assets/$assetPath';
    }
    final path = '${(await getApplicationSupportDirectory()).path}/$assetPath';
    await Directory(dirname(path)).create(recursive: true);
    final file = File(path);
    if (!await file.exists()) {
      final byteData = await rootBundle.load(assetPath);
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    }
    return file.path;
  }

  createObjectDetection() async {
    final modelPath = await _getModel('assets/ml/Fire_Best_model.tflite');
    final options = LocalObjectDetectorOptions(
        modelPath: modelPath,
        classifyObjects: true,
        multipleObjects: true,
        mode: DetectionMode.single);
    objectDetector = ObjectDetector(options: options);
  }

  doObjectDetection() async {
    result = "";
    final InputImage inputImage = InputImage.fromFile(_image!);
    objects = await objectDetector.processImage(inputImage);

    drawRectanglesAroundObjects();
  }

  //TODO draw rectangles
  drawRectanglesAroundObjects() async {
    image = await _image?.readAsBytes();
    image = await decodeImageFromList(image);
    setState(() {
      image;
      objects;
      result;
      print(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? const Text('No image selected.')
                : Image.file(_image1),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Res(img: _image1),
                  ),
                );
              },
              child: const Text('Send Image to Second Class'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage1,
        tooltip: 'Take a Photo',
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }

  _save() async {
    var response = await Dio()
        .get(_image!.path, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 80,
        name: "hello");
    print(result);
  }

  void pickimage() async {
    XFile? pickedFile =
    await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      doObjectDetection();
    }
  }

  save2(path) async {
    SharedPreferences saveimage = await SharedPreferences.getInstance();
    saveimage.setString("imagepath", path);
  }

  Load() async {
    SharedPreferences saveimage = await SharedPreferences.getInstance();
    setState(() {
      _imagepath = saveimage.getString("imagepath");
    });
  }

  s() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    GallerySaver.saveImage(image.path);
  }
}

class ObjectPainter extends CustomPainter {
  List<DetectedObject> objectList;
  dynamic imageFile;

  ObjectPainter({required this.objectList, @required this.imageFile});

  @override
  void paint(Canvas canvas, Size size) {
    if (imageFile != null) {
      canvas.drawImage(imageFile, Offset.zero, Paint());
    }
    Paint p = Paint();
    p.color = Colors.red;
    p.style = PaintingStyle.stroke;
    p.strokeWidth = 4;

    for (DetectedObject rectangle in objectList) {
      canvas.drawRect(rectangle.boundingBox, p);
      var list = rectangle.labels;
      for (Label label in list) {
        print("${label.text}   ${label.confidence.toStringAsFixed(2)}");
        TextSpan span = TextSpan(
            text: label.text,
            style: const TextStyle(
                fontSize: 25, color: Colors.blue, fontWeight: FontWeight.w300));
        TextPainter tp = TextPainter(
            text: span,
            textAlign: TextAlign.left,
            textDirection: TextDirection.ltr);
        tp.layout();
        tp.paint(canvas,
            Offset(rectangle.boundingBox.left, rectangle.boundingBox.top));
        break;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
