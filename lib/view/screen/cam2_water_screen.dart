import 'dart:io';

import 'package:balghny/l10n/app_localizations.dart';
import 'package:balghny/view/screen/add_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';



class Cam2 extends StatefulWidget {
  const Cam2({Key? key}) : super(key: key);

  @override
  State<Cam2> createState() => _Cam2State();
}

class _Cam2State extends State<Cam2> {

  //var myPhotoUrl = "";
  var img_url;
  String result = "";
  File? _image1;
  var image ;
  // String? _imagepath;
  // String i = "assets/images/my.jpg";
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


  //TODO capture image using camera
  // late File _image1;
  final picker = ImagePicker();
  Future<void> getImage1() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera
        ,   maxWidth: 640,
        maxHeight: 480,
        imageQuality: 80 //0 - 100

    );

    if (pickedFile != null) {
      var imagename = basename(pickedFile.path) ;
      setState(() {
        _image1 = File(pickedFile.path);
        doObjectDetection();
      });
    }
    else {
      print('No image selected.');
    }



  }




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
    final modelPath = await _getModel('assets/ml/water_model.tflite');
    final options = LocalObjectDetectorOptions(
        modelPath: modelPath,
        classifyObjects: true,
        multipleObjects: true,
        mode: DetectionMode.single);
    objectDetector = ObjectDetector(options: options);
  }

  doObjectDetection() async {
    result = "";
    final InputImage inputImage = InputImage.fromFile(_image1!);
    objects = await objectDetector.processImage(inputImage);

    drawRectanglesAroundObjects();
  }

  //TODO draw rectangles
  drawRectanglesAroundObjects() async {
    image = await _image1?.readAsBytes();
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
        title:  Text(AppLocalizations.of(context)!.image_picker),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image != null
                ? Container(
                width: 640,
                height: 480,
                //  height: 300,
                margin: const EdgeInsets.only(
                  top: 45,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                      image: FileImage(_image1!), fit: BoxFit.cover),
                  border: Border.all(width: 8, color: Colors.black),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child:
                Center(
                  child: FittedBox(
                    child: SizedBox(
                      width: image.width.toDouble(),
                      height: image.height.toDouble(),
                      child: CustomPaint(
                        painter: ObjectPainter(
                            objectList: objects, imageFile: image),
                      ),
                    ),
                  ),
                ))
                : Expanded(
              child: Container(
                width: 640,
                height: 480,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(width: 8, color: Colors.black12),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child:  Text(
                  AppLocalizations.of(context)!.image_show,
                  style: TextStyle(fontSize: 26),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        getImage1();
                        // uploadFile(_image1!);
                      },
                      child:  Text(AppLocalizations.of(context)!.capture_image,
                          style: TextStyle(fontSize: 18))),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        if(result == "Fire-Disaster" || result != "Non Damage"){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Add_post(img: _image1!, title:"Fire-Disaster"),
                            ),
                          );
                        }

                        else{

                          AlertDialog alert = AlertDialog(
                            title: Text("Fake Image"),
                            content: Text("This Image Not Damage."),
                            actions: [

                            ],
                          );

                          // show the dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );



                        }


                      },
                      child:  Text(AppLocalizations.of(context)!.send,
                          style: TextStyle(fontSize: 18))

                  ),
                ),

              ],
            ),
          ],
        ),
      ),

    );
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
