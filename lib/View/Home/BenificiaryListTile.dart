
import 'package:appcollect/Model/Benificiary/Benificiary.dart';
import 'package:appcollect/View/BenificiaryUI/BenificiaryUi.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter/material.dart';

class BenificiaryListTile extends StatelessWidget {
  const BenificiaryListTile(
      {Key? key, required this.benificiary, this.icon, this.isDisabled = false})
      : super(key: key);
  final Benificiary benificiary;
  final Widget? icon;
  final isDisabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: ListTile(
          leading: CircleAvatar(
            child: Icon(
              Icons.person,
              color: Colors.grey.shade500,
            ),
            backgroundColor: Colors.grey.shade300,
          ),
          title:Text(
                  "${capitalize(benificiary.fullName)}",
                  style: TextStyle(
                      fontWeight: FontWeight.w800, color: Colors.grey.shade800),
                ),
          subtitle:  Text("${benificiary.formNumber}"),
          trailing: icon != null ? icon : Text(""),
        ),
        margin: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        decoration: BoxDecoration(
            color: isDisabled ? Colors.redAccent.shade100 : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5))),
      ),
      onTap: isDisabled
          ? () {}
          : () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      BenificiaryUi(benificiary: benificiary),
                  fullscreenDialog: true,
                ),
              );
            },
    );
  }
}
