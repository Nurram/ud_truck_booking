import 'package:flutter/material.dart';
import 'package:ud_truck_booking/const/constants.dart';

import '../home/location/location_data.dart';

class OrderDetailScreen extends StatelessWidget {
  final Map<String, dynamic> order;
  const OrderDetailScreen({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Detail'),
        centerTitle: true,
        flexibleSpace: Image.asset(
          'assets/images/bg.webp',
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Text('Detail Kendaraan'),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[400]!, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildColumnItem(
                            'Tipe Kendaraan', order['vehicleType']),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            _buildColumnItem('Nomor Polisi', order['platNo']),
                            const SizedBox(
                              width: 16,
                            ),
                            _buildColumnItem('Kilometer', order['kilometer']),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 24, bottom: 4),
                    child: Text('Detail Pesanan'),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[400]!, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildColumnItem(
                            'Lokasi Bengkel',
                            '${order["workshop"]}\n'
                                '\n${LocationData.getLocations["address"][0]}'),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            _buildColumnItem('Tanggal', order['orderDate']),
                            const SizedBox(
                              width: 16,
                            ),
                            _buildColumnItem('Jam', order['orderHour']),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        _buildColumnItem('Jenis Pekerjaan', order['jobType']),
                        const SizedBox(
                          height: 16,
                        ),
                        _buildColumnItem('Keluhan', order['problem']),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        order['status'] == ON_PROGRESS ? 'SERVICE' : 'COMPLETE',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColumnItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Padding(padding: const EdgeInsets.only(top: 4), child: Text(value)),
      ],
    );
  }
}
