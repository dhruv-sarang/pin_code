import 'package:flutter/material.dart';

import '../../firebase/firebase_service.dart';
import '../../model/office.dart';

class SearchByAreaView extends StatefulWidget {
  const SearchByAreaView({super.key});

  @override
  State<SearchByAreaView> createState() => _SearchByAreaViewState();
}

class _SearchByAreaViewState extends State<SearchByAreaView> {
  List<Office> _ofcList = [];
  List<Office> _quickSearchResults = [];
  final FirebaseService _service = FirebaseService();

  String? _selectedState = null;

  // String? _selectedDistrict = null;
  // String? _selectedTaluk = null;

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

  Future<void> _loadOfcList() async {
    List<Office> ofcList = await _service.loadOfc();
    setState(() {
      _ofcList = ofcList;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadOfcList();
  }

  void toggleFavoriteStatus(Office office) {
    setState(() {
      office.isLike = !office.isLike;
      updateIsLike(office.id, office.isLike);
    });
  }

  Set<String> uniqueState = Set();

  // Set<String> uniqueDistrict = Set();
  // Set<String> uniqueTaluka = Set();

  /* @override
  Widget build(BuildContext context) {
    _ofcList.forEach((Office ofc) {
      uniqueState.add(ofc.state!);
      uniqueDistrict.add(ofc.district!);
      uniqueTaluka.add(ofc.taluka!);
    });
    List<String> uniqueStateList = uniqueState.toList();
    List<String> uniqueDistrictList = uniqueDistrict.toList();
    List<String> uniqueTalukaList = uniqueTaluka.toList();
    return Container(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedState,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Select State',
              ),
              items:
                  uniqueStateList.map<DropdownMenuItem<String>>((String state) {
                return DropdownMenuItem<String>(
                  value: state,
                  child: Text('$state'),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedState = value!;
                });
              },
              onSaved: (newValue) {
                _selectedState = newValue!;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select';
                }
                return null;
              },
            ),
            SizedBox(
              height: 16,
            ),
            DropdownButtonFormField<String>(
              value: _selectedDistrict,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Select District',
              ),
              items: uniqueDistrictList
                  .map<DropdownMenuItem<String>>((String district) {
                return DropdownMenuItem<String>(
                  value: district,
                  child: Text('$district'),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedDistrict = value!;
                });
              },
              onSaved: (newValue) {
                _selectedDistrict = newValue!;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select';
                }
                return null;
              },
            ),
            SizedBox(
              height: 16,
            ),
            DropdownButtonFormField<String>(
              value: _selectedTaluk,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Select Taluka',
              ),
              items: uniqueTalukaList
                  .map<DropdownMenuItem<String>>((String taluka) {
                return DropdownMenuItem<String>(
                  value: taluka,
                  child: Text('$taluka'),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedTaluk = value!;
                });
              },
              onSaved: (newValue) {
                _selectedTaluk = newValue!;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select';
                }
                return null;
              },
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: <Widget>[
                FilledButton(
                  onPressed: () {
                    _searchByStateName(_selectedState!);
                    // _searchByDistrict(_selectedDistrict!);
                    // _searchByTaluka(_selectedTaluk!);

                    // if (_selectedDistrict == null || _selectedTaluk == null) {
                    //   _searchByStateName(_selectedState!);
                    // }else if (_selectedState == null || _selectedTaluk == null) {
                    //   _searchByDistrict(_selectedDistrict!);
                    // }else if (_selectedState == null || _selectedDistrict == null) {
                    //   _searchByTaluka(_selectedTaluk!);
                    // }

                    print('${_selectedState}');
                  },
                  child: Text('SEARCH'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.red.shade400),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                FilledButton(
                  onPressed: () {
                    setState(() {
                      _selectedState = null;
                      _selectedDistrict = null;
                      _selectedTaluk = null;
                      _quickSearchResults = [];
                    });
                  },
                  child: Text('CLEAR'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.red.shade400),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Container(
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
            )
          ],
        ),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    _ofcList.forEach((Office ofc) {
      uniqueState.add(ofc.state!);
      // uniqueDistrict.add(ofc.district!);
      // uniqueTaluka.add(ofc.taluka!);
    });

    List<String> uniqueStateList = uniqueState.toList();
    // List<String> uniqueDistrictList = uniqueDistrict.toList();
    // List<String> uniqueTalukaList = uniqueTaluka.toList();

    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
                DropdownButtonFormField<String>(
                  value: _selectedState,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Select State',
                  ),
                  items: uniqueStateList
                      .map<DropdownMenuItem<String>>((String state) {
                    return DropdownMenuItem<String>(
                      value: state,
                      child: Text('$state'),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedState = value!;
                    });
                  },
                  onSaved: (newValue) {
                    _selectedState = newValue!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: <Widget>[
                    FilledButton(
                      onPressed: () {
                        _searchByStateName(_selectedState!);
                        print('${_selectedState}');
                      },
                      child: Text('SEARCH'),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.red.shade400),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    FilledButton(
                      onPressed: () {
                        setState(() {
                          _selectedState = null;
                          // _selectedDistrict = null;
                          // _selectedTaluk = null;
                          _quickSearchResults = [];
                        });
                      },
                      child: Text('CLEAR'),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.red.shade400),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(8),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
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
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(child: Text('${ofc.pinCode}')),
                            ),
                            SizedBox(width: 16),
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
                            SizedBox(width: 8),
                            Icon(Icons.share),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: _quickSearchResults.length,
            ),
          ),
        ),
      ],
    );
  }
}
