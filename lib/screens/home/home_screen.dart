import 'package:flutter/material.dart';
import 'package:pin_code/constant/app_constant.dart';
import 'package:pin_code/screens/quickSearch/quickSearch.dart';
import 'package:pin_code/screens/searchByArea/searchByArea.dart';
import '../savedRecord/sarveRecord.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this); // Initialize the TabController
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
                    Navigator.pushNamed(context, AppConstant.allOffice);
                  },
                )
              ];
            },
          )
        ],
        bottom: TabBar(
          controller: _controller,
          tabs: const [
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
        children: [QuickSearchView(), SearchByAreaView(), SavedRecordView()],
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
}
