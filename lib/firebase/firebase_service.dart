import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pin_code/model/office.dart';

class FirebaseService {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  static final FirebaseService _instance = FirebaseService._internal();

  factory FirebaseService() {
    return _instance;
  }

  FirebaseService._internal();

  Future<bool> addOfc(
      {String? ofcId,
      int? createdAt,
      required String ofcName,
      required int pinCode,
      required String taluka,
      required String district,
      required String state,
      required int teleNo,
      required String ofcType,
      required String delivStat,
      required String headOfc,
      required String division,
      required String region,
      required String circle,
      required BuildContext context}) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => Center(
          child: CircularProgressIndicator(
            color: Colors.red,
          ),
        ),
      );

      int timestamp = createdAt ?? DateTime.now().millisecondsSinceEpoch;

      Office office = Office(
        id: ofcId,
        createdAt: timestamp,
        ofcName: ofcName,
        pinCode: pinCode,
        taluka: taluka,
        district: district,
        state: state,
        teleNo: teleNo,
        ofcType: ofcType,
        delivStat: delivStat,
        headOfc: headOfc,
        division: division,
        region: region,
        circle: circle,
        isLike: false
      );

      if (ofcId == null) {
        // create
        var id = _databaseReference.child('ofc').push().key;
        office.id = id;

        _databaseReference.child('ofc').child(office.id!).set(office.toMap());
      } else {
        // update
        _databaseReference
            .child('ofc')
            .child(office.id!)
            .update(office.toMap());
      }

      Navigator.pop(context);
      return true;
    } catch (e) {
      Navigator.pop(context);
      return false;
    }
  }

  Stream<List<Office>> getOfcStream() {
    return _databaseReference.child("ofc").onValue.map((event) {
      List<Office> ofcList = [];
      if (event.snapshot.exists) {
        Map<dynamic, dynamic> values =
            event.snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          final ofc = Office.fromMap(value);
          ofcList.add(ofc);
        });
      }
      return ofcList;
    });
  }

  Stream<List<Office>> getSavedOfcStream() {
    return _databaseReference.child("ofc").onValue.map((event) {
      List<Office> ofcList = [];
      if (event.snapshot.exists) {
        Map<dynamic, dynamic> values =
        event.snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          final ofc = Office.fromMap(value);
          if (ofc.isLike!) {
            ofcList.add(ofc);
          }
        });
      }
      return ofcList;
    });
  }

  Future<List<Office>> loadOfc() async {
    DataSnapshot snapshot = await _databaseReference.child('ofc').get();
    List<Office> ofcList = [];
    if (snapshot.exists) {
      Map<dynamic, dynamic> categoriesMap =
          snapshot.value as Map<dynamic, dynamic>;
      categoriesMap.forEach((key, value) {
        final ofc = Office.fromMap(value);
        ofcList.add(ofc);
      });
    }
    return ofcList;
  }

  Future<List<Office>> searchItemByAll(String query) async {
    final allIOfc = await loadOfc();

    return allIOfc
        .where((item) =>
            item.state!.toLowerCase().contains(query.toLowerCase()) ||
            item.ofcName!.toLowerCase().contains(query.toLowerCase()) ||
            item.pinCode!
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            item.district!.toLowerCase().contains(query.toLowerCase()) ||
            item.taluka!.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<List<Office>> searchItemByStateName(String query) async {
    final allIOfc = await loadOfc();

    return allIOfc
        .where(
            (item) => item.state!.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<List<Office>> searchItemByDistrict(String query) async {
    final allIOfc = await loadOfc();

    return allIOfc
        .where((item) =>
            item.district!.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<List<Office>> searchItemByTaluka(String query) async {
    final allIOfc = await loadOfc();

    return allIOfc
        .where(
            (item) => item.taluka!.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<List<Office>> searchItemByPincode(String query) async {
    final allIOfc = await loadOfc();

    return allIOfc
        .where((item) => item.pinCode!
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
  }

  Future<List<Office>> searchItemByOfcName(String query) async {
    final allIOfc = await loadOfc();

    return allIOfc
        .where(
            (item) => item.ofcName!.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }



  Future<bool> updateIsLike(String officeId, bool newIsLikeValue) async {
    try {
      // Get the reference to the specific office node in the database
      DatabaseReference officeRef = _databaseReference.child('ofc').child(officeId);

      // Fetch the current office data
      DataSnapshot snapshot = await officeRef.get();
      if (!snapshot.exists) {
        return false; // Office with the given ID not found
      }

      // Update the 'isLike' field to the new value
      await officeRef.update({'isLike': newIsLikeValue});

      return true; // Successfully updated 'isLike' field
    } catch (e) {
      print('Error updating isLike field: $e');
      return false; // Error occurred while updating
    }
  }

}
