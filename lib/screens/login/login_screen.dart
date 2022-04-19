import 'package:flutter/material.dart';
import 'package:ud_truck_booking/screens/register/register_screen.dart';
import 'package:ud_truck_booking/widgets/elevated_button.dart';
import 'package:ud_truck_booking/widgets/text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Size _screenSize;

  final _usernameNode = FocusNode();
  final _passwordNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  final _usernameCtr = TextEditingController();
  final _passwordCtr = TextEditingController();

  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _screenSize = MediaQuery.of(context).size;
      _isInit = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: _screenSize.width * .1),
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
                    padding: EdgeInsets.symmetric(
                        horizontal: _screenSize.width * .15),
                    child: const Text(
                      'Masukan username dan password kamu untuk login',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  _generateForm()
                ],
              ),
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
            focusNode: _passwordNode,
            textEditingController: _passwordCtr,
            hintText: 'Password',
            labelText: 'Password',
            obscureText: true,
            textInputType: TextInputType.visiblePassword,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Field masih kosong!';
              }

              return null;
            },
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text('Forgot Password?'),
              ),
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          MyElevatedButton(
            text: 'Masuk',
            onPressed: () => _onSubmit(),
            padding: const EdgeInsets.all(16),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Belum memiliki akun?'),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                },
                child: const Text('Daftar'),
              ),
            ],
          )
        ],
      ),
    );
  }

  _onSubmit() {
    if (_formKey.currentState!.validate()) {}
  }
}
