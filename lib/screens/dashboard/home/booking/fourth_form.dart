import 'package:flutter/material.dart';

import '../../../../widgets/text_form_field.dart';

class BookingFourthForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameCtr;
  final TextEditingController phoneCtr;
  final TextEditingController emailCtr;

  final FocusNode nameNode;
  final FocusNode phoneNode;
  final FocusNode emailNode;

  const BookingFourthForm(
      {Key? key,
      required this.formKey,
      required this.nameCtr,
      required this.phoneCtr,
      required this.emailCtr,
      required this.nameNode,
      required this.phoneNode,
      required this.emailNode})
      : super(key: key);

  @override
  State<BookingFourthForm> createState() => _BookingFourthFormState();
}

class _BookingFourthFormState extends State<BookingFourthForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            MyTextFormField(
                focusNode: widget.nameNode,
                textEditingController: widget.nameCtr,
                labelText: 'Nama Lengkap',
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Field masih kosong!';
                  }

                  return null;
                }),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: MyTextFormField(
                focusNode: widget.phoneNode,
                textEditingController: widget.phoneCtr,
                labelText: 'Nomor Whatsapp',
                hintText: '0823xxxxxxxx',
                textInputType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field masih kosong!';
                  } else if (value.length < 11 ||
                      value.length > 12 ||
                      !value.startsWith('08')) {
                    return 'Masukan nomor yang valid!';
                  }

                  return null;
                },
              ),
            ),
            MyTextFormField(
              focusNode: widget.emailNode,
              textEditingController: widget.emailCtr,
              textInputType: TextInputType.emailAddress,
              labelText: 'Email (Opsional)',
              validator: (value) {},
            ),
          ],
        ),
      ),
    );
  }
}
