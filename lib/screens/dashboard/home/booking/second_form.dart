import 'package:flutter/material.dart';

import '../../../../const/utils.dart';
import '../../../../widgets/my_clickable_form_field.dart';
import '../../../../widgets/text_form_field.dart';

class BookingSecondForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController jobTypeCtr;
  final TextEditingController problemCtr;
  final TextEditingController durationCtr;

  final FocusNode problemNode;

  const BookingSecondForm(
      {Key? key,
      required this.formKey,
      required this.jobTypeCtr,
      required this.problemCtr,
      required this.durationCtr,
      required this.problemNode})
      : super(key: key);

  @override
  State<BookingSecondForm> createState() => _BookingSecondFormState();
}

class _BookingSecondFormState extends State<BookingSecondForm> {
  final _jobTypes = [
    'Service Paket 5000',
    'Service Paket 10.000',
    'Service Paket 20.000',
    'Sercive Paket 30.000',
    'Service Paket 40.000',
    'Service Paket 50.000',
    'Service Paket 60.000',
    'Service Paket 70.000',
    'Service Paket 80.000',
    'Service Paket 90.000',
    'Service Paket 100.000',
    'Service Paket 110.000',
    'Service Paket 120.000',
    'Service Paket Lainnya =-'
  ];

  final _duration = [
    '1,6 Jam',
    '1,7 Jam',
    '3,7 Jam',
    '1,2 Jam',
    '3,7 Jam',
    '1,2 Jam',
    '5 Jam',
    '1,2 Jam',
    '3,7 Jam',
    '1,2 Jam',
    '3,7 Jam',
    '1,2 Jam',
    '5 Jam',
    ''
  ];

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      widget.jobTypeCtr.text = _jobTypes[0];
      widget.durationCtr.text = _duration[0];
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
            MyClickableFormField(
              focusNode: FocusNode(),
              textEditingController: widget.jobTypeCtr,
              labelText: 'Jenis Pekerjaan',
              onTap: () => _showJobsBottomSheet(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: MyTextFormField(
                  focusNode: widget.problemNode,
                  textEditingController: widget.problemCtr,
                  labelText: 'Keluhan',
                  textInputType: TextInputType.multiline,
                  maxLines: null,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Field masih kosong!';
                    }
                  }),
            ),
            MyClickableFormField(
              focusNode: FocusNode(),
              textEditingController: widget.durationCtr,
              labelText: 'Durasi Pengerjaan',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  _showJobsBottomSheet() {
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
              'Silahkan Pilih Paket Service',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _jobTypes.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          widget.jobTypeCtr.text = _jobTypes[index];
                          widget.durationCtr.text = _duration[index];
                          Navigator.pop(context);
                        },
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(_jobTypes[index])),
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
}
