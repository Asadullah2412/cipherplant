// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Plant extends _Plant with RealmEntity, RealmObjectBase, RealmObject {
  Plant(
    String plant_Name,
    String scientific_name,
    String cultivation,
    String about,
    String imagePath,
  ) {
    RealmObjectBase.set(this, 'plant_Name', plant_Name);
    RealmObjectBase.set(this, 'scientific_name', scientific_name);
    RealmObjectBase.set(this, 'cultivation', cultivation);
    RealmObjectBase.set(this, 'about', about);
    RealmObjectBase.set(this, 'imagePath', imagePath);
  }

  Plant._();

  @override
  String get plant_Name =>
      RealmObjectBase.get<String>(this, 'plant_Name') as String;
  @override
  set plant_Name(String value) =>
      RealmObjectBase.set(this, 'plant_Name', value);

  @override
  String get scientific_name =>
      RealmObjectBase.get<String>(this, 'scientific_name') as String;
  @override
  set scientific_name(String value) =>
      RealmObjectBase.set(this, 'scientific_name', value);

  @override
  String get cultivation =>
      RealmObjectBase.get<String>(this, 'cultivation') as String;
  @override
  set cultivation(String value) =>
      RealmObjectBase.set(this, 'cultivation', value);

  @override
  String get about => RealmObjectBase.get<String>(this, 'about') as String;
  @override
  set about(String value) => RealmObjectBase.set(this, 'about', value);

  @override
  String get imagePath =>
      RealmObjectBase.get<String>(this, 'imagePath') as String;
  @override
  set imagePath(String value) => RealmObjectBase.set(this, 'imagePath', value);

  @override
  Stream<RealmObjectChanges<Plant>> get changes =>
      RealmObjectBase.getChanges<Plant>(this);

  @override
  Stream<RealmObjectChanges<Plant>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Plant>(this, keyPaths);

  @override
  Plant freeze() => RealmObjectBase.freezeObject<Plant>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'plant_Name': plant_Name.toEJson(),
      'scientific_name': scientific_name.toEJson(),
      'cultivation': cultivation.toEJson(),
      'about': about.toEJson(),
      'imagePath': imagePath.toEJson(),
    };
  }

  static EJsonValue _toEJson(Plant value) => value.toEJson();
  static Plant _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'plant_Name': EJsonValue plant_Name,
        'scientific_name': EJsonValue scientific_name,
        'cultivation': EJsonValue cultivation,
        'about': EJsonValue about,
        'imagePath': EJsonValue imagePath,
      } =>
        Plant(
          fromEJson(plant_Name),
          fromEJson(scientific_name),
          fromEJson(cultivation),
          fromEJson(about),
          fromEJson(imagePath),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Plant._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, Plant, 'Plant', [
      SchemaProperty('plant_Name', RealmPropertyType.string),
      SchemaProperty('scientific_name', RealmPropertyType.string),
      SchemaProperty('cultivation', RealmPropertyType.string),
      SchemaProperty('about', RealmPropertyType.string),
      SchemaProperty('imagePath', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class UserPlant extends _UserPlant
    with RealmEntity, RealmObjectBase, RealmObject {
  UserPlant(
    String plant_Name,
    String location,
    int waterAmount,
    String imagePath,
  ) {
    RealmObjectBase.set(this, 'plant_Name', plant_Name);
    RealmObjectBase.set(this, 'location', location);
    RealmObjectBase.set(this, 'waterAmount', waterAmount);
    RealmObjectBase.set(this, 'imagePath', imagePath);
  }

  UserPlant._();

  @override
  String get plant_Name =>
      RealmObjectBase.get<String>(this, 'plant_Name') as String;
  @override
  set plant_Name(String value) =>
      RealmObjectBase.set(this, 'plant_Name', value);

  @override
  String get location =>
      RealmObjectBase.get<String>(this, 'location') as String;
  @override
  set location(String value) => RealmObjectBase.set(this, 'location', value);

  @override
  int get waterAmount => RealmObjectBase.get<int>(this, 'waterAmount') as int;
  @override
  set waterAmount(int value) => RealmObjectBase.set(this, 'waterAmount', value);

  @override
  String get imagePath =>
      RealmObjectBase.get<String>(this, 'imagePath') as String;
  @override
  set imagePath(String value) => RealmObjectBase.set(this, 'imagePath', value);

  @override
  Stream<RealmObjectChanges<UserPlant>> get changes =>
      RealmObjectBase.getChanges<UserPlant>(this);

  @override
  Stream<RealmObjectChanges<UserPlant>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<UserPlant>(this, keyPaths);

  @override
  UserPlant freeze() => RealmObjectBase.freezeObject<UserPlant>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'plant_Name': plant_Name.toEJson(),
      'location': location.toEJson(),
      'waterAmount': waterAmount.toEJson(),
      'imagePath': imagePath.toEJson(),
    };
  }

  static EJsonValue _toEJson(UserPlant value) => value.toEJson();
  static UserPlant _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'plant_Name': EJsonValue plant_Name,
        'location': EJsonValue location,
        'waterAmount': EJsonValue waterAmount,
        'imagePath': EJsonValue imagePath,
      } =>
        UserPlant(
          fromEJson(plant_Name),
          fromEJson(location),
          fromEJson(waterAmount),
          fromEJson(imagePath),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(UserPlant._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, UserPlant, 'UserPlant', [
      SchemaProperty('plant_Name', RealmPropertyType.string),
      SchemaProperty('location', RealmPropertyType.string),
      SchemaProperty('waterAmount', RealmPropertyType.int),
      SchemaProperty('imagePath', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
