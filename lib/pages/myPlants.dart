import 'package:cipherplant/components/myPlantCard.dart';
import 'package:cipherplant/components/textAnimations.dart';
import 'package:cipherplant/database/app.dart';
import 'package:cipherplant/database/realm_instance.dart';
// import 'package:cipherplant/services/notifications_service.dart';

// import '../../security/weather_service.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:realm/realm.dart';

class Myplants extends StatefulWidget {
  const Myplants({super.key});

  @override
  State<Myplants> createState() => _MyplantsState();
}

class _MyplantsState extends State<Myplants> {
  List<UserPlant> myPlants = [];
  bool showSubtitle = false;
  List<String> subtitleLines = [];
  String? weatherSuggestion;
  double waterAmount = 200;

  void addUserPlant(
      String name, String location, int waterAmount, String imagePath) {
    realm.write(() {
      realm.add(UserPlant(
        name,
        location,
        waterAmount,
        imagePath,
      ));
    });

    setState(() {
      myPlants = realm.all<UserPlant>().toList();
    });
    SubtitleManager().show(context, [
      "Botanical protocol activated.",
      "Another survivor joins the ecosystem."
    ]);
  }

  void deleteUserPlant(UserPlant plant) {
    realm.write(() {
      realm.delete(plant);
    });

    setState(() {
      myPlants = realm.all<UserPlant>().toList();
    });
    SubtitleManager().show(context, [
      "Plant removed from system.",
      "Existence ends. Impact doesn't.",
    ]);
  }

  // void fetchWeatherSuggestion() async {
  //   try {
  //     final position = await determinePosition();
  //     final weather = await WeatherService().getWeather(
  //       position.latitude,
  //       position.longitude,
  //     );

  //     final suggestion = getWateringSuggestion(
  //       (weather?['main']['temp'] as num).toDouble(),
  //       (weather?['main']['humidity'] as num).toDouble(),
  //       weather?['rain']?['1h'] != null
  //           ? (weather?['rain']?['1h'] as num).toDouble()
  //           : null,
  //     );

  //     print("💧 Suggestion: $suggestion");

  //     setState(() {
  //       weatherSuggestion = suggestion;
  //     });
  //   } catch (e) {
  //     print('❌ Failed to get weather suggestion: $e');

  //     setState(() {
  //       weatherSuggestion = 'Unable to get location. Please check permissions.';
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // fetchWeatherSuggestion();

    // setState(() {
    myPlants = realm.all<UserPlant>().toList();
  }

  Widget build(BuildContext context) {
    TextEditingController plantNameController = TextEditingController();
    TextEditingController plantNickNameController = TextEditingController();

    return Stack(children: [
      Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff738678),
          // backgroundColor: Color(0xffA1B4A5),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true, // ✅ REQUIRED for keyboard-aware layout
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              builder: (context) => StatefulBuilder(
                builder: (context, setState) => Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context)
                        .viewInsets
                        .bottom, // ✅ Push content above keyboard
                  ),
                  child: SingleChildScrollView(
                    // ✅ Scroll if needed
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20),
                      child: Column(
                        mainAxisSize:
                            MainAxisSize.min, // ✅ Compact sheet height
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'Add a new plant',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 16),
                          TextField(
                            controller: plantNameController,
                            decoration: InputDecoration(
                              labelText: 'Plant Name',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 16),
                          TextField(
                            controller: plantNickNameController,
                            decoration: InputDecoration(
                              labelText: 'Location',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 24),
                          Text(
                            'Water Quantity: ${waterAmount.round()} ml',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Slider(
                            value: waterAmount,
                            min: 50,
                            max: 1000,
                            divisions: 19, // steps of 50
                            label: "${waterAmount.round()} ml",
                            onChanged: (value) {
                              // make sure to wrap this in setState if this code is inside a StatefulBuilder
                              setState(() {
                                waterAmount = value;
                              });
                            },
                          ),
                          SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                String plantName =
                                    plantNameController.text.trim();
                                String location =
                                    plantNickNameController.text.trim();

                                if (plantName.isNotEmpty &&
                                    location.isNotEmpty) {
                                  addUserPlant(plantName, location,
                                      waterAmount.round(), '');
                                  Navigator.pop(context);
                                }
                              },
                              child: Text('Save'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          child: Text(
            '🪴',
            style: TextStyle(fontSize: 30),
          ),
        ),
        appBar: AppBar(
          title: Text('My Plants'),
          // backgroundColor: Colors.green[200],
        ),
        body: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              // color: Colors.green[50],
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.water_drop_rounded,
                      // color: Colors.teal,
                      size: 32,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        weatherSuggestion ?? 'Unable to fetch Weather Conditon',
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
                          // color: Colors.teal[800],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Make the rest scrollable
            Expanded(
              child: myPlants.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'No plants added yet 🌱\nTap the 🪴 button to add one!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            // color: Colors.grey[700],
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: myPlants.length,
                      itemBuilder: (context, index) {
                        final plant = myPlants[index];
                        return Myplantcard(
                          water: plant.waterAmount,
                          MyPlantName: plant.plant_Name,
                          Location: plant.location,
                          onDelete: () => deleteUserPlant(plant),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    ]);
  }
}
//
