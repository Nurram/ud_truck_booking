import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ud_truck_booking/const/utils.dart';

abstract class RegisterContract {
  void onError(String error);

  void onDataExist();

  void onCodeSent(String verificationId, int? resendToken);

  void onTimeout();

  void onUserDataSaved();
}

class RegisterPresenter {
  final RegisterContract contract;
  final firestore = FirebaseFirestore.instance;

  RegisterPresenter({required this.contract});

  void verifyPhoneNumber(BuildContext context, String phoneNumber,
      int? resendToken, ThemeData theme) async {
    showLoaderDialog(context);

    final userRef = firestore.collection('users');
    userRef.where('phone', isEqualTo: '+62$phoneNumber').get().then((value) {
      if (value.size > 0) {
        contract.onDataExist();
      } else {
        _doVerification(phoneNumber, resendToken);
      }
    });
  }

  void _doVerification(String phoneNumber, int? resendToken) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+62$phoneNumber',
      timeout: const Duration(seconds: 30),
      verificationCompleted: (credential) {},
      verificationFailed: (e) {
        String msg = e.message ?? 'Something happened!';

        if (e.code == 'invalid-phone-number') {
          msg = 'Nomor tidak valid!';
        }

        contract.onError(msg);
      },
      codeSent: (verificationId, resendToken) {
        contract.onCodeSent(verificationId, resendToken);
      },
      codeAutoRetrievalTimeout: (verificationId) => contract.onTimeout(),
      forceResendingToken: resendToken,
    );
  }

  void saveUserData(BuildContext context, Map<String, dynamic> data) {
    showLoaderDialog(context);

    final userRef = firestore.collection('users');

    userRef
        .add(data)
        .then(
          (value) => contract.onUserDataSaved(),
        )
        .catchError(
          (error) => contract.onError(error.toString()),
        );
  }
}
