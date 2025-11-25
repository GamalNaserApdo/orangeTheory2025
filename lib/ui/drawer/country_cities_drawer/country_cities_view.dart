import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:otfksa2/ui/drawer/country_cities_drawer/country_cities_view_model.dart';
import 'package:provider/provider.dart';
import 'package:otfksa2/models/location_model.dart';

class CountriesCitiesView extends StatelessWidget {
  const CountriesCitiesView({Key? key}) : super(key: key);

  static const Color _primaryColor = Color(0xFFF37B2D);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CountriesCitiesViewModel(),
      child: Consumer<CountriesCitiesViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: const Color(0xFFF9F9F9),
            appBar: AppBar(
              title: const Text('Locations Management'),
              backgroundColor: Colors.white,
              elevation: 0.5,
              actions: [
                IconButton(
                  icon: const Icon(Iconsax.add_square, color: _primaryColor),
                  onPressed: () => viewModel.onAddLocation(context),
                  tooltip: 'Add New Location',
                ),
              ],
            ),
            body: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator(color: _primaryColor))
                : _buildLocationsList(viewModel),
          );
        },
      ),
    );
  }

  Widget _buildLocationsList(CountriesCitiesViewModel viewModel) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: viewModel.countries.length,
      itemBuilder: (context, index) {
        final country = viewModel.countries[index];
        return _CountryExpansionTile(
          country: country,
          viewModel: viewModel,
        );
      },
    );
  }
}

class _CountryExpansionTile extends StatelessWidget {
  final Country country;
  final CountriesCitiesViewModel viewModel;
  const _CountryExpansionTile({required this.country, required this.viewModel});

  static const Color _primaryColor = Color(0xFFF37B2D);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        title: Text(
          '${country.name} (${country.code})',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        subtitle: Text(
          '${country.cities.length} Cities',
          style: const TextStyle(color: Colors.grey),
        ),
        leading: const Icon(Iconsax.flag, color: _primaryColor),
        children: country.cities.map((city) {
          return _CityListTile(
            country: country,
            city: city,
            viewModel: viewModel,
          );
        }).toList(),
      ),
    );
  }
}

class _CityListTile extends StatelessWidget {
  final Country country;
  final City city;
  final CountriesCitiesViewModel viewModel;
  const _CityListTile({required this.country, required this.city, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final Color statusColor = city.isServiceable ? Colors.green.shade700 : Colors.red.shade700;

    return ListTile(
      contentPadding: const EdgeInsets.only(left: 32, right: 16),
      title: Text(city.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            city.isServiceable ? 'Serviceable' : 'Disabled',
            style: TextStyle(color: statusColor, fontWeight: FontWeight.w600, fontSize: 12),
          ),
          Switch(
            value: city.isServiceable,
            onChanged: (value) => viewModel.onToggleServiceability(country, city),
            activeColor: CountriesCitiesViewModel.primaryColor,
          ),
        ],
      ),
      onTap: () {
        viewModel.onToggleServiceability(country, city);
      },
    );
  }
}
