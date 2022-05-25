import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ud_truck_booking/screens/dashboard/home/booking/booking_presenter.dart';
import 'package:ud_truck_booking/screens/dashboard/home/location/location_data.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../const/utils.dart';
import '../../../../widgets/my_clickable_form_field.dart';
import '../../../../widgets/text_form_field.dart';

class BookingThirdForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController workshopCtr;
  final TextEditingController dateCtr;
  final TextEditingController hourCtr;
  final TextEditingController estimationCtr;

  const BookingThirdForm(
      {Key? key,
      required this.formKey,
      required this.workshopCtr,
      required this.dateCtr,
      required this.hourCtr,
      required this.estimationCtr})
      : super(key: key);

  @override
  State<BookingThirdForm> createState() => _BookingThirdFormState();
}

class _BookingThirdFormState extends State<BookingThirdForm>
    implements BookingThirdFormContract {
  late BookingPresenter _presenter;

  final _workshops = [LocationData.getLocations['name'][0]];
  final _hours = [];

  @override
  void initState() {
    _presenter = BookingPresenter(thirdFormContract: this);
    Future.delayed(Duration.zero, () {
      widget.workshopCtr.text = _workshops[0];

      final currentDate = DateFormat('EEEE, dd-MM-yyyy').format(DateTime.now());
      widget.dateCtr.text = currentDate;
      _presenter.getHours(context, currentDate);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: MyClickableFormField(
                    focusNode: FocusNode(),
                    textEditingController: widget.workshopCtr,
                    labelText: 'Lokasi Bengkel',
                    onTap: () => _workshopsBottomSheet(),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    launch(
                        'https://www.google.com/maps/place/PT+AI+-+UD+TRUCKS+SALES+OPERATION+Cabang+Sunter/@-6.1457574,106.8845849,18z/data=!3m1!4b1!4m5!3m4!1s0x2e69f52cd0617aed:0x20fa820ec71b876a!8m2!3d-6.1457574!4d106.8856792');
                  },
                  child: const Icon(Icons.map_outlined),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: MyClickableFormField(
                focusNode: FocusNode(),
                textEditingController: widget.dateCtr,
                labelText: 'Hari & Tanggal',
                onTap: () => _showDatePicker(),
                validation: (value) {
                  if (value.isEmpty) {
                    return 'Field masih kosong!';
                  }

                  return null;
                },
              ),
            ),
            MyClickableFormField(
              focusNode: FocusNode(),
              textEditingController: widget.hourCtr,
              labelText: 'Jam Tersedia',
              onTap: () => _hoursBottomSheet(),
              validation: (value) {
                if (value.isEmpty) {
                  return 'Field masih kosong!';
                }

                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            MyTextFormField(
              focusNode: FocusNode(),
              textEditingController: widget.estimationCtr,
              labelText: 'Estimasi waktu selesai',
              validator: (value) {},
              readOnly: true,
            ),
          ],
        ),
      ),
    );
  }

  _workshopsBottomSheet() {
    showMyBottomSheet(
      context,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Container(
                width: 32,
                height: 3,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Silahkan Pilih Bengkel',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _workshops.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          widget.workshopCtr.text = _workshops[index];
                          Navigator.pop(context);
                        },
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(_workshops[index])),
                      ),
                      const Divider()
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }

  _hoursBottomSheet() {
    showMyBottomSheet(
      context,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Container(
                width: 32,
                height: 3,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Silahkan Pilih Waktu Pengerjaan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _hours.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          widget.hourCtr.text = _hours[index]['hour'];
                          Navigator.pop(context);
                        },
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(_hours[index]['hour'])),
                      ),
                      const Divider()
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }

  _showDatePicker() async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1945),
      lastDate: DateTime(2500),
    ).then((value) {
      if (value != null) {
        final currentDate = DateFormat('EEEE, dd-MM-yyyy').format(value);
        widget.dateCtr.text = currentDate;
        _presenter.getHours(context, currentDate);
      }
    });
  }

  @override
  void onError(String error) {
    Navigator.pop(context);
    showSnackbar(context, error, Theme.of(context).primaryColor);
  }

  @override
  void onGetHours(List<Map<String, dynamic>> hours) {
    Navigator.pop(context);
    hours.removeWhere(
      (element) => element['quota'] == 0,
    );

    setState(() {
      _hours.clear();
      _hours.addAll(hours);
    });
  }
}
