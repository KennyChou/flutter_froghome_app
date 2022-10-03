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
