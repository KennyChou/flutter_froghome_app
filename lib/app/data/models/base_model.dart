import 'package:flutter/material.dart';

class Family {
  Family({
    required this.name,
  });
  final String name;
}

class Frog {
  Frog({
    required this.name,
    required this.family,
    this.remove = false,
    this.location = 10,
    this.subLocation = 36,
  });

  final String name;
  final int family;
  final bool remove;
  final int location;
  final int subLocation;
}

class SubLocation {
  SubLocation({
    required this.location,
    required this.name,
  });
  final int location;
  final String name;
}

class Location {
  Location({
    required this.name,
    this.color = Colors.red,
    required this.defaultSubLocation,
  });
  final String name;
  final Color color;
  final int defaultSubLocation;
}

class FrogAction {
  FrogAction({
    required this.name,
  });
  final String name;
}

class Sex {
  Sex({
    required this.name,
    required this.nickName,
    required this.color,
  });
  final String name;
  final String nickName;
  final Color color;
}
