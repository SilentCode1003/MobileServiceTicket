import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NavItem1 extends StatefulWidget {
  const NavItem1({super.key});

  @override
  _AssignTicketListState createState() => _AssignTicketListState();
}

class _AssignTicketListState extends State<NavItem1> {
  final List<String> _cards = ['Card 1'];

  final List<String> _dropdownItems = ['Done', 'Pending', 'Cancelled'];
  String _selectedDropdownItem = 'Done';
  final List<String> _dropdownItems2 = ['High', 'Medium', 'Low'];
  String _selectedDropdownItem2 = 'High';

  void _addCard() {
    setState(() {
      _cards.add('Card ${_cards.length + 1}');
    });
  }

  void _deleteCard(int index) {
    setState(() {
      _cards.removeAt(index);
    });
  }

  List<dynamic> objects = [];

  @override
  void initState() {
    super.initState();
    fetchAssignTickets();
  }

  Future<void> fetchAssignTickets() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.20.161:3020/assignticket/load'));

      if (response.statusCode == 200) {
        setState(() {
          final responseData = json.decode(response.body);
          objects = responseData['data'] as List<dynamic>;

          print('Subject: $objects');
        });
      } else {
        throw Exception('Failed to load assigned tickets');
      }
    } catch (e) {
      print('Error loading assigned tickets: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assigned Tickets'),
      ),
      body: ListView.builder(
        itemCount: objects.length,
        itemBuilder: (BuildContext context, int index) {
          final ticket = objects[index];
          String statusdetail = ticket['statusdetail'];
          String ticketid = ticket['ticketid'];
          String requestername = ticket['requestername'];
          String datecreated = ticket['datecreated'];
          String assignedto = ticket['assignedto'];
          
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '$ticketid $statusdetail',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 10),
                    ),
                    // const SizedBox(height: 20),
                    Text(
                      '$requestername',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),

                    Text(
                      '$datecreated',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 12),
                    ),
                    const Text(
                      'Reffrence No. 10928319038',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 10),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Table(
                        children: [
                          TableRow(
                            children: [
                              TableCell(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Requester',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Agent Name',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                            ],
                          ),
                           TableRow(
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text('$requestername'),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text('$assignedto'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TableCell(
                                  child: DropdownButtonFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Status',
                                      border: OutlineInputBorder(),
                                    ),
                                    value: _selectedDropdownItem,
                                    items: _dropdownItems.map((item) {
                                      return DropdownMenuItem(
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedDropdownItem = value!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TableCell(
                                  child: DropdownButtonFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Priority',
                                      border: OutlineInputBorder(),
                                    ),
                                    value: _selectedDropdownItem2,
                                    items: _dropdownItems2.map((item) {
                                      return DropdownMenuItem(
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedDropdownItem2 = value!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _addCard,
            tooltip: 'Add Card',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 16.0),
          FloatingActionButton(
            onPressed: () => _deleteCard(_cards.length - 1),
            tooltip: 'Delete Card',
            backgroundColor: Colors.red,
            child: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
