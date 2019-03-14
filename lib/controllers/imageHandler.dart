import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

/// On which URI is the backend and the corresponding target route located?
/// Please update if necessary
final String BACKEND_URI =
    "http://10.0.0.22:8080/MalignantBirthmarkRecognition_war_exploded/analyze";

/// Load camera view to save created image into File object.
Future<File> chooseCamera() async {
  return await ImagePicker.pickImage(source: ImageSource.camera);
}

/// Load gallery to select a image from there.
Future<File> chooseGallery() async {
  return await ImagePicker.pickImage(source: ImageSource.gallery);
}

/// Upload selected image to server and return result to view.
Future<String> analyze(File file) async {
  if (file == null) return "Error: No image selected.";

  String base64Image = base64Encode(file.readAsBytesSync());
  print("BASE64= "+base64Image);

  http.Response r = await http.post(
    BACKEND_URI,
    body: {
      "image": base64Image,
    },
  );

  print("STATUS: "+r.statusCode.toString());
  print("BODY: "+r.body.toString());
  return r.body.toString();
}
