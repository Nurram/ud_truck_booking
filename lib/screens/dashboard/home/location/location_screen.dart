import 'package:flutter/material.dart';
import 'package:ud_truck_booking/screens/dashboard/home/location/location_data.dart';
import 'package:ud_truck_booking/screens/dashboard/home/location/location_detail_screen.dart';

class LocationScreen extends StatelessWidget {
  LocationScreen({Key? key}) : super(key: key);

  final _locationsData = LocationData.getLocations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lokasi Cabang'),
        centerTitle: true,
        flexibleSpace: Image.asset(
          'assets/images/bg.webp',
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
            itemCount: _locationsData['images'].length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 300,
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        LocationDetailScreen(locationIndex: index),
                  ),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      _locationsData['images'][index],
                      width: 300,
                      height: 190,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 4),
                      child: Text(
                        _locationsData['name'][index],
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      _locationsData['branch'][index],
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
