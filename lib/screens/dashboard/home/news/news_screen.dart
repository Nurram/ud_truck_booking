import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ud_truck_booking/const/utils.dart';
import 'package:ud_truck_booking/screens/dashboard/home/news/news_data.dart';
import 'package:ud_truck_booking/screens/dashboard/home/news/news_presenter.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> implements NewsContract {
  late NewsPresenter _presenter;

  final _newsData = <Map<String, dynamic>>[];

  int _currentCarouselIndex = 0;

  @override
  void initState() {
    _presenter = NewsPresenter(contract: this);
    Future.delayed(Duration.zero, () {
      _presenter.getNews(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Berita'),
        centerTitle: true,
        flexibleSpace: Image.asset(
          'assets/images/bg.webp',
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: _newsData.isEmpty ? Container() : _buildScreen(),
    );
  }

  Widget _buildScreen() {
    final imageLinks = <String>[];

    for (var element in _newsData) {
      imageLinks.add(element['image']);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildImageSlider(imageLinks),
          Expanded(
            child: ListView.builder(
              itemCount: _newsData.length,
              itemBuilder: (context, index) {
                return _buildListItem(_newsData[index]['image'], index,
                    _newsData[index]['title']);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSlider(List<String> items) {
    final screenSize = MediaQuery.of(context).size;

    final itemsWidget = items.map((e) => _buildImage(screenSize, e)).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          CarouselSlider(
            items: itemsWidget,
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

  Widget _buildListItem(String imagePath, int index, String title) {
    return InkWell(
      onTap: () async {
        await launch(_newsData[index]['link']);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imagePath,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('dd MMMM yyyy').format(
                      DateTime.now().subtract(
                        Duration(days: 30 * index),
                      ),
                    ),
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    softWrap: true,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
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
  void onGetNews(List<Map<String, dynamic>> news) {
    Navigator.pop(context);

    setState(() {
      _newsData.clear();
      _newsData.addAll(news);
    });
  }
}
