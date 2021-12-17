

import 'package:flutter/foundation.dart';

import '../Model/Benificiary/Benificiary.dart';
import '../Model/Benefit/Benefit.dart';
import '../Model/District/District.dart';
import '../Model/Genre/Genre.dart';
import '../Model/ProjectArea/ProjectArea.dart';
import 'package:hive_flutter/adapters.dart';

class Syncronization {
  static getToken() => Hive.box('token');

  static Box<Benificiary> getCreatedBeneficiaries() =>
      Hive.box<Benificiary>('createdBenificiaries');

  static Box<Benificiary> getUpdatedBeneficiaries() =>
      Hive.box<Benificiary>('updatedBenificiaries');

  static Box<Benificiary> getDeletedBeneficiaries() =>
      Hive.box<Benificiary>('deletedBenificiaries');

  static Box<Benificiary> getBeneficiaries() =>
      Hive.box<Benificiary>('benificiaries');

  ///Settings of Aplicattion
  static Box<Benefit> getBenefits() =>
      Hive.box<Benefit>('benefit');

  static Box<District> getDistricts() =>
      Hive.box<District>('district');

  static Box<Genre> getGenres() => Hive.box<Genre>('genres');

  static Box<ProjectArea> getProjectAreas() =>
      Hive.box<ProjectArea>('project_area');

 
  ///Initialization of box storage
  static Future<void> boot() async {
    await Hive.initFlutter();
    Hive.registerAdapter(BenificiaryAdapter());
    Hive.registerAdapter(BenefitAdapter());
    Hive.registerAdapter(DistrictAdapter());
    Hive.registerAdapter(GenreAdapter());
    Hive.registerAdapter(ProjectAreaAdapter());
    //
    await Hive.openBox<Benificiary>('createdBenificiaries');
    await Hive.openBox<Benificiary>('updatedBenificiaries');
    await Hive.openBox<Benificiary>('deletedBenificiaries');
    await Hive.openBox<Benificiary>('benificiaries');
    await Hive.openBox('token');

    ///Settings of Aplicattion
    await Hive.openBox<Benefit>('benefit');
    await Hive.openBox<District>('district');
    await Hive.openBox<Genre>('genres');
    await Hive.openBox<ProjectArea>('project_area');

  }

  Benificiary? getBenificiary(String uuid) {
    var beneficiary = getBeneficiaries().get(uuid);
    if (beneficiary != null) return Benificiary.fromJson(beneficiary.toJson());
    return null;
  }

  static bool addCreated(Benificiary benificiary) {
    try {
      getBeneficiaries().put(benificiary.uuid, benificiary);
      var mirror = Benificiary.fromJson(benificiary.toJson());
      getCreatedBeneficiaries().put(mirror.uuid, mirror);
      return true;
    } catch (e) {
      return false;
    }
  }

  static bool addUdated(Benificiary benificiary) {
    if (getCreatedBeneficiaries().containsKey(benificiary.uuid)) {
      try {
        var benificiaryCopy = Benificiary.fromJson(benificiary.toJson());
        getBeneficiaries().put(benificiary.uuid, benificiary);
        getCreatedBeneficiaries().put(benificiaryCopy.uuid, benificiaryCopy);
        return true;
      } catch (e) {
        return false;
      }
    } else if (getUpdatedBeneficiaries().containsKey(benificiary.uuid)) {
      try {
        var benificiaryCopy = Benificiary.fromJson(benificiary.toJson());
        getBeneficiaries().put(benificiary.uuid, benificiary);
        getUpdatedBeneficiaries().put(benificiaryCopy.uuid, benificiaryCopy);
        return true;
      } catch (e) {
        return false;
      }
    } else {
      try {
        var benificiaryCopy = Benificiary.fromJson(benificiary.toJson());
        getBeneficiaries().put(benificiary.uuid, benificiary);
        getUpdatedBeneficiaries().put(benificiaryCopy.uuid, benificiaryCopy);
        return true;
      } catch (e) {
        return false;
      }
    }
  }

  static bool addDeleted(Benificiary benificiary) {
    var benificiaries = getBeneficiaries().get(benificiary.uuid);
    var inserted = getCreatedBeneficiaries().get(benificiary.uuid);
    var updated = getUpdatedBeneficiaries().get(benificiary.uuid);
    try {
      if (inserted != null) inserted.delete();

      if (updated != null) updated.delete();

      if (benificiaries != null) benificiaries.delete();

      getDeletedBeneficiaries().put(benificiary.uuid, benificiary);

      return true;
    } catch (e) {
      return false;
    }
  }

  static List<Benificiary> sortedBenificiaries() {
    if (getBeneficiaries().isEmpty) return <Benificiary>[];
    var benificiaries = getBeneficiaries().values.toList();
    mergeSort(benificiaries, compare: (a, b) {
      a = a as Benificiary;
      b = b as Benificiary;
      return -a.createdAt.compareTo(b.createdAt);
    });
    return benificiaries;
  }

  static List<Benificiary> sortedList(List<Benificiary> list) {
    if (list.isEmpty) return <Benificiary>[];
    List<Benificiary> benificiaries = list;
    mergeSort(benificiaries, compare: (a, b) {
      a = a as Benificiary;
      b = b as Benificiary;
      return a.createdAt.compareTo(b.createdAt);
    });
    return benificiaries;
  }
}
