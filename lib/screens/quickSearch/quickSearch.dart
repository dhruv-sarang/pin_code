// import 'package:flutter/material.dart';
//
// import '../../firebase/firebase_service.dart';
// import '../../model/office.dart';
//
// class QuickSearchScreen extends StatefulWidget {
//   const QuickSearchScreen({super.key});
//
//   @override
//   State<QuickSearchScreen> createState() => _QuickSearchScreenState();
// }
//
// class _QuickSearchScreenState extends State<QuickSearchScreen> with TickerProviderStateMixin {
//
//   @override
//   Widget build(BuildContext context) {
//     int selectedRadio = 1;
//     List<Office> _quickSearchResults = [];
//
//     final TextEditingController _searchController = TextEditingController();
//
//     void _searchByAll(String query) async {
//       if (query.isNotEmpty) {
//         final results = await FirebaseService().searchItemByAll(query);
//         setState(() {
//           _quickSearchResults = results;
//         });
//       } else {
//         setState(() {
//           _quickSearchResults = [];
//         });
//       }
//     }
//
//     void _searchByStateName(String query) async {
//       if (query.isNotEmpty) {
//         final results = await FirebaseService().searchItemByStateName(query);
//         setState(() {
//           _quickSearchResults = results;
//         });
//       } else {
//         setState(() {
//           _quickSearchResults = [];
//         });
//       }
//     }
//
//
//     void _searchByPincode(String query) async {
//       if (query.isNotEmpty) {
//         final results = await FirebaseService().searchItemByPincode(query);
//         setState(() {
//           _quickSearchResults = results;
//         });
//       } else {
//         setState(() {
//           _quickSearchResults = [];
//         });
//       }
//     }
//
//     void _searchByOfcName(String query) async {
//       if (query.isNotEmpty) {
//         final results = await FirebaseService().searchItemByOfcName(query);
//         setState(() {
//           _quickSearchResults = results;
//         });
//       } else {
//         setState(() {
//           _quickSearchResults = [];
//         });
//       }
//     }
//
//
//     setSelectedRadio(val) {
//       setState(() {
//         switch (selectedRadio) {
//           case 1:
//             _searchByPincode;
//             print('1');
//             break;
//           case 2:
//             _searchByStateName;
//             print('2');
//             break;
//           case 3:
//             _searchByOfcName;
//             print('3');
//             break;
//         }
//       });
//     }
//
//
//     return SingleChildScrollView(
//       child: Column(
//         children: <Widget>[
//           Container(
//             width: double.infinity,
//             height: 60,
//             color: Colors.deepOrange,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Expanded(
//                   child: RadioListTile(
//                     title: Text(
//                       'BY PIN',
//                       style:
//                           TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
//                     ),
//                     value: 1,
//                     groupValue: selectedRadio,
//                     onChanged: (val) {
//                       selectedRadio = val!;
//                       setSelectedRadio(val);
//                     },
//                   ),
//                 ),
//                 Expanded(
//                   child: RadioListTile(
//                     title: Text(
//                       'By District',
//                       style:
//                           TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
//                     ),
//                     value: 2,
//                     groupValue: selectedRadio,
//                     onChanged: (val) {
//                       selectedRadio = val!;
//                       setSelectedRadio(val);
//                     },
//                   ),
//                 ),
//                 Expanded(
//                   child: RadioListTile(
//                     title: Text(
//                       'By Office Name',
//                       style:
//                           TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
//                     ),
//                     value: 3,
//                     groupValue: selectedRadio,
//                     onChanged: (val) {
//                       selectedRadio = val!;
//                       setSelectedRadio(val);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 16,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(right: 16, left: 16),
//             child: Row(
//               children: [
//                 Icon(Icons.search),
//                 SizedBox(
//                   width: 16,
//                 ),
//                 Expanded(
//                   child: TextField(
//                     controller: _searchController,
//                     onChanged: _searchByAll,
//                     decoration: InputDecoration(
//                       labelText: 'Enter text',
//                       // suffixIcon: Icon(Icons.cancel_outlined),
//                       labelStyle: TextStyle(color: Colors.black),
//                       focusedBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: Colors.blue),
//                       ),
//                       enabledBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(width: 2.0, color: Colors.blue),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 16,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               // color: Colors.red,
//               height: 500,
//               width: double.infinity,
//               child: ListView.builder(
//                 itemCount: _quickSearchResults.length,
//                 itemBuilder: (context, index) {
//                   Office ofc = _quickSearchResults[index];
//                   return Card(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               Container(
//                                 height: 50,
//                                 width: 100,
//                                 decoration: BoxDecoration(
//                                     color: Colors.red.shade300,
//                                     borderRadius: BorderRadius.circular(10)),
//                                 child: Center(child: Text('${ofc.pinCode}')),
//                               ),
//                               SizedBox(
//                                 width: 16,
//                               ),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text('${ofc.ofcName}'),
//                                   Text('${ofc.taluka}, ${ofc.state}'),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: <Widget>[
//                               Icon(Icons.favorite),
//                               SizedBox(
//                                 width: 8,
//                               ),
//                               Icon(Icons.share),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
