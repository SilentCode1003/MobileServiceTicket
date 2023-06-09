import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ticket/config.dart';

class NavItem2 extends StatefulWidget {
  const NavItem2({Key? key, String? password, String? username}) : super(key: key);

  @override
  _AssignTicketListState createState() => _AssignTicketListState();
}

class _AssignTicketListState extends State<NavItem2> {
  List<dynamic> objects = [];
  List<dynamic> filteredObjects = [];

  @override
  void initState() {
    super.initState();
    fetchAssignTickets();
  }

  Future<void> fetchAssignTickets() async {
    try {
      final url = Uri.parse(Config.apiUrl + Config.loadAssignTicketAPI);
      final response = await http.get(url);

      debugPrint('$url');

      if (response.statusCode == 200) {
        setState(() {
          final responseData = json.decode(response.body);
          objects = responseData['data'] as List<dynamic>;
          filteredObjects = objects;

          debugPrint('Subject: $objects');
        });
      } else {
        throw Exception('Failed to load assigned tickets');
      }
    } catch (e) {
      debugPrint('Error loading assigned tickets: $e');
    }
  }

  void filterObjects(String query) {
    setState(() {
      filteredObjects = objects
          .where((object) =>
              object['ticketid'].toLowerCase().contains(query.toLowerCase()) ||
              object['concern'].toLowerCase().contains(query.toLowerCase()) ||
              object['ticketstatus']
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'History',
              ),
              SizedBox(width: 5),
              Tooltip(
                message: 'Tooltip Sample text',
                child: Icon(
                  Icons.help_outline,
                  size: 15,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                filterObjects(value);
              },
              decoration: const InputDecoration(
                labelText: 'Search',
                hintText: 'Search for a store...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredObjects.length,
              itemBuilder: (BuildContext context, int index) {
                final ticket = filteredObjects[index];
                String ticketid = ticket['ticketid'];
                String concern = ticket['concern'];
                String ticketstatus = ticket['ticketstatus'];
                String subject = ticket['subject'];
                String statusdetail = ticket['statusdetail'];
                String requestername = ticket['requestername'];
                String requesteremail = ticket['requesteremail'];
                String description = ticket['description'];
                String comment = ticket['comment'];
                String datecreated = ticket['datecreated'];
                String priority = ticket['priority'];
                String issue = ticket['issue'];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                          ticketid: ticketid,
                          concern: concern,
                          ticketstatus: ticketstatus,
                          subject: subject,
                          statusdetail: statusdetail,
                          requestername: requestername,
                          requesteremail: requesteremail,
                          description: description,
                          comment: comment,
                          datecreated: datecreated,
                          priority: priority,
                          issue: issue,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 5.0,
                      left: 10,
                      right: 10,
                    ),
                    child: Card(
                      elevation: 4.0,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              ticketstatus,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ticketstatus.toLowerCase() == 'new' ||
                                        ticketstatus.toUpperCase() == 'pending'
                                    ? const Color.fromARGB(255, 203, 7, 7)
                                    : ticketstatus.toLowerCase() == 'open'
                                        ? const Color.fromARGB(255, 68, 195, 72)
                                        : Colors.orange,
                              ),
                            ),
                            Text(
                              '$ticketid | $requestername',
                              textAlign: TextAlign.left,
                              style: const TextStyle(fontSize: 10),
                            ),
                            Text(
                              '$concern | $issue',
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 13,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  final String ticketid;
  final String concern;
  final String ticketstatus;
  final String subject;
  final String statusdetail;
  final String requestername;
  final String requesteremail;
  final String description;
  final String comment;
  final String datecreated;
  final String priority;
  final String issue;

  const DetailsScreen({
    super.key,
    required this.ticketid,
    required this.concern,
    required this.ticketstatus,
    required this.subject,
    required this.statusdetail,
    required this.requestername,
    required this.requesteremail,
    required this.description,
    required this.comment,
    required this.datecreated,
    required this.priority,
    required this.issue,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '$ticketid | $requestername',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blue),
                  ),
                  // const SizedBox(
                  //   width: 10,
                  // ),
                  // Text(
                  //   '$datecreated - $statusdetail',
                  //   textAlign: TextAlign.left,
                  //   style: const TextStyle(
                  //       fontWeight: FontWeight.bold, fontSize: 15),
                  // ),
                ],
              ),
              const Divider(
                color: Colors.black,
                thickness: 1.0,
                height: 30.0,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   '$datecreated - $statusdetail',
                        //   textAlign: TextAlign.left,
                        //   style: const TextStyle(
                        //       fontWeight: FontWeight.bold, fontSize: 15),
                        // ),

                        Text(
                          'Concern:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          'Issue:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          'Contact:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          'Description:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          'Comment:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          concern,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          issue,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          requesteremail,
                          style: const TextStyle(fontSize: 15),
                        ),
                        Text(
                          description,
                          style: const TextStyle(fontSize: 15),
                        ),
                        Text(
                          comment,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Row(
                children: [
                  Text(
                    'Findings:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 6.0),
                child: TextField(
                  maxLines: null, // Allows for multiple lines of text
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    labelText: 'Enter your findings',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     showDialog(
              //       context: context,
              //       builder: (BuildContext context) {
              //         return AlertDialog(
              //           title: Text('Dialog Box'),
              //           content: Text('This is a dialog box.'),
              //           actions: [
              //             TextButton(
              //               child: Text('Close'),
              //               onPressed: () {
              //                 Navigator.of(context).pop();
              //               },
              //             ),
              //           ],
              //         );
              //       },
              //     );
              //   },
              //   style: ElevatedButton.styleFrom(
              //     foregroundColor: Colors.white, backgroundColor: Colors.blue,
              //     elevation: 5,
              //     padding: const EdgeInsets.all(10),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //   ),
              //   child: const Text('Press me!'),
              // ),
              // ElevatedButton(
              //     onPressed: onPressed, child: const Text('Attachement'))
            ],
          ),
        ),
      ),
    );
  }
}
