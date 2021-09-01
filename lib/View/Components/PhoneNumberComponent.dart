import 'package:flutter/material.dart';

class PhoneNumberComponent extends StatelessWidget {
  const PhoneNumberComponent(
      {Key? key, this.hintText, this.onChanged, this.onSaved, this.onSubmited})
      : super(key: key);
  final String? hintText;
  final void Function(String string)? onChanged;
  final void Function(String? string)? onSaved;
  final void Function(String)? onSubmited;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 35, right: 35, top: 10),
        child: TextFormField(
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: hintText,
              focusColor: Colors.black,
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black45, width: 1.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xFF311b92), width: 2.0),
              )),
          onChanged: onChanged,
          onSaved: onSaved,
          onFieldSubmitted: onSubmited,
        ));
  }
}