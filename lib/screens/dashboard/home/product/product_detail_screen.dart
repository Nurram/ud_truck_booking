import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ud_truck_booking/screens/dashboard/home/product/product_data.dart';

class ProductDetailScreen extends StatefulWidget {
  final String product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _currentCarouselIndex = 0;
  Map<String, dynamic> data = {};

  @override
  void initState() {
    switch (widget.product) {
      case 'Quester':
        data = ProductData.quester;
        break;
      case 'Euro 5':
        data = ProductData.euro5;
        break;
      case 'Kuzer':
        data = ProductData.kuzer;
        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog Product'),
        centerTitle: true,
        flexibleSpace: Image.asset(
          'assets/images/bg.webp',
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 24, 0, 32),
              child: Text(
                'Tipe ${widget.product}',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 24),
              ),
            ),
            Center(
              child: Text(
                'Quester ${data["model"][_currentCarouselIndex]}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Center(
              child: Text(
                data['type'][_currentCarouselIndex],
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            _buildImageSlider(data['images']),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * .75,
                padding: const EdgeInsets.only(top: 16),
                child: Table(children: [
                  TableRow(children: [
                    const Text(
                      'Power (hp):',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      data['power'][_currentCarouselIndex],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ]),
                  TableRow(children: [
                    const Text(
                      'WB (m):',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      data['wb'][_currentCarouselIndex],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ]),
                  TableRow(children: [
                    const Text(
                      'Usage:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      data['function'][_currentCarouselIndex],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ]),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildImageSlider(List<String> items) {
    final screenSize = MediaQuery.of(context).size;
    final List<Widget> itemWdiget = items
        .map(
          (e) => _buildImage(screenSize, e),
        )
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          CarouselSlider(
            items: itemWdiget,
            options: CarouselOptions(
                viewportFraction: 1.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentCarouselIndex = index;
                  });
                }),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: items.asMap().entries.map((entry) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).primaryColor.withOpacity(
                      _currentCarouselIndex == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(Size screenSize, String imagePath) {
    return Image.asset(
      imagePath,
      fit: BoxFit.cover,
    );
  }
}
