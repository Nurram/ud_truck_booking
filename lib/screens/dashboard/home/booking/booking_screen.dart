import 'package:flutter/material.dart';
import 'package:ud_truck_booking/const/constants.dart';
import 'package:ud_truck_booking/const/utils.dart';
import 'package:ud_truck_booking/screens/dashboard/home/booking/booking_presenter.dart';
import 'package:ud_truck_booking/screens/dashboard/home/booking/booking_success_widget.dart';
import 'package:ud_truck_booking/screens/dashboard/home/booking/first_form.dart';
import 'package:ud_truck_booking/screens/dashboard/home/booking/fourth_form.dart';
import 'package:ud_truck_booking/screens/dashboard/home/booking/second_form.dart';
import 'package:ud_truck_booking/screens/dashboard/home/booking/third_form.dart';
import 'package:ud_truck_booking/screens/dashboard/home/location/location_data.dart';
import 'package:ud_truck_booking/widgets/elevated_button.dart';
import 'package:ud_truck_booking/widgets/step_progress_widget.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>
    implements BookingContract {
  late BookingPresenter _presenter;

  final _titles = [
    'Kendaraan',
    'Jenis Pekerjaan',
    'Lokasi & Waktu',
    'Kontak',
    'Konfirmasi'
  ];

  final TextEditingController _platNoCtr = TextEditingController();
  final TextEditingController _typeCtr = TextEditingController();
  final TextEditingController _kilometerCtr = TextEditingController();
  final TextEditingController _vinCtr = TextEditingController();
  final TextEditingController _jobTypeCtr = TextEditingController();
  final TextEditingController _problemCtr = TextEditingController();
  final TextEditingController _durationCtr = TextEditingController();
  final TextEditingController _workshopCtr = TextEditingController();
  final TextEditingController _dateCtr = TextEditingController();
  final TextEditingController _hourCtr = TextEditingController();
  final TextEditingController _estimationCtr = TextEditingController();
  final TextEditingController _nameCtr = TextEditingController();
  final TextEditingController _phoneCtr = TextEditingController();
  final TextEditingController _emailCtr = TextEditingController();

  final FocusNode _platNoNode = FocusNode();
  final FocusNode _kilometerNode = FocusNode();
  final FocusNode _vinNode = FocusNode();
  final FocusNode _problemNode = FocusNode();
  final FocusNode _nameNode = FocusNode();
  final FocusNode _phoneNode = FocusNode();
  final FocusNode _emailNode = FocusNode();

  final _firstFormKey = GlobalKey<FormState>();
  final _secondFormKey = GlobalKey<FormState>();
  final _thirdFormKey = GlobalKey<FormState>();
  final _fourthFormKey = GlobalKey<FormState>();

  int _currentStep = 1;
  bool _isAgree = false;
  String _bookingId = '';

  @override
  void initState() {
    _presenter = BookingPresenter(contract: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking'),
        centerTitle: true,
        flexibleSpace: Image.asset(
          'assets/images/bg.webp',
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepProgressWidget(
              currentStep: _currentStep,
              stepData: _titles,
            ),
            _buildForm(),
            Padding(
              padding: const EdgeInsets.all(8),
              child: _currentStep < 5
                  ? Row(
                      children: [
                        Expanded(
                          child: TextButton(
                              child: const Text('Back'),
                              onPressed: () {
                                if (_currentStep > 1) {
                                  setState(() {
                                    _currentStep -= 1;
                                  });
                                }
                              }),
                        ),
                        Expanded(
                          child: MyElevatedButton(
                            text: 'Next',
                            onPressed: () => _onNextClick(),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                      ],
                    )
                  : _currentStep == 5
                      ? Visibility(
                          visible: _isAgree,
                          child: MyElevatedButton(
                            text: 'Submit',
                            onPressed: () => _onSubmitClick(),
                          ),
                        )
                      : Visibility(
                          visible: _isAgree,
                          child: MyElevatedButton(
                            text: 'Selesai',
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    if (_currentStep == 1) {
      return BookingFirstForm(
        formKey: _firstFormKey,
        platCtr: _platNoCtr,
        typeCtr: _typeCtr,
        kilometerCtr: _kilometerCtr,
        vinCtr: _vinCtr,
        platNoNode: _platNoNode,
        kilometerNode: _kilometerNode,
        vinNode: _vinNode
      );
    } else if (_currentStep == 2) {
      return BookingSecondForm(
          formKey: _secondFormKey,
          jobTypeCtr: _jobTypeCtr,
          problemCtr: _problemCtr,
          durationCtr: _durationCtr,
          problemNode: _problemNode);
    } else if (_currentStep == 3) {
      return BookingThirdForm(
        formKey: _thirdFormKey,
        workshopCtr: _workshopCtr,
        dateCtr: _dateCtr,
        estimationCtr: _durationCtr,
        hourCtr: _hourCtr,
      );
    } else if (_currentStep == 4) {
      return BookingFourthForm(
        formKey: _fourthFormKey,
        nameCtr: _nameCtr,
        phoneCtr: _phoneCtr,
        emailCtr: _emailCtr,
        nameNode: _nameNode,
        phoneNode: _phoneNode,
        emailNode: _emailNode,
      );
    } else if (_currentStep == 5) {
      return _buildConfirmationWidget();
    } else {
      return BookingSuccessWidget(
        bookingId: _bookingId,
      );
    }
  }

  Widget _buildConfirmationWidget() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Konfirmasi',
              style: TextStyle(
                  fontSize: 16, color: Theme.of(context).primaryColor),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16, bottom: 4),
              child: Text('Detail Kendaraan'),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]!, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildColumnItem('Tipe Kendaraan', _typeCtr.text),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      _buildColumnItem('Nomor Polisi', _platNoCtr.text),
                      const SizedBox(
                        width: 16,
                      ),
                      _buildColumnItem('Kilometer', _kilometerCtr.text),
                    ],
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 24, bottom: 4),
              child: Text('Detail Pesanan'),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]!, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildColumnItem(
                      'Lokasi Bengkel',
                      '${_workshopCtr.text}\n'
                          '\n${LocationData.getLocations["address"][0]}'),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      _buildColumnItem('Tanggal', _dateCtr.text),
                      const SizedBox(
                        width: 16,
                      ),
                      _buildColumnItem('Jam', _hourCtr.text),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildColumnItem('Jenis Pekerjaan', _jobTypeCtr.text),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildColumnItem('Keluhan', _problemCtr.text),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            CheckboxListTile(
                title: const Text(
                  'Saya setuju dengan detail konfirmasi kendaraan dan pesanan diatas',
                  style: TextStyle(fontSize: 14),
                ),
                value: _isAgree,
                onChanged: (value) {
                  setState(() {
                    _isAgree = value!;
                  });
                })
          ],
        ),
      ),
    );
  }

  _onNextClick() {
    if (_currentStep == 1) {
      if (_firstFormKey.currentState!.validate()) {
        _changeCurStep(1);
      }
    } else if (_currentStep == 2) {
      if (_secondFormKey.currentState!.validate()) {
        _changeCurStep(1);
      }
    } else if (_currentStep == 3) {
      if (_thirdFormKey.currentState!.validate()) {
        _changeCurStep(1);
      }
    } else if (_currentStep == 4) {
      if (_fourthFormKey.currentState!.validate()) {
        _changeCurStep(1);
      }
    }
  }

  _changeCurStep(int value) {
    setState(() {
      _currentStep += value;
    });
  }

  Widget _buildColumnItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Padding(padding: const EdgeInsets.only(top: 4), child: Text(value)),
      ],
    );
  }

  _onSubmitClick() {
    if (_isAgree) {
      _bookingId = 'U${DateTime.now().millisecondsSinceEpoch}D';
      final Map<String, dynamic> data = {
        'bookingId': _bookingId,
        'platNo': _platNoCtr.text,
        'vehicleType': _typeCtr.text,
        'kilometer': _kilometerCtr.text,
        'jobType': _jobTypeCtr.text,
        'problem': _problemCtr.text,
        'duration': _durationCtr.text,
        'workshop': _workshopCtr.text,
        'orderDate': _dateCtr.text,
        'orderHour': _hourCtr.text,
        'estimation': _estimationCtr.text,
        'clientName': _nameCtr.text,
        'clientPhone': _phoneCtr.text,
        'clientEmail': _emailCtr.text,
        'noVin': _vinCtr.text,
        'status': ON_PROGRESS,
        'timeStamp': DateTime.now().millisecondsSinceEpoch
      };

      _presenter.saveOrder(context, data);
    } else {
      showSnackbar(context, 'Kamu harus setuju untuk bisa melanjutkan!',
          Theme.of(context).errorColor);
    }
  }

  @override
  void onError(String error) {
    Navigator.pop(context);
    showSnackbar(context, error, Theme.of(context).errorColor);
  }

  @override
  void onOrderSaved() {
    Navigator.pop(context);
    setState(() {
      _currentStep += 1;
    });
  }
}
