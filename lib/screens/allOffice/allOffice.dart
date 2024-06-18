import 'package:flutter/material.dart';

import '../../firebase/firebase_service.dart';
import '../../model/office.dart';

class AllOffice extends StatefulWidget {
  const AllOffice({super.key});

  @override
  State<AllOffice> createState() => _AllOfficeState();
}

class _AllOfficeState extends State<AllOffice> {
  List<Office> _ofcList = [];
  final FirebaseService _service = FirebaseService();
  // bool isFavorite = false;
  List<bool> isFavoriteList = [];

  // Future<void> _loadOfcList() async {
  //   List<Office> ofcList = await _service.loadOfc();
  //   setState(() {
  //     _ofcList = ofcList;
  //   });
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _loadOfcList();
  // }

  Future<void> updateIsLike(String? id, bool isFavorite) async {
    bool isUpdateSuccessful = await _service.updateIsLike(id!, isFavorite);

    if (isUpdateSuccessful) {
      print('isLike field updated successfully!');
    } else {
      print('Failed to update isLike field.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('All Offices'),
        ),
        body: SafeArea(
          child: StreamBuilder(
            stream: _service.getOfcStream(),
            builder: (context, snapshot) {
              List<Office> ofcList = snapshot.data ?? [];
              isFavoriteList = List.generate(ofcList.length, (index) => ofcList[index].isLike ?? false);

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
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child:
                                        Center(child: Text('${ofc.pinCode}')),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('${ofc.ofcName}'),
                                      Text('${ofc.taluka}, ${ofc.state}'),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  // Icon(Icons.favorite),

                                  // ValueListenableBuilder<bool>(
                                  //   valueListenable: FirebaseService().getFavoriteNotifier(ofcList[index].id!),
                                  //   builder: (context, isFavorite, _) {
                                  //
                                  //     return InkWell(
                                  //       onTap: () {
                                  //         FirebaseService().toggleFavorite(ofcList[index].id!);
                                  //       },
                                  //       child: Icon(
                                  //         isFavorite
                                  //             ? Icons.favorite
                                  //             : Icons.favorite_border,
                                  //         color: Colors.red,
                                  //       ),
                                  //     );
                                  //   },
                                  // ),

                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        // isFavorite = !isFavorite;
                                        // updateIsLike(ofc.id, isFavorite);
                                        isFavoriteList[index] = !isFavoriteList[index];
                                        updateIsLike(ofc.id!, isFavoriteList[index]);

                                        // ofcList[index].isFavorite = isFavorite;
                                      });
                                    },
                                    child: Icon(
                                      isFavoriteList[index]
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
