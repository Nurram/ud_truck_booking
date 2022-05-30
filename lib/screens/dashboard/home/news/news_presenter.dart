import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:ud_truck_booking/const/utils.dart';

import '../../../../const/constants.dart';

abstract class NewsContract {
  void onError(String error);

  void onGetNews(List<Map<String, dynamic>> news);
}

class NewsPresenter {
  NewsContract contract;

  NewsPresenter({required this.contract});

  getNews(BuildContext context) async {
    showLoaderDialog(context);

    final firestore = FirebaseFirestore.instance;
    final orderRef = firestore.collection(NEWS);
    final news = <Map<String, dynamic>>[];

    orderRef.get().then((value) {
      for (var element in value.docs) {
        news.add(element.data());
      }

      contract.onGetNews(news);
    }).catchError((error) {
      error as FirebaseException;
      contract.onError(error.message.toString());
    });
  }
}
