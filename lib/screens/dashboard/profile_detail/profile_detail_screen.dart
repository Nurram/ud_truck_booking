import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ud_truck_booking/const/utils.dart';
import 'package:ud_truck_booking/models/user_response.dart';
import 'package:ud_truck_booking/screens/dashboard/profile_detail/profile_detail_presenter.dart';

import '../../../widgets/elevated_button.dart';
import '../../../widgets/my_clickable_form_field.dart';
import '../../../widgets/text_form_field.dart';

class ProfileDetailScreen extends StatefulWidget {
  const ProfileDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen>
    implements ProfileDetailContract {
  late ProfileDetailPresenter _presenter;

  final TextEditingController _nameCtr = TextEditingController();
  final TextEditingController _phoneCtr = TextEditingController();
  final TextEditingController _waCtr = TextEditingController();
  final TextEditingController _emailCtr = TextEditingController();
  final TextEditingController _birthCtr = TextEditingController();
  final TextEditingController _genderCtr = TextEditingController();
  final TextEditingController _simCtr = TextEditingController();
  final TextEditingController _nikCtr = TextEditingController();
  final TextEditingController _addressCtr = TextEditingController();
  final TextEditingController _provinceCtr = TextEditingController();
  final TextEditingController _cityCtr = TextEditingController();
  final TextEditingController _villageCtr = TextEditingController();

  final FocusNode _nameNode = FocusNode();
  final FocusNode _phoneNode = FocusNode();
  final FocusNode _waNode = FocusNode();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _birthNode = FocusNode();
  final FocusNode _genderNode = FocusNode();
  final FocusNode _simNode = FocusNode();
  final FocusNode _nikNode = FocusNode();
  final FocusNode _addressNode = FocusNode();
  final FocusNode _provinceNode = FocusNode();
  final FocusNode _cityNode = FocusNode();
  final FocusNode _villageNode = FocusNode();

  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    _presenter = ProfileDetailPresenter(contract: this);
    Future.delayed(Duration.zero, () {
      _presenter.getUserDetail(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        flexibleSpace: Image.asset(
          'assets/images/bg.webp',
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .1,
                vertical: 32),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  MyTextFormField(
                    focusNode: _nameNode,
                    textEditingController: _nameCtr,
                    hintText: 'John Doe',
                    labelText: 'Nama Lengkap',
                    textInputType: TextInputType.text,
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
                    hintText: '8xxxxxxxxxxx',
                    labelText: 'Nomor handphone',
                    prefix: '+62',
                    textInputType: TextInputType.number,
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
                    focusNode: _waNode,
                    textEditingController: _waCtr,
                    hintText: '8xxxxxxxxxxx',
                    labelText: 'Nomor WA',
                    prefix: '+62',
                    textInputType: TextInputType.number,
                    validator: (value) {
                      if (value.isNotEmpty) {
                        if (value.length != 11 || !value.startsWith('8')) {
                          return 'Masukan nomor yang valid!';
                        }
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  MyTextFormField(
                    focusNode: _emailNode,
                    textEditingController: _emailCtr,
                    hintText: 'test@test.com',
                    labelText: 'Email',
                    textInputType: TextInputType.emailAddress,
                    validator: (value) {
                      if (!value!.toString().isValidEmail()) {
                        return 'Enter a valid email!';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  MyClickableFormField(
                    focusNode: _birthNode,
                    textEditingController: _birthCtr,
                    hintText: '01-01-2022',
                    labelText: 'Tanggal Lahir',
                    textInputType: TextInputType.number,
                    onTap: () => _showDatePicker(true),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  MyTextFormField(
                    focusNode: _genderNode,
                    textEditingController: _genderCtr,
                    hintText: 'Laki-Laki',
                    labelText: 'Jenis Kelamin',
                    textInputType: TextInputType.text,
                    validator: (value) {},
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  MyClickableFormField(
                    focusNode: _simNode,
                    textEditingController: _simCtr,
                    hintText: '01-01-2022',
                    labelText: 'Masa Berlaku SIM',
                    textInputType: TextInputType.number,
                    onTap: () => _showDatePicker(false),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  MyTextFormField(
                    focusNode: _nikNode,
                    textEditingController: _nikCtr,
                    hintText: '320xxxxxxxxxxxxx',
                    labelText: 'NIK',
                    textInputType: TextInputType.number,
                    validator: (value) {},
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  MyTextFormField(
                    focusNode: _addressNode,
                    textEditingController: _addressCtr,
                    hintText: 'Jonggol',
                    labelText: 'Alamat',
                    textInputType: TextInputType.text,
                    validator: (value) {},
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  MyTextFormField(
                    focusNode: _provinceNode,
                    textEditingController: _provinceCtr,
                    hintText: 'Jonggol',
                    labelText: 'Provinsi',
                    textInputType: TextInputType.text,
                    validator: (value) {},
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  MyTextFormField(
                    focusNode: _cityNode,
                    textEditingController: _cityCtr,
                    hintText: 'Jonggol',
                    labelText: 'Kabupaten/Kota',
                    textInputType: TextInputType.text,
                    validator: (value) {},
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  MyTextFormField(
                    focusNode: _villageNode,
                    textEditingController: _villageCtr,
                    hintText: 'Jonggol',
                    labelText: 'Desa',
                    textInputType: TextInputType.text,
                    validator: (value) {},
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  MyElevatedButton(
                    text: 'Update',
                    onPressed: () => _onSubmit(),
                    padding: const EdgeInsets.all(16),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showDatePicker(bool isBirthDate) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1945),
      lastDate: isBirthDate
          ? DateTime.now()
          : DateTime.now().add(
              const Duration(days: 3650),
            ),
    ).then((value) {
      if (value != null) {
        if (isBirthDate) {
          _birthCtr.text = DateFormat('dd-MM-yyyy').format(value);
        } else {
          _simCtr.text = DateFormat('dd-MM-yyyy').format(value);
        }
      }
    });
  }

  _onSubmit() {
    if (_key.currentState!.validate()) {
      final data = UserResponse(
          email: _emailCtr.text,
          fullname: _nameCtr.text,
          phone: _phoneCtr.text,
          wa: _waCtr.text,
          birthDate: _birthCtr.text,
          gender: _genderCtr.text,
          simExpires: _simCtr.text,
          nik: _nikCtr.text,
          address: _addressCtr.text,
          province: _provinceCtr.text,
          city: _cityCtr.text,
          village: _villageCtr.text);

      _presenter.saveUserDetail(context, data);
    }
  }

  @override
  void onError(String error) {
    Navigator.pop(context);
    showSnackbar(context, error, Theme.of(context).errorColor);
  }

  @override
  void onGetDetail(UserResponse user) {
    Navigator.pop(context);

    _nameCtr.text = user.fullname;
    _phoneCtr.text = user.phone;
    _waCtr.text = user.wa;
    _emailCtr.text = user.email;
    _birthCtr.text = user.birthDate;
    _genderCtr.text = user.gender;
    _simCtr.text = user.simExpires;
    _nikCtr.text = user.nik;
    _addressCtr.text = user.address;
    _provinceCtr.text = user.province;
    _cityCtr.text = user.city;
    _villageCtr.text = user.village;
  }

  @override
  void onDataSaved() {
    Navigator.pop(context);
    Navigator.pop(context);
    showSnackbar(context, 'Data berhasil di update!', Colors.green);
  }
}
