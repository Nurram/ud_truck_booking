import 'package:flutter/material.dart';
import 'package:ud_truck_booking/screens/dashboard/home/location/location_data.dart';

class LocationDetailScreen extends StatelessWidget {
  final int locationIndex;

  const LocationDetailScreen({Key? key, required this.locationIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = LocationData.getLocations;

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
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
        child: Column(
          children: [
            Text(
              data['name'][locationIndex],
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                data['branch'][locationIndex],
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Image.asset(
                data['images'][locationIndex],
                width: MediaQuery.of(context).size.width * .75,
              ),
            ),
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text('Official Dealer')),
            Text(data['address'][locationIndex]),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 16, bottom: 4),
              child: const Text('Fax'),
            ),
            SizedBox(
              width: double.infinity,
              child: Text(data['fax'][locationIndex]),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 16, bottom: 4),
              child: const Text('Phone'),
            ),
            SizedBox(
              width: double.infinity,
              child: Text(data['phone'][locationIndex]),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 16, bottom: 4),
              child: const Text('24H Road Support'),
            ),
            SizedBox(
              width: double.infinity,
              child: Text(data['roadSupport'][locationIndex]),
            ),
          ],
        ),
      ),
    );
  }
}
