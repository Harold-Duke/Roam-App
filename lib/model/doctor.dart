import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'doctor.g.dart';

@HiveType(typeId: 0)
class Doctor {
  @HiveField(0)
  String name;
  @HiveField(1)
  String type;
  @HiveField(2)
  String location;
  @HiveField(3)
  String description;
  @HiveField(4)
  var image;
  Doctor(this.name, this.type, this.location, this.description, this.image);
}
