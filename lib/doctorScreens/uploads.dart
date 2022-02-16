import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_health_care_app/model/doctor.dart';
import 'package:flutter_health_care_app/widgets/palette.dart';
import 'package:hive_flutter/adapters.dart';

class Uploads extends StatefulWidget {
  const Uploads({Key key}) : super(key: key);

  @override
  _UploadsState createState() => _UploadsState();
}

class _UploadsState extends State<Uploads> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: fontsColor,
        title: const Text(
          "Uploaded Doctor",
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w800,
              color: Colors.white70),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
          valueListenable: Hive.box<Doctor>('doctorBox').listenable(),
          builder: (context, Box<Doctor> box, _) {
            if (box.values.isEmpty) {
              return const Center(
                child: Text("Empty Doctor content"),
              );
            } else {
              return ListView.builder(
                  itemCount: box.values.length,
                  itemBuilder: (context, index) {
                    Doctor currentDoctor = box.getAt(index);
                    print(currentDoctor.image);
                    return Container(
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(13)),
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            child: Image.file(
                              File(currentDoctor.image),
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(currentDoctor.name),
                        subtitle: Column(
                          children: [
                            Text(currentDoctor.type),
                            Text(currentDoctor.location),
                            Text(currentDoctor.description)
                          ],
                        ),
                        trailing: IconButton(
                            onPressed: () async {
                              await box.deleteAt(index);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
