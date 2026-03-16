import 'package:cipherplant/pages/myPlants.dart';
import 'package:cipherplant/pages/plantHealth.dart';
import 'package:cipherplant/pages/settings.dart';
import 'package:flutter/material.dart';

class AltHomePage extends StatefulWidget {
  const AltHomePage({super.key});

  @override
  State<AltHomePage> createState() => _AltHomePageState();
}

class _AltHomePageState extends State<AltHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cipherplant'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Settings(),
                ),
              );
            },
            icon: Icon(
              Icons.settings_suggest_rounded,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40),

              // Intro Text
              Text(
                "Welcome to CipherPlant — your smart assistant for plant care! Easily manage your plants with custom reminders and care logs, and keep them healthy with our powerful disease and health predictor. Whether you're growing indoors or outdoors, our app helps you stay on top of your plant's needs and spot problems before they spread.",
                style: TextStyle(fontSize: 20),
              ),

              SizedBox(height: 60),

              // Feature Cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Myplants()),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 6,
                        // color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.local_florist,
                                size: 48,
                                // color: Colors.green[600],
                              ),
                              SizedBox(height: 12),
                              Text(
                                'Manage Plants',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  // color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Set reminders, track growth, and keep your plants happy with ease.\nExplore →',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  // color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Flexible(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Planthealth()),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 6,
                        // color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.health_and_safety,
                                size: 48,
                                // color: Colors.green[600],
                              ),
                              SizedBox(height: 12),
                              Text(
                                'Diagnose & Protect',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  // color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Diagnose early. Protect your plants. Grow with confidence.\nExplore →',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  // color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 80),

              // Contact Section
              Center(
                child: Column(
                  children: [
                    Text(
                      'Reach us at',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 4),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'CipherPlant@gmail.com',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
