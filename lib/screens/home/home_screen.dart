import 'package:flutter/material.dart';
import 'package:pin_code/constant/app_constant.dart';

import '../../firebase/firebase_service.dart';
import '../../model/office.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _controller;
  final FirebaseService _service = FirebaseService();

  final TextEditingController _searchController = TextEditingController();
  List<Office> _quickSearchResults = [];

  String? _selectedState = null;
  String? _selectedDistrict = null;
  String? _selectedTaluk = null;

  void _searchByAll(String query) async {
    if (query.isNotEmpty) {
      final results = await FirebaseService().searchItemByAll(query);
      setState(() {
        _quickSearchResults = results;
      });
    } else {
      setState(() {
        _quickSearchResults = [];
      });
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

  void _searchByDistrict(String query) async {
    if (query.isNotEmpty) {
      final results = await FirebaseService().searchItemByDistrict(query);
      setState(() {
        _quickSearchResults = results;
      });
    } else {
      setState(() {
        _quickSearchResults = [];
      });
    }
  }

  void _searchByTaluka(String query) async {
    if (query.isNotEmpty) {
      final results = await FirebaseService().searchItemByTaluka(query);
      setState(() {
        _quickSearchResults = results;
      });
    } else {
      setState(() {
        _quickSearchResults = [];
      });
    }
  }

  void _searchByPincode(String query) async {
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

  int selectedRadio = 1;

  setSelectedRadio(val) {
    setState(() {
      switch (selectedRadio) {
        case 1:
          _searchByPincode;
          print('1');
          break;
        case 2:
          _searchByStateName;
          print('2');
          break;
        case 3:
          _searchByOfcName;
          print('3');
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadOfcList();
    _controller = TabController(length: 3, vsync: this);
  }

  List<Office> _ofcList = [];

  Future<void> _loadOfcList() async {
    List<Office> ofcList = await _service.loadOfc();
    setState(() {
      _ofcList = ofcList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pin Code'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text('Add Office'),
                  onTap: () {
                    Navigator.pushNamed(
                        context, AppConstant.addOfficeFormScreen);
                  },
                ),
                PopupMenuItem(
                  child: Text('All Office'),
                  onTap: () {
                    Navigator.pushNamed(
                        context, AppConstant.allOffice);
                  },
                )
              ];
            },
          )
        ],
        bottom: TabBar(
          controller: _controller,
          tabs: [
            Tab(
              text: 'QUICK SEARCH',
            ),
            Tab(
              text: 'SEARCH BY AREA',
            ),
            Tab(
              text: 'SAVED RECORDS',
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [quickSearch(), searchByArea(), SavedRecord()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          int selectedIndex = _controller.index;
          print('selected index : ${selectedIndex}');
          if (selectedIndex < _controller.length - 1) {
            selectedIndex++;
            _controller.animateTo(selectedIndex);
          } else {
            // last page
            _controller.animateTo(0);
          }
        },
        child: Icon(Icons.navigate_next_outlined),
      ),
    );
  }

  Widget quickSearch() {
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
                      selectedRadio = val!;
                      setSelectedRadio(val);
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: Text(
                      'By District',
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                    ),
                    value: 2,
                    groupValue: selectedRadio,
                    onChanged: (val) {
                      selectedRadio = val!;
                      setSelectedRadio(val);
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
                      selectedRadio = val!;
                      setSelectedRadio(val);
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
                    onChanged: _searchByAll,
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

  Widget searchByArea() {
    Set<String> uniqueState = Set();
    Set<String> uniqueDistrict = Set();
    Set<String> uniqueTaluka = Set();
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
            SizedBox(
              height: 16,
            ),
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
                    // }
                    //
                    // if (_selectedState == null || _selectedTaluk == null) {
                    //   _searchByDistrict(_selectedDistrict!);
                    // }
                    //
                    // if (_selectedState == null || _selectedDistrict == null) {
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
  }

  Widget SavedRecord() {
    return Center(
      child: Text("It's SavedRecord"),
    );
  }
}
