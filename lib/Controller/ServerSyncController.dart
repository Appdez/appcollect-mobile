import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
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
    /*
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
    }*/
    return true;
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

          //benefits sync database
          var benefits = data['benefits'];

          var listBenefits = List.generate(benefits.length, (index) {
            return Benefit.fromJson(benefits[index]);
          });
          Syncronization.getBenefits()
              .deleteAll(Syncronization.getBenefits().keys);
          listBenefits.forEach((element) {
            Syncronization.getBenefits().put(element.uuid, element);
          });

          ///districts  sync database
          var districts = data['districts'];

          var listDistricts = List.generate(districts.length, (index) {
            return District.fromJson(districts[index]);
          });
          Syncronization.getDistricts()
              .deleteAll(Syncronization.getDistricts().keys);

          listDistricts.forEach((element) {
            Syncronization.getDistricts().put(element.uuid, element);
          });

          ///project_areas  sync database
          var projectAreas = data['project_areas'];

          var listProjectAreas = List.generate(projectAreas.length, (index) {
            return ProjectArea.fromJson(projectAreas[index]);
          });
          Syncronization.getProjectAreas()
              .deleteAll(Syncronization.getProjectAreas().keys);

          listProjectAreas.forEach((element) {
            Syncronization.getProjectAreas().put(element.uuid, element);
          });

          //benificiaries

          var benificiariesxs = data['benificiaries'];
          var listBenificiaries = List.generate(benificiariesxs.length, (index) {
            var benificiaries = benificiariesxs[index];
            benificiaries['full_name'] = benificiaries['full_name'] != null
                ? benificiaries['full_name']
                : "";
            benificiaries['age'] =
                benificiaries['age'] != null ? benificiaries['age'] : 0;
            benificiaries['qualification'] =
                benificiaries['qualification'] != null
                    ? benificiaries['qualification']
                    : "";
            benificiaries['form_number'] = benificiaries['form_number'] != null
                ? benificiaries['form_number']
                : 0;
            benificiaries['zone'] =
                benificiaries['zone'] != null ? benificiaries['zone'] : "";
            benificiaries['location'] = benificiaries['location'] != null
                ? benificiaries['location']
                : "";
            benificiaries['district_uuid'] =
                benificiaries['district_uuid'] != null
                    ? benificiaries['district_uuid']
                    : "";
            benificiaries['benefit_uuid'] =
                benificiaries['benefit_uuid'] != null
                    ? benificiaries['benefit_uuid']
                    : "";
            benificiaries['project_area_uuid'] =
                benificiaries['project_area_uuid'] != null
                    ? benificiaries['project_area_uuid']
                    : "";
            benificiaries['genre_uuid'] = benificiaries['genre_uuid'] != null
                ? benificiaries['genre_uuid']
                : "";
            return Benificiary.fromJson(benificiaries);
          });
          Syncronization.getBeneficiaries()
              .deleteAll(Syncronization.getBeneficiaries().keys);
          listBenificiaries.forEach((element) {
            Syncronization.getBeneficiaries().put(element.uuid, element);
          });
          return true;
        } catch (e) {
          //   throw e;
          //print("1. $e");
          return false;
        }
      } else {
        // print(json.decode(await response.stream.bytesToString()));
        return false;
      }
    } catch (e) {
      // throw e;
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
//          throw e;
          return false;
        }
      }
    } catch (e) {
      //    throw e;
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
          //      throw e;
          //      print("5. $e");
          return false;
        }
      }
    } catch (e) {
      //throw e;
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
          //  throw e;
          // print("7. $e");
          return false;
        }
      }
    } catch (e) {
      //throw e;
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
