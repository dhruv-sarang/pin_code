import 'package:flutter/material.dart';

import '../../firebase/firebase_service.dart';
import '../../model/office.dart';

class SavedRecordView extends StatefulWidget {
  const SavedRecordView({super.key});

  @override
  State<SavedRecordView> createState() => _SavedRecordViewState();
}

class _SavedRecordViewState extends State<SavedRecordView> {
  final FirebaseService _service = FirebaseService();

  @override
  Future<void> updateIsLike(String? id, bool isLike) async {
    try {
      bool isUpdateSuccessful = await _service.updateIsLike(id!, isLike);

      if (isUpdateSuccessful) {
        print('isLike field updated successfully!');
      } else {
        print('Failed to update isLike field.');
      }
    } catch (e) {
      print('Failed to update isLike field: $e');
    }
  }

  void toggleFavoriteStatus(Office office) {
    setState(() {
      office.isLike = !office.isLike;
      updateIsLike(office.id, office.isLike);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: StreamBuilder(
        stream: _service.getSavedOfcStream(),
        builder: (context, snapshot) {
          List<Office> ofcList = snapshot.data ?? [];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: ListView.builder(
                itemCount: ofcList.length,
                itemBuilder: (context, index) {
                  Office ofc = ofcList[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 50,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Colors.red.shade300,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(child: Text('${ofc.pinCode}')),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${ofc.ofcName}'),
                                  Text('${ofc.taluka}, ${ofc.state}'),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  toggleFavoriteStatus(ofc);
                                },
                                child: Icon(
                                  ofc.isLike
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.red,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Icon(Icons.share),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    ));
  }
}
