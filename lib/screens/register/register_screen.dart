import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ud_truck_booking/const/utils.dart';
import 'package:ud_truck_booking/screens/register/register_presenter.dart';
import 'package:ud_truck_booking/widgets/elevated_button.dart';
import 'package:ud_truck_booking/widgets/text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    implements RegisterContract {
  late Size _screenSize;
  late ThemeData _theme;
  late RegisterPresenter _presenter;

  final _nameNode = FocusNode();
  final _usernameNode = FocusNode();
  final _phoneNode = FocusNode();
  final _emailNode = FocusNode();
  final _passwordNode = FocusNode();
  final _confirmNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  final _nameCtr = TextEditingController();
  final _usernameCtr = TextEditingController();
  final _phoneCtr = TextEditingController();
  final _emailCtr = TextEditingController();
  final _passwordCtr = TextEditingController();
  final _confirmCtr = TextEditingController();

  final _otpCodeNode = FocusNode();
  final _formOtpKey = GlobalKey<FormState>();

  final _otpCodeCtr = TextEditingController();

  final _auth = FirebaseAuth.instance;

  bool _isInit = true;
  bool _isInRegister = true;
  bool _isShowResend = false;

  String _verificationId = '';
  int? _resendToken;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _screenSize = MediaQuery.of(context).size;
      _theme = Theme.of(context);
      _presenter = RegisterPresenter(contract: this);
      _isInit = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isInRegister
          ? AppBar(
              backgroundColor: Colors.white,
              foregroundColor: _theme.primaryColor,
              elevation: 0,
            )
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: _screenSize.width * .1, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/ud_logo.webp',
                      width: _screenSize.width * .4,
                    )
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: _screenSize.width * .15),
                  child: Text(
                    _isInRegister ? 'Register' : 'Masukan kode otp',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                _isInRegister ? _generateForm() : _generateOtpForm()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Form _generateForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          MyTextFormField(
            focusNode: _nameNode,
            textEditingController: _nameCtr,
            hintText: 'John Doe',
            labelText: 'Nama Lengkap',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Field masih kosong!';
              }

              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          MyTextFormField(
            focusNode: _usernameNode,
            textEditingController: _usernameCtr,
            hintText: 'John Doe',
            labelText: 'Username',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Field masih kosong!';
              }

              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
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
              } else if (value.length != 11 || !value.startsWith('8')) {
                return 'Masukan nomor yang valid!';
              }

              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          MyTextFormField(
            focusNode: _emailNode,
            textEditingController: _emailCtr,
            hintText: 'example@example.com',
            labelText: 'Email',
            textInputType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Field masih kosong!';
              } else if (!value!.toString().isValidEmail()) {
                return 'Enter a valid email!';
              }

              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          MyTextFormField(
            focusNode: _passwordNode,
            textEditingController: _passwordCtr,
            hintText: 'Password',
            labelText: 'Password',
            textInputType: TextInputType.visiblePassword,
            obscureText: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Field masih kosong!';
              } else if (_passwordCtr.text != _confirmCtr.text) {
                return 'Password tidak sama!';
              }

              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          MyTextFormField(
            focusNode: _confirmNode,
            textEditingController: _confirmCtr,
            hintText: 'Konfirmasi Password',
            labelText: 'Konfirmasi Password',
            textInputType: TextInputType.visiblePassword,
            obscureText: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Field masih kosong!';
              } else if (_passwordCtr.text != _confirmCtr.text) {
                return 'Password tidak sama!';
              }

              return null;
            },
          ),
          const SizedBox(
            height: 32,
          ),
          MyElevatedButton(
            text: 'Daftar',
            onPressed: () => _onRegister(),
            padding: const EdgeInsets.all(16),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Sudah memiliki akun?'),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Login'),
              ),
            ],
          )
        ],
      ),
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
                const Text('Belum meneirma kode?'),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: TextButton(
                    child: const Text('Kirim ulang'),
                    onPressed: () => _onRegister(),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _onRegister() async {
    _presenter.verifyPhoneNumber(context, _phoneCtr.text, _resendToken, _theme);
  }

  _onSubmit() async {
    if (_formOtpKey.currentState!.validate()) {
      final code = _otpCodeCtr.text.trim();
      final credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: code);

      try {
        await _auth.signInWithCredential(credential);
        _saveUserData();
      } on FirebaseAuthException catch (e) {
        showSnackbar(context, e.message!, _theme.errorColor);
      }
    }
  }

  _saveUserData() {
    final data = {
      'fullname': _nameCtr.text,
      'username': _usernameCtr.text,
      'phone': '+62${_phoneCtr.text}',
      'email': _emailCtr.text,
      'password': _passwordCtr.text,
    };

    _auth.signOut();
    _presenter.saveUserData(context, data);
  }

  @override
  void onError(String error) {
    Navigator.pop(context);
    showSnackbar(context, error, _theme.errorColor);
  }

  @override
  void onDataExist() {
    Navigator.pop(context);
    showSnackbar(context, 'Nomor hp telah terdaftar, silahkan login!',
        _theme.errorColor);
  }

  @override
  void onCodeSent(String verificationId, int? resendToken) {
    Navigator.pop(context);

    setState(() {
      _isInRegister = false;
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
  void onUserDataSaved() {
    Navigator.pop(context);
    Navigator.pop(context);
    showSnackbar(context, 'Success!', Colors.green);
  }
}
