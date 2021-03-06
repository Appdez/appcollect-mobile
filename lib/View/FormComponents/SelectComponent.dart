import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
//import 'dart:collection';

// ignore: must_be_immutable
class SelectComponent<T> extends StatelessWidget {
  SelectComponent(
      {Key? key,
      required this.hintText,
      required this.items,
      this.showSearchBox = false,
      this.onSaved,
      this.onChanged,
      this.mode = Mode.MENU,
      this.label,
      this.onFocus,
      this.itemAsString,
      this.selectedItem,
      this.validator})
      : super(key: key);
  final String hintText;
  final List<T> items;
  final bool showSearchBox;
  final Mode mode;
  final String? label;
  void Function(T?)? onSaved;
  void Function(T?)? onChanged;
  String Function(T?)? itemAsString;
  String? Function(T?)? validator;
  FocusNode? onFocus;
  var selectedItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 35, right: 35, top: 10),
        child: DropdownSearch<T>(
          mode: mode,
          items: items,
          focusNode: onFocus,
          showSearchBox: showSearchBox,
          selectedItem: selectedItem != null ? selectedItem : null,
          onChanged: onChanged,
          onSaved: onSaved,
          itemAsString: itemAsString,
          validator: validator,
          dropdownSearchDecoration: InputDecoration(
              hintText: "Pesquisar " + hintText,
              labelText: label,
              helperText: hintText,
              border: OutlineInputBorder(),
              hintStyle: TextStyle(
                fontSize: 15,
                color: Colors.black54,
              ),
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
                    const BorderSide(color: Color(0xFF311b92), width: 2),
              )),
        ));
  }
}
