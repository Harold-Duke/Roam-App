import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_health_care_app/doctorScreens/uploads.dart';
import 'package:flutter_health_care_app/model/doctor.dart';
import 'package:flutter_health_care_app/widgets/RoundedInputField.dart';
import 'package:flutter_health_care_app/widgets/palette.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:image_picker/image_picker.dart';

class UploadingPage extends StatefulWidget {
  const UploadingPage({Key key}) : super(key: key);

  @override
  _UploadingPageState createState() => _UploadingPageState();
}

class _UploadingPageState extends State<UploadingPage> {
  //declaring a box
  // final Box box;

  final nameController = TextEditingController();
  final fieldController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();

  bool _isLoading = false;

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: fontsColor,
        title: const Text(
          "Upload Content",
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w800,
              color: Colors.white70),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          children: [
            RoundedInputField(
              hintText: "Name of Doctor",
              icon: Icons.nature,
              field: nameController,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: Column(
                children: [
                  IconButton(
                    onPressed: getImage,
                    icon: const Icon(
                      Icons.camera,
                      color: Colors.black,
                    ),
                  ),
                  Center(
                    child: _image == null
                        ? const Text('No image selected.')
                        : Image.file(_image),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            RoundedInputField(
              hintText: "Field of specialisation",
              icon: Icons.local_activity_rounded,
              field: fieldController,
            ),
            const SizedBox(
              height: 10,
            ),
            RoundedInputField(
              hintText: "Location of Operation",
              icon: Icons.location_off,
              field: locationController,
            ),
            const SizedBox(
              height: 20,
            ),
            RoundedInputField(
              hintText: "Description",
              icon: Icons.description,
              field: descriptionController,
            ),
            const SizedBox(
              height: 20,
            ),
            upload(),
          ],
        ),
      ),
    );
  }

  //upload logic
  void addInfor() {
    print(_image.path);
    //storing key-value pairs
    Box<Doctor> hostelBox = Hive.box<Doctor>('doctorBox');
    hostelBox.add(Doctor(nameController.text, fieldController.text,
        locationController.text, descriptionController.text, _image.path));
    Navigator.of(context).pop();

    print("Info added");
  }

  upload() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(kappSecondary),
        ),
      );
    } else {
      return ElevatedButton(
        child: const Text("Add Doctor"),
        onPressed: () {
          if (nameController.text == ' ' || locationController.text == ' ') {
            Flushbar(
              message: "Empty field\s found!",
              icon:
                  const Icon(Icons.info_outline, size: 25.0, color: Colors.red),
              duration: const Duration(seconds: 3),
              leftBarIndicatorColor: Colors.red,
            )..show(context);
          } else {
            setState(() {
              _isLoading = true;
            });
            addInfor();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) => Uploads(),
                ),
                (Route<dynamic> route) => true);
          }
        },
      );
    }
  }
}
