import 'package:flutter/material.dart';
import 'package:otfksa2/models/location_model.dart';

class CountriesCitiesViewModel extends ChangeNotifier {
  static const Color primaryColor = Color(0xFFF37B2D);

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<Country> _countries = [];
  List<Country> get countries => _countries;

  CountriesCitiesViewModel() {
    _fetchLocations();
  }

  Future<void> _fetchLocations() async {
    _isLoading = true;
    notifyListeners();

    // محاكاة جلب البيانات
    await Future.delayed(const Duration(milliseconds: 700));

    _countries = [
      Country(
        name: 'Saudi Arabia',
        code: 'KSA',
        cities: [
          City(name: 'Riyadh', isServiceable: true),
          City(name: 'Jeddah', isServiceable: true),
          City(name: 'Dammam', isServiceable: false),
          City(name: 'Khobar', isServiceable: false),
        ],
      ),
      Country(
        name: 'United Arab Emirates',
        code: 'UAE',
        cities: [
          City(name: 'Dubai', isServiceable: true),
          City(name: 'Abu Dhabi', isServiceable: true),
        ],
      ),
    ];

    _isLoading = false;
    notifyListeners();
  }

  void onAddLocation(BuildContext context) {
    // CountriesCitiesNavigator.goToAddLocation(context);
    print('ViewModel: Navigating to Add New Location');
  }

  void onToggleServiceability(Country country, City city) {
    // هنا يكون لوجيك تحديث حالة المدينة في قاعدة البيانات
    print('Toggling serviceability for ${city.name}, ${country.name}');
    // ... logic to update state locally and via API
    notifyListeners(); // لتحديث الـ UI بعد التغيير
  }
}
