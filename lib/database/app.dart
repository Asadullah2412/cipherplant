// import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

part 'app.realm.dart';

@RealmModel()
class _Plant {
  late String plant_Name;
  late String scientific_name;
  late String cultivation;
  late String about;
  late String imagePath;
} // remove ❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌😵😵😵😵😵😵😵😵😵

// var config = Configuration.local([Plant.schema]);
// final realmInstance = Realm(config);
@RealmModel()
class _UserPlant {
  late String plant_Name;
  late String location;
  late int waterAmount;
  late String imagePath;
}
