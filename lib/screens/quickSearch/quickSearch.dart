import 'package:flutter/material.dart';

import '../../firebase/firebase_service.dart';
import '../../model/office.dart';

class QuickSearchView extends StatefulWidget {
  @override
  State<QuickSearchView> createState() => _QuickSearchViewState();
}

class _QuickSearchViewState extends State<QuickSearchView> {
  int selectedRadio = 1;
  final TextEditingController _searchController = TextEditingController();
  List<Office> _quickSearchResults = [];

  void _searchByStateName(String query) async {
    if (query.isNotEmpty) {
      final results = await FirebaseService().searchItemByStateName(query);
      setState(() {
        _quickSearchResults = results;
      });
    } else {
      setState(() {
        _quickSearchResults = [];
      });
    }
  }

  void _searchByPinCode(String query) async {
    if (query.isNotEmpty) {
      final results = await FirebaseService().searchItemByPincode(query);
      setState(() {
        _quickSearchResults = results;
      });
    } else {
      setState(() {
        _quickSearchResults = [];
      });
    }
  }

  void _searchByOfcName(String query) async {
    if (query.isNotEmpty) {
      final results = await FirebaseService().searchItemByOfcName(query);
      setState(() {
        _quickSearchResults = results;
      });
    } else {
      setState(() {
        _quickSearchResults = [];
      });
    }
  }

  void _handleSearch(String query) {
    if (selectedRadio == 1) {
      _searchByPinCode(query.toString().trim());
    } else if (selectedRadio == 2) {
      _searchByStateName(query.toString().trim());
    } else if (selectedRadio == 3) {
      _searchByOfcName(query.toString().trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 60,
            color: Colors.deepOrange,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: RadioListTile(
                    title: Text(
                      'BY PIN',
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                    ),
                    value: 1,
                    groupValue: selectedRadio,
                    onChanged: (val) {
                      setState(() {
                        selectedRadio = val!;
                      });
                      // setSelectedRadio(val);
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: Text(
                      'By State',
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                    ),
                    value: 2,
                    groupValue: selectedRadio,
                    onChanged: (val) {
                      setState(() {
                        selectedRadio = val!;
                      }); // setSelectedRadio(val);
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: Text(
                      'By Office Name',
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                    ),
                    value: 3,
                    groupValue: selectedRadio,
                    onChanged: (val) {
                      setState(() {
                        selectedRadio = val!;
                      }); // setSelectedRadio(val);
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: Row(
              children: [
                Icon(Icons.search),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      _handleSearch(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter text',
                      // suffixIcon: Icon(Icons.cancel_outlined),
                      labelStyle: TextStyle(color: Colors.black),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 2.0, color: Colors.blue),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              // color: Colors.red,
              height: 500,
              width: double.infinity,
              child: ListView.builder(
                itemCount: _quickSearchResults.length,
                itemBuilder: (context, index) {
                  Office ofc = _quickSearchResults[index];
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
                              Icon(Icons.favorite),
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
          )
        ],
      ),
    );
  }
}
