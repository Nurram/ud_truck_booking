import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ud_truck_booking/const/utils.dart';
import 'package:ud_truck_booking/screens/dashboard/home/booking/booking_screen.dart';
import 'package:ud_truck_booking/screens/dashboard/home/home_presenter.dart';
import 'package:ud_truck_booking/screens/dashboard/home/location/location_screen.dart';
import 'package:ud_truck_booking/screens/dashboard/home/news/news_screen.dart';
import 'package:ud_truck_booking/screens/dashboard/home/product/product_screen.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> implements HomeContract {
  late HomePresenter _presenter;

  final List<String> _headerImages = [];
  final List<String> _promoImages = [];
  int _currentCarouselIndex = 0;

  @override
  void initState() {
    _presenter = HomePresenter(contract: this);
    Future.delayed(Duration.zero, () {
      _presenter.getHeaderImages(context);
      _presenter.gerPromoImages(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/bg.webp',
          width: double.infinity,
          height: MediaQuery.of(context).size.height * .2,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageSlider(),
                const SizedBox(
                  height: 40,
                ),
                _buildHorizontalMenu(),
                const SizedBox(
                  height: 32,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Promo Menarik',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                _buildPromoList()
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildImageSlider() {
    final screenSize = MediaQuery.of(context).size;

    final items = _headerImages.map((e) => _buildImage(screenSize, e)).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          CarouselSlider(
            items: items,
            options: CarouselOptions(
                aspectRatio: 2.0,
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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          imagePath,
          fit: BoxFit.cover,
          width: screenSize.width,
        ),
      ),
    );
  }

  Widget _buildHorizontalMenu() {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMenu(theme, 'Booking', Icons.local_taxi, const BookingScreen()),
          _buildMenu(
              theme, 'Produk', Icons.card_giftcard, const ProductScreen()),
          _buildMenu(theme, 'Berita', Icons.newspaper, const NewsScreen()),
          _buildMenu(theme, 'Lokasi', Icons.person_pin, LocationScreen())
        ],
      ),
    );
  }

  Widget _buildMenu(
      ThemeData theme, String text, IconData icon, Widget destination) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * .18,
        height: MediaQuery.of(context).size.width * .18,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: theme.primaryColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 32,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPromoList() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: MediaQuery.of(context).size.height * .2,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _promoImages.length,
          itemBuilder: (context, index) {
            return _buildPromoImage(_promoImages[index]);
          }),
    );
  }

  Widget _buildPromoImage(String imagePath) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          imagePath,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width * .75,
        ),
      ),
    );
  }

  @override
  void onError(String error) {
    Navigator.pop(context);
    showSnackbar(context, error, Theme.of(context).errorColor);
  }

  @override
  void onGetImages(List<String> imagePath) {
    Navigator.pop(context);

    setState(() {
      _headerImages.clear();
      _headerImages.addAll(imagePath);
    });
  }

  @override
  void onGetPromoImages(List<String> imagePath) {
    Navigator.pop(context);

    setState(() {
      _promoImages.clear();
      _promoImages.addAll(imagePath);
    });
  }
}
