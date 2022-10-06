class Family {
  Family({
    required this.id,
    required this.name,
  });
  final int id;
  final String name;
}

class Frog {
  Frog(
      {required this.id,
      required this.name,
      required this.family,
      this.remove = false});
  final int id;
  final String name;
  final int family;
  final bool remove;
}

class SubLocation {
  SubLocation({
    required this.id,
    required this.name,
    required this.value,
  });
  final int id;
  final String name;
  final int value;
}

class Location {
  Location({
    required this.id,
    required this.name,
    required this.children,
    required this.defaultValue,
  });
  final int id;
  final String name;
  final List<SubLocation> children;
  final int defaultValue;
}

class FrogAction {
  FrogAction({
    required this.id,
    required this.name,
  });
  final int id;
  final String name;
}

class Sex {
  Sex({
    required this.id,
    required this.name,
  });
  final int id;
  final String name;
}
