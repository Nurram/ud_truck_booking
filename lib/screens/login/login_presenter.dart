import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:ud_truck_booking/const/utils.dart';

abstract class LoginContract {
  void onError(String error);

  void onLoginSuccess();
}

class LoginPresenter {
  final LoginContract contract;

  LoginPresenter({required this.contract});

  login(BuildContext context, String username, String password) {
    showLoaderDialog(context);

    final firestore = FirebaseFirestore.instance;
    final userRef = firestore.collection('users');
    
    userRef
        .where('username', isEqualTo: username)
        .where('password', isEqualTo: password)
        .get()
        .then((value) {
      if (value.size > 0) {
        contract.onLoginSuccess();
      } else {
        contract.onError('Invalid username/password!');
      }
    }).catchError((error) {
      contract.onError(error.toString());
    });
  }
}
