import 'package:flutter/material.dart';

class NavItem1 extends StatefulWidget {
  const NavItem1({super.key});

  @override
  NavItem1State createState() => NavItem1State();
}

class NavItem1State extends State<NavItem1> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 59, 116, 61),
        title: const Text('Tickets'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _cards.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'INC-0000001 * Due Date',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 10),
                    ),
                    // const SizedBox(height: 20),
                    const Text(
                      'ST 00001 - Macaria Drive',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),

                    const Text(
                      'Created at March 10, 2023 10:10 AM',
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
                          const TableRow(
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
                                    'Agent name',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const TableRow(
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text('Store Account 1'),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text('John Ernest Japitana'),
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

  static where(Function(dynamic item) param0) {}
}
