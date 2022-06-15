import 'package:flutter/material.dart';

import '../../../../const/utils.dart';
import '../../../../widgets/my_clickable_form_field.dart';
import '../../../../widgets/text_form_field.dart';

class BookingFirstForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController platCtr;
  final TextEditingController typeCtr;
  final TextEditingController kilometerCtr;
  final TextEditingController vinCtr;

  final FocusNode platNoNode;
  final FocusNode kilometerNode;
  final FocusNode vinNode;

  const BookingFirstForm(
      {Key? key,
      required this.formKey,
      required this.platCtr,
      required this.typeCtr,
      required this.kilometerCtr,
      required this.vinCtr,
      required this.platNoNode,
      required this.kilometerNode,
      required this.vinNode})
      : super(key: key);

  @override
  State<BookingFirstForm> createState() => _BookingFirstFormState();
}

class _BookingFirstFormState extends State<BookingFirstForm> {
  final _vehicleTypes = ['Quester', 'Euro 1', 'Euro 2', 'Kuzer'];

  @override
  void initState() {
    widget.typeCtr.text = _vehicleTypes[0];
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
            MyTextFormField(
                focusNode: widget.platNoNode,
                textEditingController: widget.platCtr,
                labelText: 'Plat Nomor',
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Field masih kosong!';
                  }

                  return null;
                }),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: MyClickableFormField(
                focusNode: FocusNode(),
                textEditingController: widget.typeCtr,
                labelText: 'Tipe Kendaraan',
                onTap: () => _showTypeBottomSheet(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: MyTextFormField(
                focusNode: widget.kilometerNode,
                textEditingController: widget.kilometerCtr,
                labelText: 'Kilometer',
                hintText: '1000',
                textInputType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Field masih kosong!';
                  }

                  return null;
                },
              ),
            ),
            MyTextFormField(
              focusNode: widget.vinNode,
              textEditingController: widget.vinCtr,
              labelText: 'No VIN',
              hintText: '1000',
              textInputType: TextInputType.text,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Field masih kosong!';
                }

                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  _showTypeBottomSheet() {
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
              'Silahkan Pilih Tipe Kendaraan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _vehicleTypes.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          widget.typeCtr.text = _vehicleTypes[index];
                          Navigator.pop(context);
                        },
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(_vehicleTypes[index])),
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
