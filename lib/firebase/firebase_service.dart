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

  final Map<String, ValueNotifier<bool>> _favorites = {};

  // void toggleFavorite(String productId) {
  //     final ref = _databaseReference
  //         .child('ofc');
  //     ref.get().then((snapshot) async {
  //       final isFavoriteNow = !snapshot.exists;
  //       if (isFavoriteNow) {
  //         await ref.set(true);
  //       } else {
  //         await ref.remove();
  //       }
  //
  //       // Update the local ValueNotifier for this product's favorite status
  //       _favorites[productId]?.value = isFavoriteNow;
  //     });
  // }
  //
  // void removeFavorite(String productId) {
  //     _databaseReference
  //         .child('ofc')
  //         .remove();
  //
  // }
  //
  // Future<bool> getFavorite(String productId) async {
  //     final snapshot = await _databaseReference
  //         .child('ofc')
  //         .get();
  //     if (snapshot.exists) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //
  // }
  //
  // ValueNotifier<bool> getFavoriteNotifier(String productId) {
  //   // If the notifier doesn't exist, create it with a default value of false
  //   _favorites.putIfAbsent(productId, () => ValueNotifier<bool>(false));
  //   return _favorites[productId]!;
  // }
  //
  // void updateFavorites(bool isFavorite, String productId) {
  //   _favorites[productId]?.value = isFavorite;
  // }
  //
  // Future<List<String>> fetchUserFavoriteItemIds(String userId) async {
  //   final snapshot = await _database.ref().child('userFavorites/$userId').get();
  //   if (snapshot.exists && snapshot.value != null) {
  //     Map<dynamic, dynamic> favorites =
  //     Map<dynamic, dynamic>.from(snapshot.value as Map<dynamic, dynamic>);
  //     return favorites.keys.cast<String>().toList();
  //   } else {
  //     return [];
  //   }
  // }
  //
  //
  // Stream<List<Map<dynamic, dynamic>>> fetchUserFavoriteItemsStream() {
  //   var userId = _auth.currentUser!.uid;
  //
  //   // Stream.fromFuture is used here if fetchUserFavoriteItemIds returns a Future.
  //   // If it's already a Stream, you can directly use it without Stream.fromFuture.
  //   return Stream.fromFuture(fetchUserFavoriteItemIds(userId)).asyncMap((favoriteItemIds) async {
  //     // Using Future.wait to concurrently fetch all item details
  //     var futures = favoriteItemIds.map((itemId) => fetchItemDetails(itemId));
  //     List<Map<dynamic, dynamic>> favoriteItemsDetails = await Future.wait(futures);
  //     // Filtering out empty or null itemDetails if necessary
  //     return favoriteItemsDetails.where((itemDetails) => itemDetails.isNotEmpty).toList();
  //   });
  // }



}
