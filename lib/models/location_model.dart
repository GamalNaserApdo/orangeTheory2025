class City {
  final String name;
  final bool isServiceable;
  City({required this.name, this.isServiceable = true});
}

class Country {
  final String name;
  final String code;
  final List<City> cities;

  Country({required this.name, required this.code, required this.cities});
}
