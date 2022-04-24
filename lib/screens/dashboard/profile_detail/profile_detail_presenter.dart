import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ud_truck_booking/const/utils.dart';
import 'package:ud_truck_booking/models/user_response.dart';

abstract class ProfileDetailContract {
  void onError(String error);

  void onGetDetail(UserResponse user);

  void onDataSaved();
}

class ProfileDetailPresenter {
  ProfileDetailContract contract;

  ProfileDetailPresenter({required this.contract});

  final firestore = FirebaseFirestore.instance;

  getUserDetail(BuildContext context) async {
    showLoaderDialog(context);

    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('id') ?? '';
    final userRef = firestore.collection('users');

    userRef
        .doc(id)
        .get()
        .then(
          (value) => contract.onGetDetail(
            userResponseFromJson(
              json.encode(value.data()),
            ),
          ),
        )
        .catchError((error) {
      contract.onError(error.toString());
    });
  }

  saveUserDetail(BuildContext context, UserResponse request) async {
    showLoaderDialog(context);

    final userRef = firestore.collection('users');
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('id') ?? '';

    userRef.doc(id).update(json.decode(userResponseToJson(request))).then(
      (value) {
        contract.onDataSaved();
      },
    ).catchError(
      (error) {
        contract.onError(error.toString());
      },
    );
  }
}
