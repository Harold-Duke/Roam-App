import 'package:flutter/material.dart';
import 'package:flutter_health_care_app/config/route.dart';
import 'package:flutter_health_care_app/model/doctor.dart';
import 'package:flutter_health_care_app/theme/theme.dart';
import 'package:flutter_health_care_app/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/adapters.dart';
import 'firebase_options.dart';

Future<void> main() async {
  //initializing firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //hivedb details
  //registering the adapter
  Hive.registerAdapter<Doctor>(DoctorAdapter());
  //initialize hive
  await Hive.initFlutter();
  //open the hostelBox
  await Hive.openBox<Doctor>('doctorBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ROAM Health Care App',
      theme: AppTheme.lightTheme,
      home: WelcomeScreen(),
      routes: Routes.getRoute(),
      onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
    );
  }
}
