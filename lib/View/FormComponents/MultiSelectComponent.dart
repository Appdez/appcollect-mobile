import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class MultiSelectComponent<T> extends StatelessWidget {
  MultiSelectComponent(
      {Key? key,
      required this.hintText,
      required this.items,
      this.showSearchBox = false,
      this.onSaved,
      this.onChanged,
      this.controller,
      this.mode = Mode.MENU,
      this.label,
      this.itemAsString,
      this.onFocus,
      required this.selectedItems,
      this.validator})
      : super(key: key);
  final String hintText;
  final List<T> items;
  final bool showSearchBox;
  final Mode mode;
  final String? label;
  void Function(List<T>?)? onSaved;
  void Function(List<T>?)? onChanged;
  TextEditingController? controller;
  String Function(T?)? itemAsString;
  String? Function(List<T>?)? validator;
  List<T> selectedItems;
  FocusNode? onFocus;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 35, right: 35, top: 10),
        child: DropdownSearch<T>.multiSelection(
          mode: mode,
          items: items,
          focusNode: onFocus,
          showSearchBox: showSearchBox,
          selectedItems: selectedItems,
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
