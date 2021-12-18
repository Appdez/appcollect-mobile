
import '../../Controller/BenificiaryController.dart';
import 'package:flutter/material.dart';
import '../../Model/Benificiary/Benificiary.dart';

class ContentTile extends StatefulWidget {
  const ContentTile({Key? key, required this.benificiary}) : super(key: key);
  final Benificiary benificiary;

  @override
  _ContentTileState createState() => _ContentTileState(this.benificiary);
}

class _ContentTileState extends State<ContentTile> {
  final Benificiary benificiary;

  _ContentTileState(this.benificiary);
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          child: ListTile(
            title: Text(
              "${benificiary.fullName}",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text("Nome do participante"),
          ),
        ),
        Card(
          child: ListTile(
            title: Text(
              Syncronization.getDistricts()
                      .values
                      .where((element) =>
                          element.uuid == benificiary.districtUuid)
                      .isNotEmpty
                  ?  Syncronization.getDistricts()
                      .values
                      .where((element) =>
                          element.uuid == benificiary.districtUuid)
                      .first
                      .name
                  : "",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text("Distrito"),
          ),
        ),
          Card(
          child: ListTile(
            title: Text( "${benificiary.zone}",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text("Bairro"),
          ),
        ),
         Card(
          child: ListTile(
            title: Text( "${benificiary.location}",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text("Localidade"),
          ),
        ),
        Card(
          child: ListTile(
            title: Text(
              Syncronization.getGenres()
                      .values
                      .where((element) => element.uuid == benificiary.genreUuid)
                      .isNotEmpty
                  ? Syncronization.getGenres()
                      .values
                      .where((element) => element.uuid == benificiary.genreUuid)
                      .first
                      .name
                  : "",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text("Sexo"),
          ),
        ),
        Card(
          child: ListTile(
            title: Text(
              "${benificiary.age}",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text("Idade"),
          ),
        ),
        Card(
          child: ListTile(
            title: Text( "${benificiary.qualification}",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text("Qualificacoes academicas/profissionais"),
          ),
        ),
        Card(
          child: ListTile(
            title: Text(
              Syncronization.getProjectAreas()
                      .values
                      .where((element) =>
                          element.uuid == benificiary.projectAreaUuid)
                      .isNotEmpty
                  ? Syncronization.getProjectAreas()
                      .values
                      .where((element) =>
                          element.uuid == benificiary.projectAreaUuid)
                      .first
                      .name
                  : "",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text("Area do projecto"),
          ),
        ),
        Card(
          child: ListTile(
            title: Text(
              Syncronization.getBenefits()
                      .values
                      .where((element) =>
                          element.uuid == benificiary.benefitUuid)
                      .isNotEmpty
                  ? Syncronization.getBenefits()
                      .values
                      .where((element) =>
                          element.uuid == benificiary.benefitUuid)
                      .first
                      .name
                  : "",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text("Beneficio recebido"),
          ),
        ),
        ],
    );
  }
}
