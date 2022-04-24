import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:ud_truck_booking/const/utils.dart';

abstract class NewsContract {
  void onError(String error);

  void onGetNewsImages(List<String> newsImagePath);
}

class NewsPresenter {
  NewsContract contract;

  NewsPresenter({required this.contract});

  getNewsImage(BuildContext context) async {
    showLoaderDialog(context);

    final storageRef = FirebaseStorage.instance.ref();
    final news1 = await storageRef
        .child("news/news1.webp")
        .getDownloadURL()
        .catchError((error) {
      contract.onError(error.toString());
    });
    final news2 = await storageRef
        .child("news/news2.webp")
        .getDownloadURL()
        .catchError((error) {
      contract.onError(error.toString());
    });
    final news3 = await storageRef
        .child("news/news3.webp")
        .getDownloadURL()
        .catchError((error) {
      contract.onError(error.toString());
    });
    final news4 = await storageRef
        .child("news/news4.webp")
        .getDownloadURL()
        .catchError((error) {
      contract.onError(error.toString());
    });
    final news5 = await storageRef
        .child("news/news5.webp")
        .getDownloadURL()
        .catchError((error) {
      contract.onError(error.toString());
    });
    final news6 = await storageRef
        .child("news/news6.webp")
        .getDownloadURL()
        .catchError((error) {
      contract.onError(error.toString());
    });
    final news7 = await storageRef
        .child("news/news7.webp")
        .getDownloadURL()
        .catchError((error) {
      contract.onError(error.toString());
    });

    contract.onGetNewsImages(
      [news1, news2, news3, news4, news5, news6, news7],
    );
  }
}
