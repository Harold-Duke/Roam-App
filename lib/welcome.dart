import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_health_care_app/doctorScreens/manager_auth.dart';
import 'package:flutter_health_care_app/patientScreens/authgate.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        color: Colors.blue[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Center(
              child: GlowText(
                "WELCOME!!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    wordSpacing: 5),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            const Text("Doctor"),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => ManagerAuthGate()),
                      (route) => true);
                },
                child: const GlowIcon(
                  Icons.settings,
                  size: 80,
                  blurRadius: 9,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            const Text("Patient"),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => AuthGate()),
                      (route) => true);
                },
                child: const GlowIcon(
                  Icons.verified_user,
                  size: 80,
                  blurRadius: 9,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
