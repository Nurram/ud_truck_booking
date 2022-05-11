import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../const/utils.dart';
import '../../widgets/elevated_button.dart';
import '../../widgets/text_form_field.dart';
import 'forgot_password_presenter.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    implements ForgotPasswordContract {
  late ForgotPasswordPresenter _presenter;

  String _verificationId = '';
  int? _resendToken;
  bool _isShowResend = false;
  bool _isInInput = true;

  final _phoneCtr = TextEditingController();
  final _phoneNode = FocusNode();

  final _otpCodeNode = FocusNode();
  final _formOtpKey = GlobalKey<FormState>();
  final _otpCodeCtr = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    _presenter = ForgotPasswordPresenter(contract: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: _isInInput ? _generateInputForm() : _generateOtpForm()),
    );
  }

  Column _generateInputForm() {
    return Column(
      children: [
        MyTextFormField(
          focusNode: _phoneNode,
          textEditingController: _phoneCtr,
          hintText: '8xxxxxxxxxx',
          labelText: 'Nomor Handphone',
          textInputType: TextInputType.number,
          prefix: '+62',
          validator: (value) {
            if (value!.isEmpty) {
              return 'Field masih kosong!';
            } else if (value.length != 12 || !value.startsWith('08')) {
              return 'Masukan nomor yang valid!';
            }

            return null;
          },
        ),
        const SizedBox(
          height: 16,
        ),
        MyElevatedButton(
          text: 'Submit',
          onPressed: () {
            _presenter.verifyPhoneNumber(
                context, _phoneCtr.text, null, Theme.of(context));
          },
        )
      ],
    );
  }

  Form _generateOtpForm() {
    return Form(
      key: _formOtpKey,
      child: Column(
        children: [
          MyTextFormField(
            focusNode: _otpCodeNode,
            textEditingController: _otpCodeCtr,
            labelText: 'OTP Code',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Field masih kosong!';
              }

              return null;
            },
          ),
          const SizedBox(
            height: 32,
          ),
          MyElevatedButton(
            text: 'Verifikasi',
            onPressed: () => _onSubmit(),
            padding: const EdgeInsets.all(16),
          ),
          const SizedBox(
            height: 16,
          ),
          Visibility(
            visible: _isShowResend,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Belum menerima kode?'),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPasswordScreen(),
                      ),
                    );
                  },
                  child: TextButton(
                    child: const Text('Kirim ulang'),
                    onPressed: () => _onPhoneInput(),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _onPhoneInput() async {
    _presenter.verifyPhoneNumber(
        context, _phoneCtr.text, _resendToken, Theme.of(context));
  }

  _onSubmit() async {
    if (_formOtpKey.currentState!.validate()) {
      final code = _otpCodeCtr.text.trim();
      final credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: code);

      try {
        await _auth.signInWithCredential(credential);
        _auth.signOut;

        _presenter.getPassword(context, _phoneCtr.text);
      } on FirebaseAuthException catch (e) {
        showSnackbar(context, e.message!, Theme.of(context).errorColor);
      }
    }
  }

  @override
  void onError(String error) {
    Navigator.pop(context);
    showSnackbar(context, error, Theme.of(context).errorColor);
  }

  @override
  void onDataNotFound() {
    Navigator.pop(context);
    showSnackbar(context, 'Nomor hp tidak ditemukan, silahkan register!',
        Theme.of(context).errorColor);
  }

  @override
  void onCodeSent(String verificationId, int? resendToken) {
    Navigator.pop(context);
    setState(() {
      _isInInput = false;
      _verificationId = verificationId;
      _resendToken = resendToken;
    });
  }

  @override
  void onTimeout() {
    setState(
      () {
        _isShowResend = true;
      },
    );
  }

  @override
  void onGetPassword(String password) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Passwordmu adalah:'),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                password,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            MyElevatedButton(
                text: 'Oke',
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}
