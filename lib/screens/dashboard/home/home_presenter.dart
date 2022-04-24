import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ud_truck_booking/const/utils.dart';

abstract class HomeContract {
  void onError(String error);

  void onGetImages(List<String> imagePath);

  void onGetPromoImages(List<String> imagePath);
}

class HomePresenter {
  HomeContract contract;

  HomePresenter({required this.contract});

  getHeaderImages(BuildContext context) async {
    showLoaderDialog(context);

    final imagePaths = <String>[];
    final storageRef = FirebaseStorage.instance.ref();
    final headers = storageRef.child('header');

    await headers.listAll().then((value) async {
      await Future.forEach(value.items, (element) async {
        element as Reference;

        await element
            .getDownloadURL()
            .then((url) => imagePaths.add(url))
            .catchError((error) {
          contract.onError(error.toString());
        });
      });
    });
    contract.onGetImages(imagePaths);
  }

  gerPromoImages(BuildContext context) async {
    showLoaderDialog(context);

    final imagePaths = <String>[];
    final storageRef = FirebaseStorage.instance.ref();
    final promos = storageRef.child('promos');

    await promos.listAll().then((value) async {
      await Future.forEach(value.items, (element) async {
        element as Reference;

        await element
            .getDownloadURL()
            .then((url) => imagePaths.add(url))
            .catchError((error) {
          contract.onError(error.toString());
        });
      });
    });

    contract.onGetPromoImages(imagePaths);
  }
}
