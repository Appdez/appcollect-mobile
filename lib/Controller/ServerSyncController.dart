import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'BenificiaryController.dart';
import '../Model/Benefit/Benefit.dart';
import '../Model/Benificiary/Benificiary.dart';
import '../Model/Genre/Genre.dart';
import '../Model/ProjectArea/ProjectArea.dart';
import '../Model/District/District.dart';
class ServerSyncController {
  final headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ' + Hive.box('token').get('token').toString(),
    'Content-Type': 'application/json'
  };
  final baseUrl = "https://www.appio.sumburero.org/api/sync";

  Future<bool> getRepport(String bairro) async {
    var request =
        http.Request('GET', Uri.parse('${this.baseUrl}/report/$bairro'));
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = await response.stream.bytesToString();
        return await launch(data);
      } else
        return false;
    } catch (e) {
      //print(e);
      return false;
    }
  }

  Future<bool> settingsOnServer() async {
    var request = http.Request('GET', Uri.parse('${this.baseUrl}/settings'));
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(await response.stream.bytesToString());
        try {
          ///genres sync database
          var genres = data['genres'];
          var listGenres = List.generate(genres.length, (index) {
            return Genre.fromJson(genres[index]);
          });
          Syncronization.getGenres().deleteAll(Syncronization.getGenres().keys);
          listGenres.forEach((element) {
            Syncronization.getGenres().put(element.uuid, element);
          });

          ///Document type sync database
          var documentTypes = data['document_types'];
          var listBenefits = List.generate(documentTypes.length, (index) {
            return Benefit.fromJson(documentTypes[index]);
          });
          Syncronization.getBenefits()
              .deleteAll(Syncronization.getBenefits().keys);
          listBenefits.forEach((element) {
            Syncronization.getBenefits().put(element.uuid, element);
          });

          ///forwarded_services  sync database
          var forwardedServices = data['forwarded_services'];
          var listDistricts =
              List.generate(forwardedServices.length, (index) {
            return District.fromJson(forwardedServices[index]);
          });
          Syncronization.getDistricts()
              .deleteAll(Syncronization.getDistricts().keys);

          listDistricts.forEach((element) {
            Syncronization.getDistricts().put(element.uuid, element);
          });

          ///neighborhoods  sync database
          var neighborhoods = data['neighborhoods'];
          var listProjectAreas = List.generate(neighborhoods.length, (index) {
            return ProjectArea.fromJson(neighborhoods[index]);
          });
          Syncronization.getProjectAreas()
              .deleteAll(Syncronization.getProjectAreas().keys);

          listProjectAreas.forEach((element) {
            Syncronization.getProjectAreas().put(element.uuid, element);
          });

         
          //benificiaries

          var benificiaries = data['benificiaries'];

          var listBenificiaries = List.generate(benificiaries.length, (index) {
            benificiaries[index]['number_of_visits'] =
                benificiaries[index]['number_of_visits'] != null
                    ? "${benificiaries[index]['number_of_visits']}"
                    : "";

            benificiaries[index]['phone'] =
                benificiaries[index]['phone'] != null
                    ? '${benificiaries[index]["phone"]}'
                    : ""; //
            return Benificiary.fromJson(benificiaries[index]);
          });
          Syncronization.getBeneficiaries()
              .deleteAll(Syncronization.getBeneficiaries().keys);

          listBenificiaries.forEach((element) {
            Syncronization.getBeneficiaries().put(element.uuid, element);
          });
          return true;
        } catch (e) {
          //print("1. $e");
          return false;
        }
      } else {
        // print(json.decode(await response.stream.bytesToString()));
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> storingCratedOnServer() async {
    var request = http.Request('POST', Uri.parse('${this.baseUrl}/create'));

    var created = Syncronization.sortedList(
            Syncronization.getCreatedBeneficiaries().values.toList())
        .map((e) => e.toJson())
        .toList();
    request.body = json.encode(created);
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          Syncronization.getCreatedBeneficiaries()
              .deleteAll(Syncronization.getCreatedBeneficiaries().keys);
          var result = await response.stream.bytesToString();

          (json.decode(result)).forEach((element) {
            Syncronization.getCreatedBeneficiaries()
                .put(element['uuid'], Benificiary.fromJson(element));
          });
          return true;
        } catch (e) {
          return false;
        }
      }
    } catch (e) {
      //throw e;
      // print("4. $e");
      return false;
    }
    return false;
  }

  Future<bool> storingUpdatedOnServer() async {
    var request = http.Request('POST', Uri.parse('${this.baseUrl}/update'));
    var updated = Syncronization.sortedList(
            Syncronization.getUpdatedBeneficiaries().values.toList())
        .map((e) => e.toJson())
        .toList();

    request.body = json.encode(updated);
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          Syncronization.getUpdatedBeneficiaries()
              .deleteAll(Syncronization.getUpdatedBeneficiaries().keys);
          var result = await response.stream.bytesToString();

          (json.decode(result)).forEach((element) {
            Syncronization.getUpdatedBeneficiaries()
                .put(element['uuid'], Benificiary.fromJson(element));
          });
          return true;
        } catch (e) {
          //      print("5. $e");
          return false;
        }
      }
    } catch (e) {
      // print("6. $e");
      return false;
    }
    return false;
  }

  Future<bool> deletingOnServer() async {
    var request = http.Request('POST', Uri.parse('${this.baseUrl}/delete'));
    var deleted = Syncronization.getDeletedBeneficiaries()
        .values
        .map((e) => e.toJson())
        .toList();

    request.body = json.encode(deleted);
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        try {
          Syncronization.getDeletedBeneficiaries()
              .deleteAll(Syncronization.getDeletedBeneficiaries().keys);
          var result = await response.stream.bytesToString();
          (json.decode(result)).forEach((element) {
            Syncronization.getDeletedBeneficiaries()
                .put(element['uuid'], Benificiary.fromJson(element));
          });
          return true;
        } catch (e) {
          // print("7. $e");
          return false;
        }
      }
    } catch (e) {
      //print("8. $e");
      return false;
    }
    return false;
  }

  Future<bool> syncSettings() async {
    var test = await storingCratedOnServer();
    var test1 = await storingUpdatedOnServer();
    var test2 = await deletingOnServer();
    var test3 = await settingsOnServer();

    if (test == true && test1 == true && test2 == true && test3 == true) {
      return true;
    } else {
      return false;
    }
  }
}
