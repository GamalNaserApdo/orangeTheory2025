import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Locations Management App',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: const LocationsScreen(),
    );
  }
}

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  // هيكل البيانات: يخزن اسم الدولة وقائمة المدن المضافة فعلياً
  // ملاحظة: قمنا بتعريف المدن كـ List<String> مباشرة لتجنب مشاكل النوع
  List<Map<String, dynamic>> displayedCountries = [
    {
      "name": "Saudi Arabia (KSA)",
      "cities": ["Riyadh", "Jeddah"],
      "isExpanded": false,
    },
    {
      "name": "United Arab Emirates (UAE)",
      "cities": ["Dubai"],
      "isExpanded": false,
    },
  ];

  // قاعدة البيانات: كل دولة وما يقابلها من مدن متاحة
  final Map<String, List<String>> _countryCitiesData = {
    "Egypt": ["Cairo", "Alexandria", "Giza", "Sharm El Sheikh", "Hurghada"],
    "Saudi Arabia (KSA)": [
      "Riyadh",
      "Jeddah",
      "Mecca",
      "Medina",
      "Dammam",
      "Khobar",
    ],
    "United Arab Emirates (UAE)": [
      "Dubai",
      "Abu Dhabi",
      "Sharjah",
      "Ajman",
      "Fujairah",
    ],
    "Kuwait": ["Kuwait City", "Al Jahra", "Hawalli", "Farwaniyah"],
    "Qatar": ["Doha", "Al Rayyan", "Al Wakrah"],
    "Bahrain": ["Manama", "Riffa"],
  };

  // 1. دالة إضافة دولة جديدة
  void _showAddCountryDialog() {
    String? selectedCountry;
    // قائمة الدول المتاحة للاختيار
    List<String> availableCountriesList = _countryCitiesData.keys.toList();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text("Select Country"),
              content: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Choose Country",
                ),
                value: selectedCountry,
                isExpanded: true,
                items: availableCountriesList.map((String country) {
                  return DropdownMenuItem<String>(
                    value: country,
                    child: Text(country),
                  );
                }).toList(),
                onChanged: (val) {
                  setStateDialog(() => selectedCountry = val);
                },
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                  ),
                  onPressed: () {
                    if (selectedCountry != null) {
                      setState(() {
                        if (!displayedCountries.any(
                          (element) => element['name'] == selectedCountry,
                        )) {
                          // إضافة الدولة بقائمة مدن فارغة
                          displayedCountries.add({
                            "name": selectedCountry,
                            "cities": <String>[],
                            "isExpanded": false,
                          });
                        }
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    "Add",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // 2. دالة إضافة مدينة
  void _showAddCityDialog(int countryIndex) {
    String countryName = displayedCountries[countryIndex]['name'];

    // الحل للخطأ: نأكد على نوع القائمة لتجنب مشاكل الـ JSArray/TypeError
    List<String> currentCities =
        (displayedCountries[countryIndex]['cities'] as List).cast<String>();

    // جلب قائمة المدن المتاحة للدولة
    List<String> allSpecificCities = _countryCitiesData[countryName] ?? [];

    // تصفية المدن: إظهار فقط التي لم يتم إضافتها بعد
    List<String> availableCities = allSpecificCities
        .where((city) => !currentCities.contains(city))
        .toList();

    String? selectedCity;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text("Add City to $countryName"),
              content: availableCities.isEmpty
                  ? Text(
                      "All available cities in $countryName have been added, or the city data is missing.",
                    )
                  : DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Select City",
                      ),
                      value: selectedCity,
                      isExpanded: true,
                      items: availableCities.map((String city) {
                        return DropdownMenuItem<String>(
                          value: city,
                          child: Text(city),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setStateDialog(() => selectedCity = val);
                      },
                    ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                if (availableCities.isNotEmpty)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                    ),
                    onPressed: () {
                      if (selectedCity != null) {
                        setState(() {
                          // إضافة المدينة للقائمة وتحديث الشاشة
                          displayedCountries[countryIndex]['cities'].add(
                            selectedCity!,
                          );
                          displayedCountries[countryIndex]['isExpanded'] =
                              true; // نفتح الكارت لعرض المدينة الجديدة
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Added $selectedCity to $countryName",
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Add",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          "Locations Management",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          // زر الإضافة (+) في شريط التطبيق
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: _showAddCountryDialog,
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: displayedCountries.length,
          itemBuilder: (context, index) {
            return ExpandableCountryCard(
              name: displayedCountries[index]['name'],
              // التأكد من النوع مرة أخرى لتمريره للـ Widget
              cities: (displayedCountries[index]['cities'] as List)
                  .cast<String>(),
              isExpanded: displayedCountries[index]['isExpanded'],

              onExpansionChanged: (isExpanded) {
                setState(() {
                  displayedCountries[index]['isExpanded'] = isExpanded;
                });
              },

              onAddCity: () => _showAddCityDialog(index),
            );
          },
        ),
      ),
    );
  }
}

// ويدجت تصميم الكارت القابل للتوسيع (ExpansionTile)
class ExpandableCountryCard extends StatelessWidget {
  final String name;
  final List<String> cities;
  final bool isExpanded;
  final Function(bool) onExpansionChanged;
  final VoidCallback onAddCity;

  const ExpandableCountryCard({
    super.key,
    required this.name,
    required this.cities,
    required this.isExpanded,
    required this.onExpansionChanged,
    required this.onAddCity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: const Color(0xFFFDE8DF),
      child: ExpansionTile(
        initiallyExpanded: isExpanded,
        onExpansionChanged: onExpansionChanged,

        // الرأس (Header)
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          "${cities.length} Cities",
          style: TextStyle(color: Colors.grey[600]),
        ),
        leading: const Icon(Icons.flag, color: Colors.deepOrange),
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        trailing: Icon(
          isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
          color: Colors.grey[700],
        ),

        // المحتوى الذي يظهر عند فتح الكارت
        children: [
          const Divider(height: 1, color: Color(0xFFFCCBBD)),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // عرض قائمة المدن المضافة
                if (cities.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "No cities added yet. Click 'Add New City' below.",
                    ),
                  )
                else
                  ...cities
                      .map(
                        (city) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 18,
                                color: Colors.deepOrange.shade400,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                city,
                                style: TextStyle(color: Colors.grey[800]),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),

                const SizedBox(height: 10),

                // زر إضافة مدينة جديدة
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: onAddCity,
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text("Add New City"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.deepOrange,
                      side: const BorderSide(color: Colors.deepOrange),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
