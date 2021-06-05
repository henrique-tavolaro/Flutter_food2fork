import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food2fork/Network/NetworkService.dart';
import 'package:food2fork/SearchBloc.dart';

import 'Screen/HomeSearch.dart';
import 'Screen/RecipeDetail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food 2 Fork',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<RecipeBloc>(
        create: (BuildContext context) {
          return RecipeBloc(NetworkService());
        },
      child: HomeSearch()
      // ,
      )
    );
  }
}
//
// class ChoiceChipDisplay extends StatefulWidget {
//   @override
//   _ChoiceChipDisplayState createState() => _ChoiceChipDisplayState();
// }
//
// class _ChoiceChipDisplayState extends State<ChoiceChipDisplay> {
//   List<String> chipList = [
//     "Recycled",
//     "Vegetarian",
//     "Skilled",
//     "Energetic",
//     "Friendly",
//     "Luxurious"
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return new Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Synonym Flashcards",
//           style: TextStyle(
//             color: Colors.black,
//           ),
//         ),
//         actions: <Widget>[
//
//         ],
//       ),
//       body: Center(
//         child: Material(
//           color: Colors.white,
//           elevation: 14.0,
//           borderRadius: BorderRadius.circular(24.0),
//           shadowColor: Color(0x802196F3),
//           child: Container(
//             width: 380,
//             height: 400,
//             child: Column(
//               children: <Widget>[
//                 Container(
//                   height: 50,
//                   width: MediaQuery.of(context).size.width,
//                   //color: new Color(0xffffc107),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12.0),
//                     color: Color(0xffffc107),
//                   ),
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       'Question 3',
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 24.0,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     child: Text(
//                       'Find the synonym of',
//                       style: TextStyle(color: Colors.black, fontSize: 18.0),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     child: Text(
//                       'Adroit',
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 42.0,
//                           fontWeight: FontWeight.w800),
//                     ),
//                   ),
//                 ),
//                 Container(
//                     child: Wrap(
//                       spacing: 5.0,
//                       runSpacing: 5.0,
//                       children: <Widget>[
//                         ChoiceChipWidget(chipList),
//                       ],
//                     )),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 32.0),
//                   child: Container(
//                     child: RaisedButton(
//                         color: Color(0xffffbf00),
//                         child: new Text(
//                           'Next',
//                           style: TextStyle(
//                               color: Color(0xffffffff),
//                               fontSize: 18.0,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         onPressed: () {},
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30.0))),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class ChoiceChipWidget extends StatefulWidget {
//   late final List<String> reportList;
//
//   ChoiceChipWidget(this.reportList);
//
//   @override
//   _ChoiceChipWidgetState createState() => new _ChoiceChipWidgetState();
// }
//
// class _ChoiceChipWidgetState extends State<ChoiceChipWidget> {
//   String selectedChoice = "";
//
//   _buildChoiceList() {
//     List<Widget> choices = [];
//     widget.reportList.forEach((item) {
//       choices.add(Container(
//         padding: const EdgeInsets.all(2.0),
//         child: ChoiceChip(
//           label: Text(item),
//           labelStyle: TextStyle(
//               color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30.0),
//           ),
//           backgroundColor: Color(0xffededed),
//           selectedColor: Color(0xffffc107),
//           selected: selectedChoice == item,
//           onSelected: (selected) {
//             setState(() {
//               selectedChoice = item;
//             });
//           },
//         ),
//       ));
//     });
//     return choices;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       children: _buildChoiceList(),
//     );
//   }
// }
//
