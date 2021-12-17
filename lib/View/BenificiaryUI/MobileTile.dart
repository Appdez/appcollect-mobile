
import '../../Controller/BenificiaryController.dart';
import '../../View/BenificiaryForm/BenificiaryForm.dart';
import '../../View/BenificiaryUI/ContentTile.dart';
import 'package:flutter/material.dart';

import '../../Model/Benificiary/Benificiary.dart';

class MobileTile extends StatefulWidget {
  const MobileTile({Key? key, required this.benificiary}) : super(key: key);
  final Benificiary benificiary;

  @override
  _MobileTileState createState() => _MobileTileState(this.benificiary);
}

class _MobileTileState extends State<MobileTile> {
  final Benificiary benificiary;

  _MobileTileState(this.benificiary);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 9,
        color: Colors.white,
        margin: EdgeInsets.all(0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Padding(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      BenificiaryForm(
                                          benificiaryForEdit: benificiary),
                                  fullscreenDialog: true,
                                ),
                              );
                            },
                            icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              if (Syncronization.addDeleted(benificiary)) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    'Benificiario deletado com sucesso',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.green,
                                ));
                                Navigator.of(context).pop();
                              }
                            },
                            icon: Icon(Icons.delete)),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.cancel_presentation_outlined)),
                      ],
                    ),
                  ],
                ),
                padding: EdgeInsets.all(8),
              ),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(color: Color(0xFFf4f8fd)),
                child: Center(
                    child: ContentTile(
                  benificiary: benificiary,
                )),
              )),
            ],
          ),
        ));
  }
}
