class Package {
  final String id;
  final String name;
  final String price;
  final int classesCount;
  final bool isFeatured;

  Package({
    required this.id,
    required this.name,
    required this.price,
    required this.classesCount,
    this.isFeatured = false,
  });
}
