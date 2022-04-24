import 'package:flutter/material.dart';
import 'package:ud_truck_booking/screens/dashboard/home/product/product_detail_screen.dart';
import 'package:ud_truck_booking/widgets/elevated_button.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
        centerTitle: true,
        flexibleSpace: Image.asset(
          'assets/images/bg.webp',
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: MyElevatedButton(
              text: 'Quester',
              onPressed: () => _moveToDetail(context, 'Quester'),
              padding: const EdgeInsets.all(16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: MyElevatedButton(
              text: 'Euro 5',
              onPressed: () => _moveToDetail(context, 'Euro 5'),
              padding: const EdgeInsets.all(16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: MyElevatedButton(
              text: 'Kuzer',
              onPressed: () => _moveToDetail(context, 'Kuzer'),
              padding: const EdgeInsets.all(16),
            ),
          ),
        ],
      ),
    );
  }

  _moveToDetail(BuildContext context, String productType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(
          product: productType,
        ),
      ),
    );
  }
}
