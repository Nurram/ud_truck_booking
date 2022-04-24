import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ud_truck_booking/const/constants.dart';
import 'package:ud_truck_booking/models/user_response.dart';

import '../../const/utils.dart';

abstract class DashboardContract {
  void onError(String error);

  void onGetProfile(UserResponse user);

  void onGetPoints(int points);
}

class DashboardPresenter {
  final DashboardContract contract;

  DashboardPresenter({required this.contract});

  getUserDetail(BuildContext context) async {
    showLoaderDialog(context);

    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString(ID) ?? '';
    final firestore = FirebaseFirestore.instance;
    final userRef = firestore.collection('users');

    await userRef.doc(id).get().then(
      (value) {
        contract.onGetProfile(userResponseFromJson(
          json.encode(value.data()),
        ));

        _getPoints(context);
      },
    ).catchError((error) {
      contract.onError(error.toString());
    });
  }

  _getPoints(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final firestore = FirebaseFirestore.instance;
    final pointsRef = firestore.collection(POINTS);

    pointsRef
        .where(USER_ID, isEqualTo: prefs.getString(ID))
        .get()
        .then((value) {
      contract.onGetPoints(value.docs[0].data()['point']);
    }).catchError((error) {
      contract.onError(error);
    });
  }

  logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(ID);
  }
}
