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
  // القائمة التي ستظهر في الصفحة الرئيسية
  List<Map<String, dynamic>> displayedCountries = [
    {"name": "Saudi Arabia (KSA)", "cities": 4},
    {"name": "United Arab Emirates (UAE)", "cities": 2},
  ];

  // قائمة الدول المتاحة للاختيار (يمكنك إضافة المزيد هنا)
  final List<String> _availableCountries = [
    "Egypt",
    "Saudi Arabia (KSA)",
    "United Arab Emirates (UAE)",
    "Kuwait",
    "Qatar",
    "Bahrain",
    "Oman",
    "USA",
    "United Kingdom",
    "Germany",
    "France",
    "Canada",
    "Australia",
    "India",
    "China",
  ];

  // دالة لإظهار النافذة المنبثقة (Popup)
  void _showAddCountryDialog() {
    String? selectedCountry; // متغير لتخزين الدولة المختارة مؤقتاً

    showDialog(
      context: context,
      builder: (context) {
        // نستخدم StatefulBuilder لتحديث حالة الـ Dropdown داخل الـ Dialog فقط
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text("Select Country"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Please choose a country from the list:"),
                  const SizedBox(height: 10),
                  // قائمة الاختيار بدلاً من حقل الكتابة
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                    ),
                    hint: const Text("Choose Country"),
                    value: selectedCountry,
                    isExpanded: true, // لجعل القائمة تأخذ العرض الكامل
                    items: _availableCountries.map((String country) {
                      return DropdownMenuItem<String>(
                        value: country,
                        child: Text(country),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      // تحديث الحالة داخل الـ Dialog
                      setStateDialog(() {
                        selectedCountry = newValue;
                      });
                    },
                  ),
                ],
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
                      // إضافة الدولة للقائمة الرئيسية وتحديث الشاشة
                      setState(() {
                        displayedCountries.add({
                          "name": selectedCountry,
                          "cities": 0, // عدد افتراضي
                        });
                      });
                      Navigator.pop(context); // إغلاق النافذة
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
            return CountryCard(
              name: displayedCountries[index]['name'],
              citiesCount: displayedCountries[index]['cities'],
            );
          },
        ),
      ),
    );
  }
}

class CountryCard extends StatelessWidget {
  final String name;
  final int citiesCount;

  const CountryCard({super.key, required this.name, required this.citiesCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFDE8DF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const Icon(Icons.flag, color: Colors.deepOrange),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          "$citiesCount Cities",
          style: TextStyle(color: Colors.grey[600]),
        ),
        trailing: Icon(Icons.keyboard_arrow_down, color: Colors.grey[700]),
      ),
    );
  }
}
