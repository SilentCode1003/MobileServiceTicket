// import 'package:flutter/material.dart';
// import 'package:testapp/pages/navitem2.dart';

// class DetailPage extends StatefulWidget {
//   const DetailPage({super.key});

//   @override
//   _AssignTicketListState createState() => _AssignTicketListState();
// }

// class _AssignTicketListState extends State<DetailPage> {
//   List<dynamic> filteredObjects = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Assigned Tickets'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(top: 8.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: filteredObjects.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   final ticket = filteredObjects[index];
//                   String ticketid = ticket['ticketid'];
//                   String requestername = ticket['requestername'];
//                   String datecreated = ticket['datecreated'];
//                   String statusdetail = ticket['statusdetail'];

//                   return Padding(
//                     padding: const EdgeInsets.only(
//                         top: 1.0, bottom: 1.5, left: 10, right: 10),
//                     child: Card(
//                       child: Padding(
//                         padding: const EdgeInsets.only(
//                             top: 10.0, bottom: 10, left: 10, right: 10),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               '$ticketid - $statusdetail',
//                               textAlign: TextAlign.left,
//                               style: const TextStyle(fontSize: 10),
//                             ),
//                             // const SizedBox(height: 20),
//                             Text(
//                               requestername,
//                               textAlign: TextAlign.left,
//                               style: const TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 15),
//                             ),

//                             Text(
//                               datecreated,
//                               textAlign: TextAlign.left,
//                               style: const TextStyle(fontSize: 12),
//                             ),
//                             const Text(
//                               'Reffrence No. 10928319038',
//                               textAlign: TextAlign.left,
//                               style: TextStyle(fontSize: 10),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
